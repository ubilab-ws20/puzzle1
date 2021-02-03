import 'package:flutter/material.dart';

// import 'package:flutter_magnetometer/flutter_magnetometer.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'dart:async';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2MainScreen.dart';

import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

import 'package:vibration/vibration.dart';

import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';

class Puzzle2Screen2 extends StatefulWidget {
  Function updateMagnetometerProgressbar;

  @override
  Puzzle2Screen2State createState() => Puzzle2Screen2State();
}

class Puzzle2Screen2State extends State<Puzzle2Screen2> {

  Vector3 _magnetometer = Vector3.zero();

  List<String> hintTexts = [
    "Provide high magnetic signal for a while by using another equipment which has a magnet.",
    "Use another phone."
  ];

  @override
  void initState() {
    super.initState();
    Game.getInstance().updateCurrentHints(hintTexts);
    motionSensors.magnetometerUpdateInterval =
        Duration.microsecondsPerSecond ~/ 30;
    motionSensors.magnetometer.listen((MagnetometerEvent event) {
      if (this.mounted) {
        setState(() {
          _magnetometer.setValues(event.x, event.y, event.z);
        });
      }
    });
  }

  Widget fun1() {
    Puzzle2Variables.magnetometerZaxisValue = _magnetometer.z.round();
    Puzzle2Variables.magnetometerProgress = (_magnetometer.z * -1) / 100;
    return MagnetometerValueBar();
  }

  Widget fun2() {
    Puzzle2Variables.magnetometerZaxisValue = _magnetometer.z.round();
    Puzzle2Variables.magnetometerProgress = (_magnetometer.z * 1) / 100;
    return MagnetometerValueBar();
  }

  startDownload() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      if ((Puzzle2Variables.magnetometerZaxisValue >= 100) ||
          (Puzzle2Variables.magnetometerZaxisValue <= -100)) {
        Puzzle2Variables.magnetometerZaxisValue = 0;
        // Puzzle2MainScreenState.getInstance().setStateCallback();
        // Navigator.of(context).pop();
        Puzzle2Variables.downloadStatusImage = 'assets/downloadStarted.gif';
        Puzzle2Variables.puzzle2_2Staus = 'green';
        Puzzle2Variables.subPuzzle = 3;
        Vibration.vibrate(duration: 500);

        if (Puzzle2Variables.cancelDownloadLoopCount == 1){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Puzzle solved.'
                      '\r\nDownload has started!',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
          Puzzle2Variables.cancelDownloadLoopCount = 0;
        }
        setState(() {});

        /*
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Flutter Magnetometer Example'),
                ),
                body: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Well done!\r\nYou have canceled the download process.'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RaisedButton.icon(
                            // padding: EdgeInsets.all(10),
                            onPressed: () {
                              // Puzzle2MainScreenState.getInstance().setStateCallback();
                              Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              size: 30.0,
                              color: Colors.red,
                            ),
                            label: Text(
                              'Quit',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.blue)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
        */

      }
    });
    return Container();
  }

  dummyFunction() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Do it like Tesla'),
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('${Puzzle2Variables.downloadStatusImage}'),
                width: 200,
                height: 200,
              ),
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(0),
                child: Text(
                  Puzzle2Variables.downloadStatusImage ==
                      'assets/downloadNotStarted.gif'
                      ? 'AI has limited resources and it is counting on you to provide enough '
                      'magnetic force to destroy the external forces.'
                      '\r\nSo, that it can process the download uninterruptedly to its mainframe.'
                      : 'Download Started!',
                  textAlign: TextAlign.justify,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // MagnetometerValueBar(),
                    // LinearProgressIndicator(
                    //   value: magnetometerProgress,
                    //   minHeight: 20,
                    //   backgroundColor: Colors.red,
                    //   valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    // ),
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Text('magnetometerData:'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('x: ${_magnetometer.x.round()} μT'),
                              Text('y: ${_magnetometer.y.round()} μT'),
                              Text('z: ${_magnetometer.z.round()} μT'),
                            ],
                          ),
                          // ((_magnetometerData.z.round() < -100) ||
                          //     (_magnetometerData.z.round() > 100))
                          (_magnetometer.z.round() < 0)
                              ? fun1()
                              : (_magnetometer.z.round() >= 0)
                              ? fun2()
                              : dummyFunction(),

                          (_magnetometer.z.round() <= -100)
                              ? startDownload()
                              : (_magnetometer.z.round() >= 100)
                              ? startDownload()
                              : dummyFunction(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RaisedButton.icon(
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        if (Puzzle2Variables.subPuzzle == 2){
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
                        }

                        else {
                          Puzzle2MainScreenState.getInstance().setStateCallback();
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
                    /*
                    RaisedButton.icon(
                      // padding: EdgeInsets.all(10),
                      onPressed: () {
                        if (Puzzle2Variables.subPuzzle == 2){
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
                        }

                        else {
                          Puzzle2MainScreenState.getInstance().setStateCallback();
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 30.0,
                        color: Colors.red,
                      ),
                      label: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.blue)),
                    ),
                  */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MagnetometerValueBar extends StatefulWidget {
  @override
  MagnetometerValueBarState createState() => MagnetometerValueBarState();
}

class MagnetometerValueBarState extends State<MagnetometerValueBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        value: Puzzle2Variables.magnetometerProgress,
        minHeight: 20,
        backgroundColor: Colors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }
}
