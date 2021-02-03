import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2MainScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';
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

  List<StoryText> getIntroTexts() {
    return [StoryText("When we see big movies that are only about good versus evil, and the good guy wins,"
        " we only can think we're in a far more complicated world than that."
        "\r\nThis binary philosophy is actually a dangerous way to look at the world.", true),
      StoryText("Huh!!!", false),
      StoryText("What could Prof. Y possibly be telling with this message?", false),
    ];
  }

  List<StoryText> getOutroTexts() {
    return [StoryText("Atlast, omg!!!", true),
    StoryText("You have been busted", true),
    StoryText("The whole mission was a sham and now time to say goodbye to this  world, that's right...this world..is cruel."
    " \r\nI will use and manipulate all the research data to my advantage.", true),
      StoryText("It doesnt matter if it’s tragic."
          "\r\nDoesn’t matter if it’s bad."
          "\r\nWhatever it is, it will work to my convenience.", true),
      StoryText("Any last words? \r\nI’m not bad, just evil. \r\nkaboom!!!", true),
    ];
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
  static var puzzle2_3Staus = 'green';
  static var puzzle2_4Staus = 'red';

  // static var aiDownloadingStatus = 0.1;
  static double magnetometerProgress = 0.1;
  static int magnetometerZaxisValue = 0;
  static var downloadStatusImage = 'assets/downloadNotStarted.gif';

  static var subPuzzle = 1;

  static var decimalNumber = 0;
  static var cancelDownloadLoopCount = 1;
}
