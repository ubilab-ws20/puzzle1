import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1.dart';
import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';

const String stringScreenName = "The Vault";
const String stringSubmitButtonText = "Open";
const String stringNotSolved = "Wrong combination.";

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
  final List<int> _solutions = [46, 2, 30, 89, 51, 73];
  final _pickerMin = 0;
  final _pickerMax = 100;
  bool _firstSoundPlayed = false;
  List<bool> _soundsPlayed = [false, false, false, false, false, false];


  List<Secret> _secrets = [Secret(50), Secret(50), Secret(50), Secret(50), Secret(50), Secret(50)];

  @override
  void initState() {
    super.initState();
    Game.getInstance().updateCurrentHints(Puzzle1.getInstance().hintTexts1FindSounds);
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

  /// Plays the sound for secret 1.
  /// 46
  void _playSecret1() async {
    await _playSecret("46.mp3");
    _soundsPlayed[0] = true;
    _soundPlayed();
    print("<secret 1 sound>");
  }

  /// Plays the sound for secret 2.
  /// 2
  void _playSecret2() async {
    await _playSecret("2.mp3");
    _soundsPlayed[1] = true;
    _soundPlayed();
    print("<secret 2 sound>");
  }

  /// Plays the sound for secret 3.
  /// 30
  void _playSecret3() async {
    await _playSecret("30.mp3");
    _soundsPlayed[2] = true;
    _soundPlayed();
    print("<secret 3 sound>");
  }

  /// Plays the sound for secret 4.
  /// 89
  void _playSecret4() async {
    await _playSecret("89.mp3");
    _soundsPlayed[3] = true;
    _soundPlayed();
    print("<secret 4 sound>");
  }

  /// Plays the sound for secret 5.
  /// 51
  void _playSecret5() async {
    await _playSecret("51.mp3");
    _soundsPlayed[4] = true;
    _soundPlayed();
    print("<secret 5 sound>");
  }

  /// Plays the sound for secret 6.
  /// 73
  void _playSecret6() async {
    await _playSecret("73.mp3");
    _soundsPlayed[5] = true;
    _soundPlayed();
    print("<secret 6 sound>");
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
    if (allSoundsPlayed) {
      Game.getInstance().updateCurrentHints(Puzzle1.getInstance().hintTexts3SecretOrder);
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
        _testSoundButton("1", _playSecret1),
        _testSoundButton("2", _playSecret2),
        _testSoundButton("3", _playSecret3),
      ],
    );
  }

  /// Creates the second row of secret sound test buttons.
  Widget _testSoundButtonRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _testSoundButton("4", _playSecret4),
        _testSoundButton("5", _playSecret5),
        _testSoundButton("6", _playSecret6),
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
