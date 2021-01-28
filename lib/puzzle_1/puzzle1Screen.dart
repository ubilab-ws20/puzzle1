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

/// Bluetooth beacon UUIDs
const String idBeacon1_46 = "5CCD88B5-60A4-1990-F769-378BBDAB3D4D";
const String idBeacon2_2 = "7C05140C-8627-9D06-AEB7-FB9F172AFE2D";
const String idBeacon3_30 = "291216FB-CD5A-1B8C-748F-C78FE8979FF3";
const String idBeacon4_89 = "27CDCEB1-D951-036A-BA16-5652FFDB660C";
const String idBeacon5_51 = "C712B898-49AE-C751-C28F-B97469E5AAF1";
const String idBeacon6_73 = "A6022DE5-F851-9776-23A9-37C26B4695C4";

/// Convenience class for working with the Bluetooth beacons.
class Beacon {
  String name;
  String id;
  Function sound;
  double distance = -1;
  Beacon(this.name, this.id, this.sound);
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
    _beacons = [Beacon("1_46", idBeacon1_46, _playSecret1_46),
      Beacon("2_2", idBeacon2_2, _playSecret2_2),
      Beacon("3_30", idBeacon3_30, _playSecret3_30),
      Beacon("4_89", idBeacon4_89, _playSecret4_89),
      Beacon("5_51", idBeacon5_51, _playSecret5_51),
      Beacon("6_73", idBeacon6_73, _playSecret6_73)];
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
                _testSecretOrderHintStack(),
                _secretPickerRow1(),
                _secretPickerRow2(),
                _openButton(),
                Spacer(),
                Spacer(),
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
    _flutterBlue.startScan(timeout: Duration(seconds: 3));
  }

  /// Callback for discovered Bluetooth devices.
  void _onDevicesDiscovered(List<ScanResult> results) {
    List<bool> foundBeacons = [false, false, false, false, false, false];
    String id = "";
    int rssi = 0, idx = 0;
    for (ScanResult result in results) {
      id = result.device.id.id;
      rssi = result.rssi;
      idx = 0;
      for (Beacon beacon in _beacons) {
        if (beacon.id == id) {
          // Formula for distance based on rssi
          beacon.distance = pow(10, ((-69 - rssi) / (10 * 4)));
          foundBeacons[idx] = true;
        }
        idx++;
      }
    }
    idx = 0;
    for (bool found in foundBeacons) {
      if (!found) {
        _beacons[idx].distance = -1;
      }
      idx++;
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
      margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Image(
        image: AssetImage("assets/numberPickerHintScratches.png"),
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
      margin: EdgeInsets.only(top: 30.0),
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
      margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Stack(
        children: <Widget>[
          Image(
            image: AssetImage("assets/numberPickerHintScratches.png"),
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
