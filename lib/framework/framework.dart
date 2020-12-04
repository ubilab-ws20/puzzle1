import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';

import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/puzzle3.dart';

import 'storyWidget.dart';

// Coordinates of Technical Faculty
// 48.012684, 7.835044

class GameMainScreen extends StatefulWidget {
  @override
  _GameMainScreen createState() => _GameMainScreen();
}

class _GameMainScreen extends State<GameMainScreen> {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];

  BuildContext context;
  GlobalKey<StoryWidgetState> storyIntroWidgetyKey = GlobalKey();
  GlobalKey<StoryWidgetState> storyOutroWidgetyKey = GlobalKey();
  PuzzleBase puzzle;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    this.userLocationOptions = UserLocationOptions(
      context: context,
      mapController: this.mapController,
      markers: this.markers,
      onLocationUpdate: onLocationChanged,
      updateMapLocationOnPositionChange: false,
      zoomToCurrentLocationOnLoad: false,
      defaultZoom: 16,
    );
    return Scaffold(
      appBar: AppBar(title: Text("Ubilab Scavenger Hunt")),
      body: FlutterMap(
        options: MapOptions(
          // Coordinates of Technical Faculty
          center: LatLng(48.012684, 7.835044),
          zoom: 16.0,
          plugins: [
            UserLocationPlugin(),
          ],
        ),
        mapController: this.mapController,
        layers: [
          MarkerLayerOptions(markers: this.markers),
          this.userLocationOptions,
        ],
        children: <Widget>[
          TileLayerWidget(options: TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          )),
          Column(
            children: [
              testPuzzleButtonRow(),
              StoryWidget(key: this.storyIntroWidgetyKey),
              StoryWidget(key: this.storyOutroWidgetyKey),
            ],
          ),
        ],
      ),
    );
  }

  /// Callback for map when location of player changed.
  void onLocationChanged(LatLng coords) {
    print("Location changed.");
  }

  /// Callback for puzzles when puzzle is finished.
  void onPuzzleFinished() {
    if (this.puzzle == null) {
      return;
    }
    this.storyOutroWidgetyKey.currentState.show(this.puzzle.getOutroTexts(), null, false);
    this.puzzle = null;
  }

  // Functions for development & testing

  /// Test callback for reaching the location for puzzle 1.
  /// Used by a test button.
  void testOnPuzzle1() {
    this.puzzle = Puzzle1();
    this.puzzle.setFinishedCallback(onPuzzleFinished);
    this.storyIntroWidgetyKey.currentState.show(this.puzzle.getIntroTexts(), this.testOnStartPuzzle, true);
  }

  /// Test callback for reaching the location for puzzle 2.
  /// Used by a test button.
  void testOnPuzzle2() {
    this.puzzle = Puzzle2();
    this.puzzle.setFinishedCallback(onPuzzleFinished);
    this.storyIntroWidgetyKey.currentState.show(this.puzzle.getIntroTexts(), this.testOnStartPuzzle, true);
  }

  /// Test callback for reaching the location for puzzle 2.
  /// Used by a test button.
  void testOnPuzzle3() {
    this.puzzle = Puzzle3();
    this.puzzle.setFinishedCallback(onPuzzleFinished);
    this.storyIntroWidgetyKey.currentState.show(this.puzzle.getIntroTexts(), this.testOnStartPuzzle, true);
  }

  /// Test callback when after reading the intro story a puzzle is started.
  void testOnStartPuzzle() {
    if (this.puzzle == null) {
      return;
    }
    this.puzzle.startPuzzle(this.context);
  }

  /// Creates a row of test buttons to trigger reaching the location for a puzzle.
  Row testPuzzleButtonRow() {
    return Row(
      children: <Widget>[
        testPuzzleButton("Puzzle 1", testOnPuzzle1),
        testPuzzleButton("Puzzle 2", testOnPuzzle2),
        testPuzzleButton("Puzzle 3", testOnPuzzle3),
      ],
    );
  }

  /// Creates a test button to trigger reaching the location for a puzzle.
  Expanded testPuzzleButton(String buttonText, Function onButtonPressed) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Container(
          margin: const EdgeInsets.all(1.0),
          child: OutlinedButton(
            child: Text(buttonText),
            onPressed: onButtonPressed,
          ),
        ),
      ),
    );
  }
}
