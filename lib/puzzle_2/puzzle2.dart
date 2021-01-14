import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';

import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2MainScreen.dart';
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
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.fade,
      child: Puzzle2MainScreen(),
    ));
  }
}

class Puzzle2Variables {
  static var puzzle2_1Staus = 'red';
  static var puzzle2_2Staus = 'red';
  static var puzzle2_3Staus = 'red';
  static var puzzle2_4Staus = 'red';

  // static var aiDownloadingStatus = 0.1;
  static double magnetometerProgress = 0.1;
  static int magnetometerZaxisValue= 0;
  static var downloadStatusImage = 'assets/fileTransfer.gif';

  static var decimalNumber = 0;
  static var cancelDownloadLoopCount = 1;
}
