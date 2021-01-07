import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

abstract class PuzzleBase {
  Function onFinished;

  void setFinishedCallback(Function onFinished) {
    this.onFinished = onFinished;
  }

  List<String> getPuzzleSearchHints() {
    return [];
  }

  LatLng getStartLocation();
  List<String> getIntroTexts();
  List<String> getOutroTexts();
  void startPuzzle(BuildContext context);
}
