import 'package:flutter/material.dart';
import 'package:ubilab_scavenger_hunt/framework/startScreen.dart';

const String stringAppName = "Ubilab Scavenger Hunt";
const String stringTeamName = "Team name";
const String stringTeamSize = "Number of members";
const String stringNoTeamName = "Please enter a team name!";
const String stringNoTeamSize = "Please enter the number of team members!";
const String stringStart = "Start";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: stringAppName,
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
      },
    );
  }
}
