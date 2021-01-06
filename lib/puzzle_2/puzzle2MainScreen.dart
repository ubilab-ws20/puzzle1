import 'package:flutter/material.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';

import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen3.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen4.dart';

class Puzzle2MainScreen extends StatefulWidget {
  @override
  Puzzle2MainScreenState createState() => Puzzle2MainScreenState();
}

class Puzzle2MainScreenState extends State<Puzzle2MainScreen> {
  static Puzzle2MainScreenState _instance;

  Puzzle2MainScreenState() {
    _instance = this;
  }

  /// Static singleton method.
  static Puzzle2MainScreenState getInstance() {
    if (_instance == null) {
      _instance = Puzzle2MainScreenState();
    }
    return _instance;
  }

  void setStateCallback() {
    setState(() {
      // Puzzle2Variables.puzzle2_1Staus == 'green' ? Puzzle2Variables.puzzle2_1Staus = 'red' : Puzzle2Variables.puzzle2_1Staus = 'green';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Puzzle 2'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Puzzle 2 main screen',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              Text(
                'List of puzzles',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaisedButton.icon(
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: Puzzle2Screen1(),
                        ));
                      },
                      icon: Icon(
                        Puzzle2Variables.puzzle2_1Staus == 'green'
                            ? Icons.event_available_rounded
                            : Icons.event_busy_rounded,
                        size: 30.0,
                        color: Puzzle2Variables.puzzle2_1Staus == 'green'
                            ? Colors.green
                            : Colors.red,
                      ),
                      label: Text(
                        'Puzzle 2.1',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaisedButton.icon(
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        Puzzle2Variables.puzzle2_1Staus == 'green'
                            ? Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: Puzzle2Screen2(),
                              ))
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Complete puzzle 2.1',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              );
                      },
                      icon: Icon(
                        Puzzle2Variables.puzzle2_2Staus == 'green'
                            ? Icons.event_available_rounded
                            : Icons.event_busy_rounded,
                        size: 30.0,
                        color: Puzzle2Variables.puzzle2_2Staus == 'green'
                            ? Colors.green
                            : Colors.red,
                      ),
                      label: Text(
                        'Puzzle 2.2',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaisedButton.icon(
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        setState(() {
                          Puzzle2Variables.puzzle2_2Staus == 'green'
                              ? Navigator.of(context).push(PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: Puzzle2Screen3(),
                                ))
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Complete puzzle 2.2',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                );
                        });
                      },
                      icon: Icon(
                        Puzzle2Variables.puzzle2_3Staus == 'green'
                            ? Icons.event_available_rounded
                            : Icons.event_busy_rounded,
                        size: 30.0,
                        color: Puzzle2Variables.puzzle2_3Staus == 'green'
                            ? Colors.green
                            : Colors.red,
                      ),
                      label: Text(
                        'Puzzle 2.3',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaisedButton.icon(
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        setState(() {
                          Puzzle2Variables.puzzle2_3Staus == 'green'
                              ? Navigator.of(context).push(PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: Puzzle2Screen4(),
                                ))
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Complete puzzle 2.3',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                );
                        });
                      },
                      icon: Icon(
                        Puzzle2Variables.puzzle2_4Staus == 'green'
                            ? Icons.event_available_rounded
                            : Icons.event_busy_rounded,
                        size: 30.0,
                        color: Puzzle2Variables.puzzle2_4Staus == 'green'
                            ? Colors.green
                            : Colors.red,
                      ),
                      label: Text(
                        'Puzzle 2.4',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RaisedButton.icon(
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          Puzzle2.getInstance().onFinished();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        label: Text(
                          'Quit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0),
                        ),
                        color: Colors.red,
                      ),
                      RaisedButton.icon(
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          // Puzzle2.getInstance().onFinished();
                          // Navigator.of(context).pop();

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Test()),
                          // );
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
}

/*
Container(
            padding: EdgeInsets.all(0),
            child: FlatButton(
              child: Text(
                'Quit',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                Puzzle2.getInstance().onFinished();
                Navigator.of(context).pop();
              },
            ),
          ),
 */
