import 'package:flutter/material.dart';

const String stringNext = "Next";
const String stringStart = "Start";
const String stringContinue = "Continue";

class StoryWidget extends StatefulWidget {
  StoryWidget({Key key}) : super(key:key);

  @override
  StoryWidgetState createState() => StoryWidgetState();
}

class StoryWidgetState extends State<StoryWidget> {
  List<String> texts = [];
  Function onFinished;

  int textIndex = -1;
  String storyText = "";
  String buttonText = "";
  bool isVisible = false;
  bool isIntro = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this.isVisible,
      child: Column(
        children: <Widget>[
          Text(this.storyText),
          OutlinedButton(
            child: Text(this.buttonText),
            onPressed: this.onButtonPressed,
          ),
        ],
      ),
    );;
  }

  /// Starts the widget with the given content.
  void show(List<String> texts, Function onFinished, bool isIntro) {
    this.texts = texts;
    this.onFinished = onFinished;
    this.textIndex = -1;
    this.isIntro = isIntro;
    this.nextText();
  }

  /// Resets the content & hides the widget.
  void reset() {
    this.texts = [];
    this.onFinished = null;
    this.textIndex = -1;
    setState(() {
      this.isVisible = false;
      this.storyText = "";
      this.buttonText = "";
    });
  }

  /// Switches to the next text in the list & also updates the button text.
  void nextText() {
    this.textIndex++;
    setState(() {
      this.isVisible = true;
      this.storyText = this.texts[this.textIndex];
      if (this.textIndex == (this.texts.length - 1)) {
        if (this.isIntro) {
          this.buttonText = stringStart;
        } else {
          this.buttonText = stringContinue;
        }
      } else {
        this.buttonText = stringNext;
      }
    });
  }

  /// Callback for presses on the button.
  void onButtonPressed() {
    if (this.textIndex == (this.texts.length - 1)) {
      if (this.onFinished != null) {
        this.onFinished();
      }
      this.reset();
    } else {
      this.nextText();
    }
  }
}
