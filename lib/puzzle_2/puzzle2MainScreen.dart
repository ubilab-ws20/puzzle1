import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen3.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen4.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import '../framework/storyText.dart';
import 'puzzle2Screen3.dart';

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
    setState(() {});
  }

  Widget displayStory() {
    if (Puzzle2Variables.subPuzzle == 1) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          Puzzle2Variables.story2_1,
          textAlign: TextAlign.justify,
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 2) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          Puzzle2Variables.story2_2,
          textAlign: TextAlign.justify,
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 3) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          Puzzle2Variables.story2_3,
          textAlign: TextAlign.justify,
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 4) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          Puzzle2Variables.story2_4,
          textAlign: TextAlign.justify,
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 5) {
      return Container();
    } else
      return Column();
  }

  List<StoryText> textInsidePuzzle2_1 = [
    StoryText(Puzzle2Variables.story2_1, false)
  ];

  List<StoryText> textInsidePuzzle2_1_1 = [
    StoryText(Puzzle2Variables.story2_1_1, false),
    StoryText(Puzzle2Variables.story2_1_2, false)
  ];

  List<StoryText> textInsidePuzzle2_2 = [
    StoryText(Puzzle2Variables.story2_2, false)
  ];

  List<StoryText> textInsidePuzzle2_2_1 = [
    StoryText(Puzzle2Variables.story2_2_1, true),
    StoryText(Puzzle2Variables.story2_2_2, true)
  ];

  List<StoryText> textInsidePuzzle2_3 = [
    StoryText(Puzzle2Variables.story2_3, false)
  ];

  List<StoryText> textInsidePuzzle2_3_1 = [
    StoryText(Puzzle2Variables.story2_3_1, true),
    StoryText(Puzzle2Variables.story2_3_2, false)
  ];

  List<StoryText> textInsidePuzzle2_4 = [
    StoryText(Puzzle2Variables.story2_4, false),
  ];

  displaySubPuzzle() {
    if (Puzzle2Variables.subPuzzle == 1) {
      Game.getInstance().addTextsToAlreadyShown(textInsidePuzzle2_1);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen1(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 2) {
      Game.getInstance().addTextsToAlreadyShown(textInsidePuzzle2_1_1);
      Game.getInstance().addTextsToAlreadyShown(textInsidePuzzle2_2);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen2(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 3) {
      Game.getInstance().addTextsToAlreadyShown(textInsidePuzzle2_2_1);
      Game.getInstance().addTextsToAlreadyShown(textInsidePuzzle2_3);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen3(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 4) {
      Game.getInstance().addTextsToAlreadyShown(textInsidePuzzle2_3_1);
      Game.getInstance().addTextsToAlreadyShown(textInsidePuzzle2_4);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen4(),
      ));
    } else {}
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
              displayStory(),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
