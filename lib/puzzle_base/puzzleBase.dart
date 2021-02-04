import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';

abstract class PuzzleBase {
  Function onFinished;

  void setFinishedCallback(Function onFinished) {
    this.onFinished = onFinished;
  }

  List<String> getPuzzleSearchHints() {
    return [];
  }

  LatLng getStartLocation();
  List<StoryText> getIntroTexts();
  List<StoryText> getOutroTexts();
  void startPuzzle(BuildContext context);
}
