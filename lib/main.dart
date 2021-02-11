import 'package:flutter/material.dart';
import 'package:ubilab_scavenger_hunt/framework/startScreen.dart';

final String stringAppName = "Prof. Y";
final String stringTeamName = "Team name";
final String stringTeamSize = "Number of members";
final String stringNoTeamName = "Please enter a team name!";
final String stringNoTeamSize = "Please enter the number of team members!";
final String stringStart = "Start";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: stringAppName,
      theme: ThemeData(
        primaryColor: Color(0xFF4E8973),
        accentColor: Color(0xFF69C869),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
      },
    );
  }
}
