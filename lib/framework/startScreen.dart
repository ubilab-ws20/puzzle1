import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubilab_scavenger_hunt/mqtt/MqttManager.dart';
import 'package:ubilab_scavenger_hunt/framework/introScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'dart:async';

import 'package:ubilab_scavenger_hunt/globals.dart';

final String stringAppName = "Prof. Y";
final String stringTeamName = "Team name";
final String stringTeamSize = "Number of members";
final String stringNoTeamName = "Please enter a team name!";
final String stringNoTeamSize = "Please enter the number of team members!";
final String stringStart = "Start";
var listTeamDetails = [];

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(title: Text(stringAppName)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: stringTeamName,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: TextField(
                  controller: _sizeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: stringTeamSize,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: OutlinedButton(
                  child: Text(
                    stringStart,
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () {
                    startGame(context, manager);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void startGame(BuildContext context, MQTTManager manager) {
    Game game = Game.getInstance();
    //manager.connect();
    if (_nameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              stringNoTeamName,
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      return;
    }
    if (_sizeController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              stringNoTeamSize,
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      return;
    }
    game.reset();
    game.setTeamName(_nameController.text);
    game.setTeamSize(int.parse(_sizeController.text));
    print(game.getProgress());
    globalTeamName = _nameController.text;
    Timer.periodic(Duration(seconds: 10), (timer) {
      listTeamDetails.add(_nameController.text);
      listTeamDetails.add(_sizeController.text);
      listTeamDetails.add(game.getAlreadyUsedHints());
      listTeamDetails.add(game.getProgress().toString());
      listTeamDetails.add(game.getCurrentPuzzleInfo().toString());
      manager.updateDetail(listTeamDetails);
    });
    //
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return IntroScreen();
    }));
  }
}
