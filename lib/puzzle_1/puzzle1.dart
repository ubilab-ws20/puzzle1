import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1Screen.dart';

class Puzzle1 extends PuzzleBase {
  static Puzzle1 _instance;

  Puzzle1() {
    _instance = this;
  }

  /// Static singleton method.
  static Puzzle1 getInstance() {
    if (_instance == null) {
      _instance = Puzzle1();
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
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.fade,
        child: Puzzle1Screen(),
      )
    );
  }
}
