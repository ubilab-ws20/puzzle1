import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ubilab_scavenger_hunt/globals.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1.dart';
import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'package:ubilab_scavenger_hunt/framework/beaconScanner.dart';

final String stringScreenName = "The Vault";
final String stringSubmitButtonText = "Open";
final String stringNotSolved = "Wrong combination.";

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
  BeaconScanner _beaconScanner;
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
    _beaconScanner = BeaconScanner.getInstance();
    _beaconScanner.start(_closestBeaconCallback, _maxBeaconDist);
    Game.getInstance().updateCurrentHints(Puzzle1.getInstance().hintTexts1FindSounds);
  }

  @override
  void deactivate() {
    _beaconScanner.stop();
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
                  child: _secretOrderHint(),
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

  /// Callback for the beacon scanner when a closest beacon is found.
  void _closestBeaconCallback(String beaconName) {
    if (beaconName == "p1_1_46") {
      _playSecret1_46();
    } else if (beaconName == "p1_2_2") {
      _playSecret2_2();
    } else if (beaconName == "p1_3_30") {
      _playSecret3_30();
    } else if (beaconName == "p1_4_89") {
      _playSecret4_89();
    } else if (beaconName == "p1_5_51") {
      _playSecret5_51();
    } else if (beaconName == "p1_6_73") {
      _playSecret6_73();
    }
  }

  // Functions for playing sounds

  /// Async method for playing the specified sound.
  Future<AudioPlayer> _playSecret(String assetName) async {
    AudioCache cache = new AudioCache(prefix: "assets/audio/");
    return await cache.play(assetName);
  }

  /// Plays the sound for secret 1.
  /// 46
  void _playSecret1_46() async {
    await _playSecret("46.mp3");
    _soundsPlayed[0] = true;
    _soundPlayed();
    if (globalIsTesting) {
      print("Puzzle 1: Play sound 1 (46)");
    }
  }

  /// Plays the sound for secret 2.
  /// 2
  void _playSecret2_2() async {
    await _playSecret("2.mp3");
    _soundsPlayed[1] = true;
    _soundPlayed();
    if (globalIsTesting) {
      print("Puzzle 1: Play sound 2 (2)");
    }
  }

  /// Plays the sound for secret 3.
  /// 30
  void _playSecret3_30() async {
    await _playSecret("30.mp3");
    _soundsPlayed[2] = true;
    _soundPlayed();
    if (globalIsTesting) {
      print("Puzzle 1: Play sound 3 (30)");
    }
  }

  /// Plays the sound for secret 4.
  /// 89
  void _playSecret4_89() async {
    await _playSecret("89.mp3");
    _soundsPlayed[3] = true;
    _soundPlayed();
    if (globalIsTesting) {
      print("Puzzle 1: Play sound 4 (89)");
    }
  }

  /// Plays the sound for secret 5.
  /// 51
  void _playSecret5_51() async {
    await _playSecret("51.mp3");
    _soundsPlayed[4] = true;
    _soundPlayed();
    if (globalIsTesting) {
      print("Puzzle 1: Play sound 5 (51)");
    }
  }

  /// Plays the sound for secret 6.
  /// 73
  void _playSecret6_73() async {
    await _playSecret("73.mp3");
    _soundsPlayed[5] = true;
    _soundPlayed();
    if (globalIsTesting) {
      print("Puzzle 1: Play sound 6 (73)");
    }
  }

  /// Updates the current hints according to how many sounds were already found.
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

  /// Creates the image widget with the hint for the order of the numbers.
  Widget _secretOrderHint() {
    if (globalIsTesting) {
      return _testSecretOrderHintStack();
    }
    return Container(
      margin: EdgeInsets.all(10.0),
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
      margin: EdgeInsets.all(2.0),
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
          fontSize: 12.0,
          color: Colors.black,
        ),
        selectedTextStyle: TextStyle(
          fontSize: 22.0,
          color: Colors.orangeAccent,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Creates the open button for submitting the secrets.
  Widget _openButton() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
        ),
        child: Text(
          stringSubmitButtonText,
          style: TextStyle(
            fontSize: 35.0,
            color: Colors.black,
          ),
        ),
        onPressed: () { _onOpenPressed(context); },
      ),
    );
  }

  // Functions for development & testing

  /// Creates a stack with some testing buttons put over the number order hint image.
  Widget _testSecretOrderHintStack() {
    return Container(
      margin: EdgeInsets.all(10.0),
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
      margin: EdgeInsets.only(left: 2.0, right: 2.0),
      child: OutlinedButton(
        child: Text(buttonText),
        onPressed: onButtonPressed,
      ),
    );
  }

  /// Creates a test button to quit and leave the puzzle.
  Widget _testQuitButton() {
    return Container(
      margin: EdgeInsets.only(left: 2.0, right: 2.0),
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
