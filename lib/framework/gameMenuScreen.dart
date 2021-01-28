import 'package:flutter/material.dart';
import 'dart:async';
import 'game.dart';
import 'gameProgressBar.dart';

const String stringProgress = "Progress";
const String stringQuitGame = "Quit Game";
const String stringReallyQuit = "Are you sure you want to quit and give up?";
const String stringQuit = "Quit";
const String stringCancel = "Cancel";
const String stringStorySoFar = "Story so far:";

/// Method to get the game menu icon button s.t. it always looks the same.
Widget gameMenuIconButton(BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.menu_book_outlined,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return GameMenuScreen();
          }
        )
      );
    },
  );
}

class GameMenuScreen extends StatefulWidget {
  @override
  _GameMenuScreenState createState() => _GameMenuScreenState();
}

class _GameMenuScreenState extends State<GameMenuScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(new Duration(milliseconds: 25), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stringProgress),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GameProgressBar(),
            _teamName(),
            Divider(),
            _alreadyUsedHints(),
            Divider(),
            _alreadyPlayedTime(),
            Divider(),
            _storySoFar(),
            _alreadyShownTexts(),
            _quitGameButton(context),
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
      builder: (BuildContext context){
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
              }
            ),
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
            ]
          ),
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
    String wholeText = "";
    List<String> texts = Game.getInstance().getAlreadyShownTexts();
    for (String text in texts) {
      wholeText += text + "\n\n";
    }
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 30.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Text(
              wholeText,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }

  /// Quit game button.
  Widget _quitGameButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: OutlinedButton(
        child: Text(
          stringQuitGame,
          style: TextStyle(fontSize: 35.0),
        ),
        onPressed: () { _onQuitGamePressed(context); },
      ),
    );
  }
}
