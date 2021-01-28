import 'package:flutter/material.dart';
import 'game.dart';

class GameProgressBar extends StatefulWidget {
  GameProgressBar({Key key}) : super(key:key);

  @override
  GameProgressBarState createState() => GameProgressBarState();
}

class GameProgressBarState extends State<GameProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        value: Game.getInstance().getProgress(),
        minHeight: 20,
        backgroundColor: Colors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  void setStateCallback() {
    setState(() {});
  }
}
