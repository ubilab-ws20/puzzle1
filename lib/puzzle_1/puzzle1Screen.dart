import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1.dart';
import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'dart:async';
import 'dart:math';

const String stringScreenName = "The Vault";
const String stringSubmitButtonText = "Open";
const String stringNotSolved = "Wrong combination.";

/// Bluetooth beacon MAC addresses
const List<int> macBeacon1_46 = [0xC9, 0x96, 0xD9, 0xA0, 0xEC, 0xB2];
const List<int> macBeacon2_2 = [0xDB, 0xCD, 0xDF, 0x5A, 0xE1, 0xC7];
const List<int> macBeacon3_30 = [0xE8, 0x63, 0x97, 0xD4, 0xEB, 0x3B];
const List<int> macBeacon4_89 = [0xD9, 0xF5, 0xB7, 0xB1, 0x57, 0x64];
const List<int> macBeacon5_51 = [0xCB, 0x69, 0x61, 0x67, 0xA9, 0xB9];
const List<int> macBeacon6_73 = [0xEB, 0x65, 0x46, 0x4A, 0x5E, 0x21];

/// Convenience class for working with the Bluetooth beacons.
class Beacon {
  String name;
  List<int> mac;
  Function sound;
  double distance = -1;

  Beacon(this.name, this.mac, this.sound);

  bool isMacInData(List<int> data) {
    if (data.length < 6) {
      return false;
    }
    for (int i = 1; i <= 6; i++) {
      if (data[data.length - i] != mac[mac.length - i]) {
        return false;
      }
    }
    return true;
  }
}

/// Wrapper class for int secrets for passing by reference.
class Secret {
  int val;
  Secret(this.val);
}

class Puzzle1Screen extends StatefulWidget {
  @override
  _Puzzle1ScreenState createState() => _Puzzle1ScreenState();
}

class _Puzzle1ScreenState extends State<Puzzle1Screen> {
  FlutterBlue _flutterBlue;
  Timer _beaconHandleTimer;
  List<Beacon> _beacons;
  final double _maxBeaconDist = 5;

  final List<int> _solutions = [46, 2, 30, 89, 51, 73];
  List<Secret> _secrets = [Secret(50), Secret(50), Secret(50), Secret(50), Secret(50), Secret(50)];
  final _pickerMin = 0;
  final _pickerMax = 100;

  bool _firstSoundPlayed = false;
  List<bool> _soundsPlayed = [false, false, false, false, false, false];
  bool _scratchHintsSent = false;

  @override
  void initState() {
    super.initState();
    // Timer for beacon handling
    _beaconHandleTimer = new Timer.periodic(new Duration(seconds: 5), (timer) {
      _handleBeacons();
    });
    // Bluetooth module
    _flutterBlue = FlutterBlue.instance;
    _flutterBlue.scanResults.listen((results) {
      _onDevicesDiscovered(results);
    });
    _beacons = [Beacon("1_46", macBeacon1_46, _playSecret1_46),
      Beacon("2_2", macBeacon2_2, _playSecret2_2),
      Beacon("3_30", macBeacon3_30, _playSecret3_30),
      Beacon("4_89", macBeacon4_89, _playSecret4_89),
      Beacon("5_51", macBeacon5_51, _playSecret5_51),
      Beacon("6_73", macBeacon6_73, _playSecret6_73)];
    // Hints
    Game.getInstance().updateCurrentHints(Puzzle1.getInstance().hintTexts1FindSounds);
  }

