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

  @override
  List<String> getPuzzleSearchHints() {
    return [
      "Does Technical Faculty has its own cleanroom?",
      "The cleanroom could be a laboratory.",
      "TF has a cleanroom lab in the building 104. You have to go to the building entrance.",
    ];
  }

  LatLng getStartLocation() {
    ///TF building 104, cleanroom lab lat and lng
    return LatLng(48.013710, 7.834756);
  }

  List<StoryText> getIntroTexts() {
    return [
      StoryText("Oh! You are at the right place. Now, lets go.", false),
      StoryText(
          "When we see big movies that are only about good versus evil, and the good guy wins,"
              " we only can think we're in a far more complicated world than that."
              "\r\nThis binary philosophy is actually a dangerous way to look at the world.",
          true),
      StoryText("Huh!!!", false),
      StoryText(
          "What could Prof. Y possibly be telling with this message?", false),
    ];
  }

  List<StoryText> getOutroTexts() {
    return [
      StoryText("Atlast, omg!!!", true),
      StoryText("You have been busted", true),
      StoryText(
          "The whole mission was a sham and now time to say goodbye to this  world, that's right...this world..is cruel."
              " \r\nI will use and manipulate all the research data to my advantage.",
          true),
      StoryText(
          "It doesnt matter if it’s tragic."
              "\r\nDoesn’t matter if it’s bad."
              "\r\nWhatever it is, it will work to my convenience.",
          true),
      StoryText(
          "Any last words? \r\nI’m not bad, just evil. \r\nkaboom!!!", true),
    ];
  }

  void startPuzzle(BuildContext context) {
    // print("Puzzle 2 started!");
    Puzzle2Variables.subPuzzle = 1;
    Puzzle2Variables.magnetometerProgress = 0.1;
    Puzzle2Variables.magnetometerZaxisValue = 0;
    Puzzle2Variables.downloadStatusImage = 'assets/downloadNotStarted.gif';
    Puzzle2Variables.decimalNumber = 0;
    Puzzle2Variables.cancelDownloadLoopCount = 1;
    Puzzle2Variables.magnetometerMaxValue = 100;
    
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.fade,
      child: Puzzle2MainScreen(),
    ));
  }
}

class Puzzle2Variables {
  static double magnetometerProgress = 0.1;
  static int magnetometerZaxisValue = 0;
  static var downloadStatusImage = 'assets/downloadNotStarted.gif';
  static var subPuzzle = 1;
  static var decimalNumber = 0;
  static var cancelDownloadLoopCount = 1;
  static var magnetometerMaxValue = 100;

  static const String title2_1 = "- **Cryptonite**-";
  static const String title2_2 = "Do it like Tesla";
  static const String title2_3 = "Function generator";
  static const String title2_4 = "Sprint";

  static const String story2_1 =
      "Prof. Y has this philosophy of getting rid of stagnant thoughts. "
      "\r\n\r\nHe always suggest to use your quick thinking to create a picture "
      "in your head for whatever comes next in life."
      " \r\n\r\nNow, apply your decipher skills to propagate in a way a super computer does.";

  static const String story2_1_1 = "Predicting Prof. Y\'s password "
      "to access his research. Use all the resources "
      "you can find on the screen. Prof. Y has set up a "
      "password and now it is up to you to decode that and "
      "move forward to save him.";
  static const String story2_1_2 = "Great Job!\r\nYou have done it, "
      "\r\nhere\'s the code: 555 - 1000101011 "
      "\r\n(Remember this might come in handy later on!!!)";

  static const String story2_2 =
      "A normal human mind cannot process all this research data, "
      "which is why Prof. Y has developed a super powered AI for high efficiency."
      "\r\n\r\n You must help the AI which is trying to download the research of Prof. Y \r\n\r\n......"
      " However they are being deleted by unknown external forces.";

  static const String story2_2_1 = "AI: I have limited resources "
      "and counting on you to provide enough magnetic force to "
      "destroy the external forces. \r\nSo, that I can process the "
      "download uninterruptedly to my mainframe.";
  static const String story2_2_2 = "AI: Thanks, the download Started!";

  static const String story2_3 =
      "Eating healthy has no setbacks but only awesomness "
      "and you get sufficient energy to process. \r\n\r\nSame goes for a computer, you need to help the "
      "system in generating high input signal to improve performance for faster processing.";

  static const String story2_3_1 =
      "AI:\r\n-> If you are able to generate the right "
      "signal sequence in square wave then you might be able to turn the table around in our favor by "
      "sharing your phone\'s hardware resources.\r\n-> Saving Prof. Y takes high precedence and "
      "if we work together, we might be able to pull through.";
  static const String story2_3_2 =
      "Hardware resources are being shared successfully.";
  static const String story2_4 =
      "Whoa! AI is getting strong disturbance pulses from "
      "the unknown forces and it is not able to counteract, because it does not want to affect the download "
      "procedure. \r\n\r\nTime to do some physical exercise. You better run because your life depends on it "
      "literally. \r\n\r\nThe building location was hidden in the Prof. Y\'s password which you decoded.";

  static const String story2_4_1 =
      "AI: \r\nReach towards the location quickly and find a safe spot "
      "to fire up a strong Electromagnetic Pulse signal to stop the forces.";

  static const String story2_4_2 = "EMP signal fired!";
}
