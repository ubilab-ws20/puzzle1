import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/puzzle3Screen.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';

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


  @override
  List<String> getPuzzleSearchHints() {
    return ["CVI? What could this mean?",
      "The old Romans used letters for numbers..",
      "C = 100, V = 6, I = 1. Take a look on your map.",
    ];
  }

  List<StoryText> getIntroTexts() {
    return [StoryText("You seem to have reached the correct location since a new message pops up on your phone.", false),
        StoryText("If the messages truly are connected to Prof Y, hopefully you can gather information about his mysterious disappearance.", false),
        StoryText("Might those tasks be some kind of test designed by him?", false),
    ];
  }

  List<StoryText> getOutroTexts() {
    return [StoryText("After finding the correct knocking pattern, the puzzle seems to be completed.", false),
        StoryText("where could the next CaptiVatIng puzzle begin? maybe the solution is hidden within...", false),
    ];
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