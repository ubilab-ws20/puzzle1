import 'package:flutter/material.dart';
import 'framework/framework.dart';

// TODO:
// - Ask if game really wants to be quitted
// - Add input for player information
// - Create framework class for handling the game logic
// - Create state machine to guide through the game

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ubilab Scavenger Hunt",
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ubilab Scavenger Hunt")),
      body: Center(
        child: OutlinedButton(
          child: Text(
            "Start Game",
            style: TextStyle(fontSize: 40),
            ),
          onPressed: () { this.startGame(context); },
        ),
      )
    );
  }

  void startGame(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return GameMainScreen();
      })
    );
  }
}
