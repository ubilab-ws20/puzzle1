import 'package:flutter/material.dart';

class Puzzle2Screen3 extends StatefulWidget {
  @override
  Puzzle2Screen3State createState() => Puzzle2Screen3State();
}

class Puzzle2Screen3State extends State<Puzzle2Screen3> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}






/*import 'package:flutter/material.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';

import 'package:vibration/vibration.dart';

class Puzzle2Screen3 extends StatefulWidget {
  @override
  Puzzle2Screen3State createState() => Puzzle2Screen3State();
}

class Puzzle2Screen3State extends State<Puzzle2Screen3> {
  /*
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  */

  //this goes in our State class as a global variable
  bool isSwitched0 = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;
  bool isSwitched5 = false;
  bool isSwitched6 = false;
  bool isSwitched7 = false;
  bool isSwitched8 = false;
  bool isSwitched9 = false;
  bool isSwitched10 = false;
  bool isSwitched11 = false;

  Widget binaryToDecimalNumber() {
    Puzzle2Variables.decimalNumber = 0;
    if ((isSwitched0) == true) Puzzle2Variables.decimalNumber += 1;
    if ((isSwitched1) == true) Puzzle2Variables.decimalNumber += 2;
    if ((isSwitched2) == true) Puzzle2Variables.decimalNumber += 4;
    if ((isSwitched3) == true) Puzzle2Variables.decimalNumber += 8;
    if ((isSwitched4) == true) Puzzle2Variables.decimalNumber += 16;
    if ((isSwitched5) == true) Puzzle2Variables.decimalNumber += 32;
    if ((isSwitched6) == true) Puzzle2Variables.decimalNumber += 64;
    if ((isSwitched7) == true) Puzzle2Variables.decimalNumber += 128;
    if ((isSwitched8) == true) Puzzle2Variables.decimalNumber += 256;
    if ((isSwitched9) == true) Puzzle2Variables.decimalNumber += 512;
    if ((isSwitched10) == true) Puzzle2Variables.decimalNumber += 1024;
    if ((isSwitched11) == true) Puzzle2Variables.decimalNumber += 2048;
    setState(() {});

    return Column();
  }

  Widget puzzleSolved() {
    return Container(child: Text('Puzzle solved!'));
  }

  Widget puzzleNotSolved() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ' Find the correct binary number.',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
        Text(
          'Hint:',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
        Image(
          image: AssetImage('assets/555.png'),
          width: 200,
          height: 100,
        ),








      Center(
      child: Column(
        children: <Widget>[
          //this goes in as one of the children in our column
          Row(
            children: [
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 11'),
                  Switch(
                    value: isSwitched11,
                    onChanged: (value) {
                      setState(() {
                        isSwitched11 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 10'),
                  Switch(
                    value: isSwitched10,
                    onChanged: (value) {
                      setState(() {
                        isSwitched10 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),

              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 9'),
                  Switch(
                    value: isSwitched9,
                    onChanged: (value) {
                      setState(() {
                        isSwitched9 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),

              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 8'),
                  Switch(
                    value: isSwitched8,
                    onChanged: (value) {
                      setState(() {
                        isSwitched8 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),

            ],
          ),

          Row(
            children: [
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 7'),
                  Switch(
                    value: isSwitched7,
                    onChanged: (value) {
                      setState(() {
                        isSwitched7 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 6'),
                  Switch(
                    value: isSwitched6,
                    onChanged: (value) {
                      setState(() {
                        isSwitched6 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),

              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 5'),
                  Switch(
                    value: isSwitched5,
                    onChanged: (value) {
                      setState(() {
                        isSwitched5 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),

              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 4'),
                  Switch(
                    value: isSwitched4,
                    onChanged: (value) {
                      setState(() {
                        isSwitched4 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 3'),
                  Switch(
                    value: isSwitched3,
                    onChanged: (value) {
                      setState(() {
                        isSwitched3 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 2'),
                  Switch(
                    value: isSwitched2,
                    onChanged: (value) {
                      setState(() {
                        isSwitched2 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),

              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 1'),
                  Switch(
                    value: isSwitched1,
                    onChanged: (value) {
                      setState(() {
                        isSwitched1 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),

              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(children: [
                  Text('Bit 0'),
                  Switch(
                    value: isSwitched0,
                    onChanged: (value) {
                      setState(() {
                        isSwitched0 = value;
                      });
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.green[200],
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red[200],
                  ),
                ]),
              ),
            ],
          ),
          Column(children: [
            Text('Binary to digital number: ${Puzzle2Variables.decimalNumber}'),
          ]),

          Container(
            // decoration:
            //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            margin: EdgeInsets.all(30),
            child: RaisedButton.icon(
              // padding: EdgeInsets.all(10),
              onPressed: () {
                binaryToDecimalNumber();
              },
              icon: Icon(
                Icons.sync_alt_rounded,
                size: 30.0,
                color: Colors.red,
              ),
              label: Text(
                'Convert',
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
          ),
        ],
      ),
    ),












    Container(
      margin: EdgeInsets.all(30),
      child:
      RaisedButton.icon(
        // padding: EdgeInsets.all(10),
        onPressed: () {
          Puzzle2Variables.puzzle2_1Staus == 'green' ?
          Puzzle2Variables.puzzle2_1Staus = 'red' :
          Puzzle2Variables.puzzle2_1Staus = 'green';
          // Puzzle2MainScreenState.getInstance().setStateCallback();
          Navigator.of(context).pop();
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
            side: BorderSide(color: Colors.blue)
        ),
      ),

    ),
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Vibration Plugin example app'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Puzzle2Variables.decimalNumber == 555
                ? puzzleSolved()
                : puzzleNotSolved();
          },
        ),
      ),
    );
  }
}
*/