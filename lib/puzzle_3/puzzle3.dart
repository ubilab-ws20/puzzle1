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
    return [/*"CIV? What could this mean?",
      "The old Romans used letters for numbers..",
      "C = 100, I = 1, V = 5. Take a look on your map.",*/
    ];
  }

  List<StoryText> getIntroTexts() {
    return [StoryText("You seem to have reached the correct location since a new challenge is available.", false),
      StoryText("If the messages truly are connected to Prof Y, hopefully you can gather information about his mysterious disappearance.", false),
        StoryText("Might those tasks be some kind of test designed by him?", false),
      StoryText("Time to enter the new challenge!", false),
    ];
  }

  List<StoryText> getOutroTexts() {
    return [StoryText("After finding the correct knocking pattern, the puzzle seems to be completed.", false),
        //StoryText("where could the next CaptIVating puzzle begin? maybe the solution is hidden within...", true),
      StoryText("The fourth key to a good health is to stay hygienic by keeping your surroundings clean. You cannot buy your health; you must earn it through healthy living and maintaining a cleanroom.", true),
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