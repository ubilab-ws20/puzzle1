import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/puzzle3Screen.dart';
import '../puzzle_base/puzzleBase.dart';

class Puzzle3 extends PuzzleBase {
  static Puzzle3 _instance;

  Puzzle3() {
    _instance = this;
  }

  static Puzzle3 getInstance() {
    if (_instance == null) {
      _instance = Puzzle3();
    }
    return _instance;
  }

  LatLng getStartLocation() {
    return LatLng(48.01331791150736, 7.833964150855805);
  }

  List<String> getIntroTexts() {
    return ["You seem to have reached the correct location since a new message pops up on your phone.",
      "If the messages truly are connected to Prof Y, hopefully you can gather information about his mysterious disappearance.",
      "Might those tasks be some kind of test designed by him?",];
  }

  List<String> getOutroTexts() {
    return ["After finding the correct knocking pattern, the puzzle seems to be completed.", "Outro 2", "Outro 3"];
  }

  @override
  void startPuzzle(BuildContext context) {
    Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(seconds: 1),
          reverseDuration: Duration(seconds: 1),
          child: SecondRoute(),
        )
    );
  }

}