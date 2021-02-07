import 'package:flutter/material.dart';
import 'dart:async';
import 'game.dart';
import 'gameProgressBar.dart';
import 'package:ubilab_scavenger_hunt/globals.dart';
import 'storyText.dart';
import 'hintScreen.dart';

final String stringProgress = "Progress";
final String stringQuitGame = "Quit Game";
final String stringReallyQuit = "Are you sure you want to quit and give up?";
final String stringQuit = "Quit";
final String stringCancel = "Cancel";
final String stringStorySoFar = "Story so far:";

/// Method to get the game menu icon button s.t. it always looks the same.
Widget gameMenuIconButton(BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.menu_book_outlined,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (BuildContext context) {
        return GameMenuScreen();
      }));
    },
  );
}

class GameMenuScreen extends StatefulWidget {
  @override
  _GameMenuScreenState createState() => _GameMenuScreenState();
}

class _GameMenuScreenState extends State<GameMenuScreen> {
  Timer _timer;
  List<StoryText> _storyTexts;

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(new Duration(milliseconds: 25), (timer) {
      setState(() {});
    });
    _storyTexts = Game.getInstance().getAlreadyShownTexts();
    for (StoryText storyText in _storyTexts) {
      if (!storyText.text.endsWith("\n\n")) {
        if (storyText.text.endsWith("\n")) {
          storyText.text += "\n";
        } else {
          storyText.text += "\n\n";
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stringProgress),
        actions: [
          hintIconButton(context),
          _quitGameButton(context),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            GameProgressBar(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _teamName(),
                  _alreadyUsedHints(),
                  _alreadyPlayedTime(),
                  _storySoFar(),
                  _alreadyShownTexts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// Callback when quit game is pressed.
  void _onQuitGamePressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            stringReallyQuit,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(stringCancel),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text(stringQuit),
              onPressed: () {
                Game.getInstance().reset();
                Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
              },
            ),
          ],
        );
      },
    );
  }

  /// Container with game menu team name entry.
  Widget _teamName() {
    Game game = Game.getInstance();
    String teamName = game.getTeamName();
    String teamSize = "";
    if (game.getTeamSize() == 1) {
      teamSize += "(1 member)";
    } else {
      teamSize += "(" + game.getTeamSize().toString() + " members)";
    }
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.person,
              size: 30.0,
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  teamName,
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  teamSize,
                  style: TextStyle(fontSize: 25.0),
                ),
              ]),
        ],
      ),
    );
  }

  /// Container with game menu already played time entry.
  Widget _alreadyPlayedTime() {
    String teamName = Game.getInstance().getAlreadyPlayedTime();
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.timelapse,
              size: 30.0,
            ),
          ),
          Text(
            teamName,
            style: TextStyle(fontSize: 25.0),
          ),
        ],
      ),
    );
  }

  /// Container with game menu team name entry.
  Widget _alreadyUsedHints() {
    String usedHints = Game.getInstance().getAlreadyUsedHints();
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.help,
              size: 30.0,
            ),
          ),
          Text(
            usedHints,
            style: TextStyle(fontSize: 25.0),
          ),
        ],
      ),
    );
  }

  /// Container with story so far entry.
  Widget _storySoFar() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 30.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.book,
              size: 30.0,
            ),
          ),
          Text(
            stringStorySoFar,
            style: TextStyle(fontSize: 25.0),
          ),
        ],
      ),
    );
  }

  /// Expanded Container with all already shown story texts.
  Widget _alreadyShownTexts() {
    List<TextSpan> textSpans = [];
    String font = "";
    for (StoryText storyText in _storyTexts) {
      if (storyText.fromAi) {
        font = fontAi;
      } else {
        font = fontNarration;
      }
      textSpans.add(TextSpan(
        text: storyText.text,
        style: TextStyle(
          fontFamily: font,
          color: Colors.black,
          fontSize: 15.0,
        ),
      ));
    }
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 30.0),
      child: RichText(
        text: TextSpan(
          children: textSpans,
        ),
      ),
    );
  }

  /// Quit game button.
  Widget _quitGameButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.exit_to_app_rounded,
        color: Colors.white,
      ),
      onPressed: () {
        _onQuitGamePressed(context);
      },
    );
  }
}
