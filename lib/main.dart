import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/mqtt/MqttManager.dart';
import 'framework/framework.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';

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

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MQTTManager manager =
        MQTTManager(host: 'wss://earth.informatik.uni-freiburg.de/ubilab/ws/');
    manager.initialiseMQTTClient();

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
    manager.connect();
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
    manager.setTeamDetails(_nameController.text, _sizeController.text);
    //manager.setHintsUsed(game.getAlreadyUsedHints());
    game.setTeamSize(int.parse(_sizeController.text));
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.fade,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
      child: GameMainScreen(),
    ));
  }
}
