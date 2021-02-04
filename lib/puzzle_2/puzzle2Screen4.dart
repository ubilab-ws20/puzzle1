import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:beacons_plugin/beacons_plugin.dart';

import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';

import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2MainScreen.dart';

class Puzzle2Screen4 extends StatefulWidget {
  @override
  Puzzle2Screen4State createState() => Puzzle2Screen4State();
}

class Puzzle2Screen4State extends State<Puzzle2Screen4> {
  String _beaconResult = 'Not Scanned Yet.';
  int _nrMessaggesReceived = 0;
  var isRunning = false;

  final StreamController<String> beaconEventsController =
  StreamController<String>.broadcast();

  List<String> hintTexts = [
    "{1000101011}",
    "A place to read & where you shouldn't make noise."
  ];
  @override
  void initState() {
    super.initState();
    initPlatformState();
    Game.getInstance().updateCurrentHints(hintTexts);
  }

  @override
  void dispose() {
    beaconEventsController.close();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      //Prominent disclosure
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "Need Location Permission",
          message: "This app collects location data to work with beacons.");

      //Only in case, you want the dialog to be shown again. By Default, dialog will never be shown if permissions are granted.
      //await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
    }

    BeaconsPlugin.listenToBeacons(beaconEventsController);

    await BeaconsPlugin.addRegion(
        "BeaconType1", "D2:EA:2B:A4:F8:3C");
    await BeaconsPlugin.addRegion(
        "BeaconType2", "6a84c716-0f2a-1ce9-f210-6a63bd873dd9");

    beaconEventsController.stream.listen(
            (data) {
          if (data.isNotEmpty) {
            setState(() {
              _beaconResult = data;
              _nrMessaggesReceived++;
            });
            print("Beacons DataReceived: " + data);
          }
        },
        onDone: () {},
        onError: (error) {
          print("Error: $error");
        });

    //Send 'true' to run in background
    await BeaconsPlugin.runInBackground(true);

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
          setState(() {
            isRunning = true;
          });
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.startMonitoring;
      setState(() {
        isRunning = true;
      });
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Monitoring Beacons'),
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  'Reach towards the location quickly and find a safe spot '
                      'to fire up a strong Electromagnetic Pulse signal to stop the forces.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: 'VT323', fontSize: 22.0),
                ),
              ),
              Text('$_beaconResult'),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text('$_nrMessaggesReceived'),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: isRunning,
                child: RaisedButton(
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await BeaconsPlugin.stopMonitoring;

                      setState(() {
                        isRunning = false;
                      });
                    }
                  },
                  child: Text('Stop Scanning', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: !isRunning,
                child: RaisedButton(
                  onPressed: () async {
                    initPlatformState();
                    await BeaconsPlugin.startMonitoring;

                    setState(() {
                      isRunning = true;
                    });
                  },
                  child: Text('Start Scanning', style: TextStyle(fontSize: 20)),
                ),
              ),
              RaisedButton.icon(
                padding: EdgeInsets.all(10),
                onPressed: () {
                  Puzzle2Variables.subPuzzle = 5;///delete this
                  if (Puzzle2Variables.subPuzzle == 4){
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

                  else if (Puzzle2Variables.subPuzzle == 5){
                    Puzzle2MainScreenState.getInstance().setStateCallback();
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
    );
  }
}
