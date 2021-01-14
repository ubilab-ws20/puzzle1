import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1Screen.dart';

class Puzzle1 extends PuzzleBase {
  static Puzzle1 _instance;

  List<String> hintTexts = ["What does the second text message tell you to do?",
    "Explore the location and listen carefully!",
    "At certain locations in and around the building sounds are played, telling you the numbers to use for the vault.",
    "What may this graph-like structure be about? Is it there for a reason?",
    "The order of the numbers can be derived from the graph-like structure.",
    "Each point represents one of the numbers. Their relative positions to each other tell you the order how they have to be inserted in the number pickers."
  ];

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
    return ["What might be the reason for having \"WHY\" written in capital letters in this strange text message?",
      "Could this be a hint to or from Prof. Dr. Y?",
      "Where does the content of the message lead you to?",
      "Find a location which is closely linked to nutrition."
    ];
  }

  @override
  LatLng getStartLocation() {
    return LatLng(48.012684, 7.835044);
  }

  @override
  List<String> getIntroTexts() {
    return ["Ok, let's be honest. Of course you could not resist the feeling that this odd text message had a reason.",
      "The capital letters \"WHY\" must have been a hint to Prof. Dr. Y! ...what a silly thought.",
      "You went to the canteen and found absolutely nothing...of course not. It was just a stupid advertising message.",
      "But suddenly another text message comes in:",
      "\"The second key for a better life is living in the here and now. Whereever you are, discover your surrounding and listen to what it tells you!\"",
      "Ok...well that was...but wait? Your phone starts to show something like a vault...and you cannot control it anymore!",
      "What is happening???"
    ];
  }

  @override
  List<String> getOutroTexts() {
    return ["Puzzle 1 Outro 1",
      "Puzzle 1 Outro 2",
      "Puzzle 1 Outro 3"
    ];
  }

  @override
  void startPuzzle(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.fade,
        duration: Duration(seconds: 1),
        reverseDuration: Duration(seconds: 1),
        child: Puzzle1Screen(),
      )
    );
  }
}
