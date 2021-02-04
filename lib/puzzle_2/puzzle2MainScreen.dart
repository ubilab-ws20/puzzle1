import 'package:flutter/material.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen3.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen4.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';

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

  Widget displayStory() {
    if (Puzzle2Variables.subPuzzle == 1) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          'Prof Y has this philosophy of getting rid of stagnant thoughts.\r\n\r\n'
              'He always suggest to use your quick thinking to create a picture '
              'in your head for whatever comes next in life.\r\n\r\n'
              'Now, apply your decipher skills to propagate in a way a super computer does.',
          textAlign: TextAlign.justify,
          /*
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        */
        ),
        ///add location text box
      );
    } else if (Puzzle2Variables.subPuzzle == 2) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          'A normal human mind cannot process all this research data, '
              'which is why Prof. Y has developed a super powered AI for high efficiency.\r\n\r\n'
              'You must help the AI which is trying to download the research of Prof Y'
              '\r\n\r\n......'
              'However they are being deleted by unknown external forces.',
          textAlign: TextAlign.justify,
          /*
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
          */
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 3) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          'Eating healthy has no setbacks but only awesomness '
              'and you get sufficient energy to process.'
              '\r\n\r\nSame goes for a computer, you need to help the '
              'system in generating high input signal to improve '
              'performance for faster processing.',
          textAlign: TextAlign.justify,
          /*
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        */
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 4) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          'Whoa! AI is getting strong disturbance pulses from the unknown '
              'forces and it is not able to counteract, because it does not want '
              'to affect the download procedure.'
              '\r\nTime to do some physical exercise. You better run because your life depends on it literally. '
              '\r\n\r\nThe building location was hidden in the Prof.Y password which you decoded.',
          textAlign: TextAlign.justify,
          /*
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        */
        ),
      );
    }

    else if (Puzzle2Variables.subPuzzle == 5) {
        // Puzzle2.getInstance().onFinished();
        // Navigator.of(context).pop();

      return Container(
        /*
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          'You have solved all the Puzzles! \r\nBut . . .',
          textAlign: TextAlign.justify,
          /*
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        */
        ),

        */
      );
    }
    else
      return Column();
  }

  displaySubPuzzle() {
    if (Puzzle2Variables.subPuzzle == 1) {
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen1(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 2) {
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen2(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 3) {
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen3(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 4) {
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen4(),
      ));
    }
    else if (Puzzle2Variables.subPuzzle == 5) {
      Puzzle2.getInstance().onFinished();
      Navigator.of(context).pop();
    }
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Finale: The Destiny'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /*
              Text(
                'Puzzle 2 main screen',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              */
              displayStory(),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*
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
                      */
                      RaisedButton.icon(
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          displaySubPuzzle();
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