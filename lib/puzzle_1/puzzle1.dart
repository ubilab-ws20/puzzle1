import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1Screen.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';

class Puzzle1 extends PuzzleBase {
  static Puzzle1 _instance;

  List<String> hintTexts1FindSounds = ["What does the second text message tell you to do?",
    "Explore the location and listen carefully!",
    "At certain locations in and around the building sounds are played, telling you the numbers to use for the vault.",
  ];

  // TODO:
  // Insert hint to the exact 6 locations.
  List<String> hintTexts2FindAllSounds = ["You need to find 6 different numbers which have to be used as a combination for the vault, hidden at 6 different locations in and around the building.",
    "TBD hint to the exact locations.",
  ];

  List<String> hintTexts3SecretOrder = ["What may these black scratches at the top be about? Are they there for a reason?",
    "The order of the numbers can be derived from the black scratches.",
    "Each point where 2 scratches meet represents one of the numbers. Their relative positions to each other tell you the order how they have to be inserted in the number pickers.",
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
    return ["What might be the reason for having \"whY\" written in that way in this strange text message?",
      "Could this be a hint to or from Prof. Dr. Y?",
      "Where does the content of the message lead you to?",
      "Find a location which is closely linked to nutrition.",
    ];
  }

  @override
  LatLng getStartLocation() {
    /// Coordinates of the entry to the canteen of the Faculty of Engineering
    return LatLng(48.013217, 7.833264);
  }

  @override
  List<StoryText> getIntroTexts() {
    return [StoryText("Ok, let's be honest. Of course you could not resist the feeling that this odd text message had a reason.", false),
      StoryText("The \"whY\" must have been a hint to Prof. Dr. Y! ...what a silly thought.", false),
      StoryText("You went to the canteen and found absolutely nothing...of course not. It was just a stupid advertising message.", false),
      StoryText("But suddenly another text message comes in:", false),
      StoryText("The second key for a better life is living in the here and now. Whereever you are, discover your surrounding and listen to what it tells you!", true),
      StoryText("Ok...well that was...but wait? Your phone starts to show something like a vault...and you cannot control it anymore!", false),
      StoryText("What is happening???", false),
    ];
  }

  @override
  List<StoryText> getOutroTexts() {
    // TODO:
    // Add hint where to find location for puzzle 2.
    return [StoryText("Hey! Seems like you managed to open this phone hijacking vault...after all.", false),
      StoryText("But nevertheless, what is going on here?", false),
      StoryText("The only reasonable explanation is that really Prof. Y is sending you all these messages, hints and challenges.", false),
      StoryText("And that he needs you to help him!", false),
      StoryText("TBD hint where to find location for puzzle 2.", false),
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
