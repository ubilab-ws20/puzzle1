import 'package:flutter/material.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2MainScreen.dart';

import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';

class Puzzle2Screen1 extends StatefulWidget {
  @override
  Puzzle2Screen1State createState() => Puzzle2Screen1State();
}

class Puzzle2Screen1State extends State<Puzzle2Screen1> {

  List<String> hintTexts = [
    "Any sufficiently crisp question can be answered by a single "
        "yes/no or what a computer could say?",
  ];
  @override
  void initState() {
    super.initState();
    Game.getInstance().updateCurrentHints(hintTexts);
  }


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

  bool showHint = false;

  Widget forgotPassword() {
    return showHint == false
        ? Container(
      // decoration:
      //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      margin: EdgeInsets.all(0),
      child: RaisedButton.icon(
        // padding: EdgeInsets.all(10),
        onPressed: () {
          showHint = true;
          setState(() {});
        },
        icon: Icon(
          Icons.help_outline_rounded,
          size: 30.0,
          color: Colors.green,
        ),
        label: Text(
          'Forgot password',
          style: TextStyle(
              color: Colors.green,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.blue)),
      ),
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration:
          BoxDecoration(border: Border.all(color: Colors.green)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  'Code \r\nhint:',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                ),
              ),
              Container(
                // margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Image(
                  image: AssetImage('assets/555.png'),
                  width: 70,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
    setState(() {

    });

    return Column();
  }

  enterBinaryCode(){
    if (Puzzle2Variables.decimalNumber != 555) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Wrong password!',
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
    else if(Puzzle2Variables.decimalNumber == 555){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Puzzle solved.'
                  '\r\nFolder opened!',
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      Puzzle2Variables.subPuzzle = 2;
    }
  }

  Widget puzzleSolved() {
    Puzzle2Variables.puzzle2_1Staus = 'green';
    return Column(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Access granted!\r\n',
            style: TextStyle(
                color: Colors.green,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
          Text(
            'Code.txt\r\n',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(

              'Great Job!\r\n'
                  'You have done it, \r\nhere\'s the code: 555 - 1000101011 '
                  '\r\n(Remember this might come in handy later on!!!)',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.all(0),

        child: RaisedButton.icon(
          padding: EdgeInsets.all(10),
          onPressed: () {
            Puzzle2MainScreenState.getInstance().setStateCallback();
            Navigator.of(context).pop();
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
            Puzzle2MainScreenState.getInstance().setStateCallback();
            Navigator.of(context).pop();
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
      ),
    ]);
  }

  Widget puzzleNotSolved() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            'Predicting Prof Y\'s password to access his research.'
                ' Use all the resources you can find on the screen. Prof.Y has set up a password '
                'and now it is up to you to decode that and move forward to save the world.',
            textAlign: TextAlign.justify,
            /*
            style: TextStyle(
                fontSize: 15.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
          */
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Center(
            child: Column(
              children: <Widget>[
                //this goes in as one of the children in our column
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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
                              binaryToDecimalNumber();
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

                forgotPassword(),

                Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  margin: EdgeInsets.all(0),
                  child: RaisedButton.icon(
                    // padding: EdgeInsets.all(10),
                    onPressed: () {
                      binaryToDecimalNumber();
                      enterBinaryCode();
                    },
                    icon: Icon(
                      Icons.sync_alt_rounded,
                      size: 30.0,
                      color: Colors.purple,
                    ),
                    label: Text(
                      'Enter password',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('- **Cryptonite**-'),
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),

        body: Builder(
          builder: (BuildContext context) {
            return Puzzle2Variables.subPuzzle == 2
                ? puzzleSolved()
                : puzzleNotSolved();
          },
        ),
      ),
    );
  }
}