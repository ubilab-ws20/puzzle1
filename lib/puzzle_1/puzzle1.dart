import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1Screen.dart';

class Puzzle1 extends PuzzleBase {
  static Puzzle1 _instance;

  List<String> hintTexts = ["Puzzle 1 Hint 1", "Puzzle 1 Hint 2", "Puzzle 1 Hint 3"];

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

  @override
  List<String> getPuzzleSearchHints() {
    return ["Search Puzzle 1 Hint 1", "Search Puzzle 1 Hint 2", "Search Puzzle 1 Hint 3"];
  }

  @override
  LatLng getStartLocation() {
    return LatLng(48.012684, 7.835044);
  }

  @override
  List<String> getIntroTexts() {
    return ["Puzzle 1 Intro 1", "Puzzle 1 Intro 2", "Puzzle 1 Intro 3"];
  }

  @override
  List<String> getOutroTexts() {
    return ["Puzzle 1 Outro 1", "Puzzle 1 Outro 2", "Puzzle 1 Outro 3"];
  }

  @override
  void startPuzzle(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.fade,
        child: Puzzle1Screen(),
      )
    );
  }
}