  @override
  void deactivate() {
    _beaconHandleTimer.cancel();
    _flutterBlue.stopScan();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(stringScreenName),
          automaticallyImplyLeading: false,
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/vault.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _secretPickerRow1(),
                    _secretPickerRow2(),
                  ],
                ),
                _openButton(),
                Expanded(
                  child: _testSecretOrderHintStack(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Callback when the button to submit the solution is pressed.
  void _onOpenPressed(BuildContext context) {
    if (!_areSecretsCorrect()) {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(
              stringNotSolved,
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      return;
    }
    Puzzle1.getInstance().onFinished();
    Navigator.of(context).pop();
  }

  /// Checks if all currently set secrets are the correct solutions.
  bool _areSecretsCorrect() {
    for (int i = 0; i < _secrets.length; i++) {
      if (_secrets[i].val != _solutions[i]) {
        return false;
      }
    }
    return true;
  }

  // Functions for playing sounds

  /// Async method for playing the specified sound.
  Future<AudioPlayer> _playSecret(String assetName) async {
    AudioCache cache = new AudioCache(prefix: "assets/audio/");
    return await cache.play(assetName);
  }

  /// Method for scanning for the Bluetooth beacons triggering the sounds.
  void _handleBeacons() {
    _playClosestBeaconSound();
    for (Beacon beacon in _beacons) {
      beacon.distance = -1;
    }
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  /// Callback for discovered Bluetooth devices.
  void _onDevicesDiscovered(List<ScanResult> results) {
    int rssi = 0;
    List<int> data;
    for (ScanResult result in results) {
      if (!result.advertisementData.manufacturerData.containsKey(1177)) {
        continue;
      }
      data = result.advertisementData.manufacturerData[1177];
      rssi = result.rssi;
      for (Beacon beacon in _beacons) {
        if (beacon.isMacInData(data)) {
          // Formula for distance based on rssi
          beacon.distance = pow(10, ((-69 - rssi) / (10 * 4)));
          break;
        }
      }
    }
  }

  /// Plays the sound for the closest beacon in range.
  void _playClosestBeaconSound() {
    double closestDist = 100;
    Beacon closestBeacon;
    for (Beacon beacon in _beacons) {
      if (beacon.distance == -1) {
        continue;
      }
      if (beacon.distance < closestDist) {
        closestDist = beacon.distance;
        closestBeacon = beacon;
      }
    }
    if ((closestBeacon != null) && (closestBeacon.distance <= _maxBeaconDist)) {
      print("Beacon ${closestBeacon.name} is closest!");
      closestBeacon.sound();
    } else {
      if (closestBeacon == null) {
        print("No beacon found to play sound!");
      } else {
        print("No beacon in range to play sound!");
      }
    }
  }

  /// Plays the sound for secret 1.
  /// 46
  void _playSecret1_46() async {
    await _playSecret("46.mp3");
    _soundsPlayed[0] = true;
    _soundPlayed();
    print("Play sound 1 (46)");
  }

  /// Plays the sound for secret 2.
  /// 2
  void _playSecret2_2() async {
    await _playSecret("2.mp3");
    _soundsPlayed[1] = true;
    _soundPlayed();
    print("Play sound 2 (2)");
  }

  /// Plays the sound for secret 3.
  /// 30
  void _playSecret3_30() async {
    await _playSecret("30.mp3");
    _soundsPlayed[2] = true;
    _soundPlayed();
    print("Play sound 3 (30)");
  }

  /// Plays the sound for secret 4.
  /// 89
  void _playSecret4_89() async {
    await _playSecret("89.mp3");
    _soundsPlayed[3] = true;
    _soundPlayed();
    print("Play sound 4 (89)");
  }

  /// Plays the sound for secret 5.
  /// 51
  void _playSecret5_51() async {
    await _playSecret("51.mp3");
    _soundsPlayed[4] = true;
    _soundPlayed();
    print("Play sound 5 (51)");
  }

  /// Plays the sound for secret 6.
  /// 73
  void _playSecret6_73() async {
    await _playSecret("73.mp3");
    _soundsPlayed[5] = true;
    _soundPlayed();
    print("Play sound 6 (73)");
  }

  void _soundPlayed() {
    bool allSoundsPlayed = true;
    if (!_firstSoundPlayed) {
      _firstSoundPlayed = true;
      Game.getInstance().updateCurrentHints(Puzzle1.getInstance().hintTexts2FindAllSounds);
    }
    for (int i = 0; i < _soundsPlayed.length; i++) {
      if (!_soundsPlayed[i]) {
        allSoundsPlayed = false;
        break;
      }
    }
    if (allSoundsPlayed && !_scratchHintsSent) {
      Game.getInstance().updateCurrentHints(Puzzle1.getInstance().hintTexts3SecretOrder);
      _scratchHintsSent = true;
    }
  }

  // Construction methods for parts of the screen

  Widget _secretOrderHint() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
      alignment: Alignment.center,
      child: Center(
        child: Image(
          image: AssetImage("assets/numberPickerHintScratches.png"),
        ),
      ),
    );
  }

  /// Creates the first row of secret pickers.
  Widget _secretPickerRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _secretPicker(_secrets[0]),
        _secretPicker(_secrets[1]),
        _secretPicker(_secrets[2]),
      ],
    );
  }

  /// Creates the second row of secret pickers.
  Widget _secretPickerRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _secretPicker(_secrets[3]),
        _secretPicker(_secrets[4]),
        _secretPicker(_secrets[5]),
      ],
    );
  }

  /// Creates a single secret picker.
  Widget _secretPicker(Secret secret) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: NumberPicker.integer(
        initialValue: secret.val,
        minValue: _pickerMin,
        maxValue: _pickerMax,
        onChanged: (newValue) {
          setState(() {
            secret.val = newValue;
          });
        },
        textStyle: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        selectedTextStyle: TextStyle(
          fontSize: 25.0,
          color: Colors.orangeAccent,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Creates the open button for submitting the secrets.
  Widget _openButton() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
        ),
        child: Text(
          stringSubmitButtonText,
          style: TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        onPressed: () { _onOpenPressed(context); },
      ),
    );
  }

  // Functions for development & testing

  Widget _testSecretOrderHintStack() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
      child: Stack(
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage("assets/numberPickerHintScratches.png"),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _testSoundButtonRow1(),
              _testSoundButtonRow2(),
              _testQuitButton(),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates the first row of secret sound test buttons.
  Widget _testSoundButtonRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _testSoundButton("1", _playSecret1_46),
        _testSoundButton("2", _playSecret2_2),
        _testSoundButton("3", _playSecret3_30),
      ],
    );
  }

  /// Creates the second row of secret sound test buttons.
  Widget _testSoundButtonRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _testSoundButton("4", _playSecret4_89),
        _testSoundButton("5", _playSecret5_51),
        _testSoundButton("6", _playSecret6_73),
      ],
    );
  }

  /// Creates a test button with the specified text and callback function.
  Widget _testSoundButton(String buttonText, Function onButtonPressed) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: OutlinedButton(
        child: Text(buttonText),
        onPressed: onButtonPressed,
      ),
    );
  }

  /// Creates a test button to quit and leave the puzzle.
  Widget _testQuitButton() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: OutlinedButton(
        child: Text("Quit"),
        onPressed: () {
          Puzzle1.getInstance().onFinished();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
