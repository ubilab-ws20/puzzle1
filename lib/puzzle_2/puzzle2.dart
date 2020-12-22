import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';

import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen.dart';
import 'package:page_transition/page_transition.dart';

class Puzzle2 extends PuzzleBase {

  static Puzzle2 _instance;

  Puzzle2() {
    _instance = this;
  }

  /// Static singleton method.
  static Puzzle2 getInstance() {
    if (_instance == null) {
      _instance = Puzzle2();
    }
    return _instance;
  }

  LatLng getStartLocation() {
    return LatLng(48.012684, 7.835044);
  }
  List<String> getIntroTexts() {
    return ["Intro 1", "Intro 2", "Intro 3"];
  }
  List<String> getOutroTexts() {
    return ["Outro 1", "Outro 2", "Outro 3"];
  }
  void startPuzzle(BuildContext context) {
    print("Puzzle 2 started!");
    // onFinished();
    Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.fade,
          child: Puzzle2Screen(),
        )
    );
  }
}
