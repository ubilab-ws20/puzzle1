import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'framework/framework.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';

const String stringAppName = "Ubilab Scavenger Hunt";
const String stringTeamName = "Team Name";
const String stringNoTeamName = "Please enter a team name!";
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

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _controller = TextEditingController();

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
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: stringTeamName,
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
                  onPressed: () { startGame(context); },
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
    _controller.dispose();
    super.dispose();
  }

  void startGame(BuildContext context) {
    Game game = Game.getInstance();
    if (_controller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context){
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
    game.reset();
    game.setTeamName(_controller.text);
    Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
          reverseDuration: Duration(seconds: 1),
          child: GameMainScreen(),
        )
    );
  }
}
