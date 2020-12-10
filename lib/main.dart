import 'package:flutter/material.dart';
import 'framework/framework.dart';

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
          onPressed: () { startGame(context); },
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
