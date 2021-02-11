import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2MainScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/beaconScanner.dart';
import 'package:ubilab_scavenger_hunt/globals.dart';
import 'puzzle2.dart';

class Puzzle2Screen4 extends StatefulWidget {
  @override
  Puzzle2Screen4State createState() => Puzzle2Screen4State();
}

class Puzzle2Screen4State extends State<Puzzle2Screen4> {
  bool puzzle2_4_solved = false;
  BeaconScanner _beaconScanner;
  final double _maxBeaconDist = 20;

  List<String> hintTexts = [
    "{1000101011}",
    "A place to read & where you shouldn't make noise.",
    "Go to the library in the building 101.",
    "Are you at the back entrance of the Library?"
  ];

  ///false=not in range
  bool bleRange = false;

  @override
  void initState() {
    super.initState();
    _beaconScanner = BeaconScanner.getInstance();
    _beaconScanner.start(_closestBeaconCallback, _maxBeaconDist);
    Game.getInstance().updateCurrentHints(hintTexts);
  }

  @override
  void deactivate() {
    _beaconScanner.stop();
    super.deactivate();
  }

  /// Callback for the beacon scanner when a closest beacon is found.
  void _closestBeaconCallback(String beaconName) {
    if ((beaconName == "p2_00") ||
        (beaconName == "p2_01") ||
        (beaconName == "p2_02")) {
      setState(() {
        ///ble beacon in range
        bleRange = true;
      });
    } else {
      ///do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Puzzle2Variables.title2_4),
            actions: [
              hintIconButton(context),
              gameMenuIconButton(context),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  Puzzle2Variables.story2_4_1,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: 'VT323', fontSize: 18.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  bleRange == false
                      ? 'You are in a wrong location.'
                      : 'Location reached, your are ready to fire the signal.',
                  style: TextStyle(fontFamily: 'VT323', fontSize: 18.0),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: RaisedButton.icon(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    if (bleRange == false) {
                      ///not in range dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Reach the correct location and fire the signal.',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    } else if (bleRange == true) {
                      puzzle2_4_solved = true;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Puzzle solved. \r\nEMP signal fired!',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    }
                  },
                  icon: Icon(
                    Icons.wifi,
                    color: Colors.white,
                    size: 22.0,
                  ),
                  label: Text(
                    'Fire EMP signal',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                  color: Colors.blue,
                ),
              ),

              ///test button
              quit(),

              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton.icon(
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          if (puzzle2_4_solved == false) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Solve the puzzle to proceed.',
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            );
                          } else if (puzzle2_4_solved == true) {
                            List<StoryText> textInsidePuzzle2_4_1 = [
                              StoryText(Puzzle2Variables.story2_4_1, true),
                              StoryText(Puzzle2Variables.story2_4_2, true),
                            ];
                            Puzzle2Variables.subPuzzle = 5;
                            Game.getInstance()
                                .addTextsToAlreadyShown(textInsidePuzzle2_4_1);
                            Puzzle2MainScreenState.getInstance()
                                .setStateCallback();
                            Navigator.of(context).pop();
                            Puzzle2.getInstance().onFinished();
                            Navigator.of(context).pop();
                          }
                        },
                        icon: Icon(
                          Icons.next_plan_outlined,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        label: Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0),
                        ),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget quit() {
    if (globalIsTesting) {
      return Container(
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: RaisedButton.icon(
          padding: EdgeInsets.all(10),
          onPressed: () {
            puzzle2_4_solved = true;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'TEST\r\nPuzzle solved. \r\nEMP signal fired!',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          },
          icon: Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 16.0,
          ),
          label: Text(
            'Solve, TEST button',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
          color: Colors.blue,
        ),
      );
    } else {
      return Container();
    }
  }
}
