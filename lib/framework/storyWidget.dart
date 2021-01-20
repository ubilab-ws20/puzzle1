import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';

const String stringNext = "Next";
const String stringStart = "Start";
const String stringContinue = "Continue";

class StoryWidget extends StatefulWidget {
  StoryWidget({Key key}) : super(key:key);

  @override
  StoryWidgetState createState() => StoryWidgetState();
}

class StoryWidgetState extends State<StoryWidget> {
  List<String> _texts = [];
  Function _onFinished;

  int _textIndex = 0;
  String _storyText = "";
  String _buttonText = stringNext;
  bool _isVisible = false;
  bool _isIntro = true;

  @override
  Widget build(BuildContext context) {
    Game game = Game.getInstance();
    if (game.start()) {
      _isVisible = true;
      _texts = game.gameStartTexts;
      _storyText = _texts[_textIndex];
      _onFinished = game.nextState;
    }
    return Visibility(
      visible: _isVisible,
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: <Widget>[
            _text(),
            _button(),
          ],
        ),
      ),
    );
  }

  /// Starts the widget with the given content.
  void show(List<String> texts, Function onFinished, bool isIntro) {
    _texts = texts;
    _onFinished = onFinished;
    _textIndex = -1;
    _isIntro = isIntro;
    _nextText();
    Vibration.vibrate(duration: 500);
  }

  /// Resets the content & hides the widget.
  void reset() {
    _texts = [];
    _onFinished = null;
    _textIndex = -1;
    setState(() {
      _isVisible = false;
      _storyText = "";
      _buttonText = "";
    });
  }

  /// Switches to the next text in the list & also updates the button text.
  void _nextText() {
    _textIndex++;
    setState(() {
      _isVisible = true;
      _storyText = _texts[_textIndex];
      if (_textIndex == (_texts.length - 1)) {
        if (_isIntro) {
          _buttonText = stringStart;
        } else {
          _buttonText = stringContinue;
        }
      } else {
        _buttonText = stringNext;
      }
    });
  }

  /// Callback for presses on the button.
  void _onButtonPressed() {
    if (_textIndex == (_texts.length - 1)) {
      if (_onFinished != null) {
        _onFinished();
      }
      reset();
    } else {
      _nextText();
    }
  }

  /// Creates the Container containing the story text object.
  Widget _text() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
      child: Text(_storyText,
        style: TextStyle(
          fontFamily: "marker felt",
          fontSize: 20,
        ),
      ),
    );
  }

  /// Creates the Container containing the story text button.
  Widget _button() {
    return Container(
      margin: EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
      child: OutlinedButton(
        child: Text(_buttonText),
        onPressed: _onButtonPressed,
      ),
    );
  }
}
