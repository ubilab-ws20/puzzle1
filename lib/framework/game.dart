import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/puzzle3.dart';
import 'storyWidget.dart';
import 'hint.dart';

import 'package:ubilab_scavenger_hunt/framework/framework.dart';

///added by Sabari KM

enum gameState {
  none,
  start,
  searchPuzzle1,
  introPuzzle1,
  puzzle1,
  outroPuzzle1,
  searchPuzzle2,
  introPuzzle2,
  puzzle2,
  outroPuzzle2,
  searchPuzzle3,
  introPuzzle3,
  puzzle3,
  outroPuzzle3,
  end,
}

class Game {
  static Game _instance;

  GlobalKey<StoryWidgetState> storyIntroWidgetyKey = GlobalKey();
  GlobalKey<StoryWidgetState> storyOutroWidgetyKey = GlobalKey();
  List<String> gameStartTexts = [
    "A few days ago something mysterious happened in Freiburg.",
    "The famous and ingenious Prof. Dr. Y has disappeared and no one really knows what has happend to him.",
    "The official version is that he is suffering from a severe illness.",
    "But people who were working closely with him are heavily doubting this.",
    "While thinking about the real reason for his disappearance you see a strange text message popping up on your phone. It says:",
    "\"Scientists discovered the 6 key elements for a balanced, peaceful and happy life. The first one of them is healthy nutrition. So whY don't you go and search for the right food for you personal needs?\"",
    "Strange..."
  ];

  BuildContext _context;
  String _teamName = "";
  int _teamSize = 0;
  gameState _state = gameState.none;
  PuzzleBase _puzzle;

  Stopwatch _stopWatch = Stopwatch();
  List<String> _alreadyShownTexts = [];

  List<Hint> _currentHints = [];
  int _totalHints = 0;
  int _hintsUsed = 0;

  Game() {
    _instance = this;
  }

  /// Static singleton method.
  static Game getInstance() {
    if (_instance == null) {
      _instance = Game();
    }
    return _instance;
  }

  /// Setter for the BuildContext with which the puzzles start function is called.
  void setContext(BuildContext context) {
    _context = context;
  }

  /// Setter for team name.
  void setTeamName(String teamName) {
    _teamName = teamName;
  }

  /// Getter for team name.
  String getTeamName() {
    return _teamName;
  }

  /// Setter for team size.
  void setTeamSize(int teamSize) {
    _teamSize = teamSize;
  }

  /// Getter for team size.
  int getTeamSize() {
    return _teamSize;
  }

  /// Getter for already played time formatted as a string.
  String getAlreadyPlayedTime() {
    var secs = _stopWatch.elapsedMilliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  /// Getter for already used hints as a string.
  String getAlreadyUsedHints() {
    return "$_hintsUsed/$_totalHints";
  }

  /// Getter for already shown texts.
  List<String> getAlreadyShownTexts() {
    return _alreadyShownTexts;
  }

  /// Adds new texts to the already shown ones, along with a seperator.
  void _addTextsToAlreadyShown(List<String> texts) {
    if (_alreadyShownTexts.isNotEmpty) {
      _alreadyShownTexts.add("- - - - - - - - - - - - - - -");
    }
    _alreadyShownTexts.addAll(texts);
  }

  /// Getter for currently available hints.
  List<Hint> getCurrentHints() {
    return _currentHints;
  }

  /// Updates the current list of hints.
  void updateCurrentHints(List<String> hintTexts) {
    _currentHints.clear();
    for (String text in hintTexts) {
      _currentHints.add(Hint(text));
    }
    _totalHints += _currentHints.length;
  }

  /// Increase the counter of used hints.
  void useHint() {
    _hintsUsed += 1;
  }

  /// To start the game resp. the state machine.
  bool start() {
    if (_state != gameState.none) {
      return false;
    }
    print("Game started");
    _state = gameState.none;
    _puzzle = null;
    _stopWatch.start();
    _addTextsToAlreadyShown(gameStartTexts);
    nextState();
    return true;
  }

  /// Resets the game in order to start it again.
  void reset() {
    _context = null;
    _teamName = "";
    _teamSize = 0;
    _state = gameState.none;
    _puzzle = null;
    _stopWatch.reset();
    _alreadyShownTexts.clear();
    _currentHints.clear();
    _totalHints = 0;
    _hintsUsed = 0;
  }

  /// Callback for map when location of player changed.
  void onLocationChanged(LatLng coords) {
    //print("Location changed.");
    if ((_puzzle == null) || !isSearchingForPuzzle()) {
      return;
    }
    LatLng pCoords = _puzzle.getStartLocation();
    double distance = Geolocator.distanceBetween(
        coords.latitude, coords.longitude, pCoords.latitude, pCoords.longitude);
    if (distance <= 10) {
      // TODO:
      // Uncomment this to use real puzzle location check.
      /*nextState();
      _puzzle.setFinishedCallback(onPuzzleFinished);
      storyIntroWidgetyKey.currentState.show(_puzzle.getIntroTexts(), onStartPuzzle, true);
      _addTextsToAlreadyShown(_puzzle.getIntroTexts());*/
    }
  }

  /// Callback for starting a puzzle after the intro text was displayed.
  void onStartPuzzle() {
    if (_puzzle == null) {
      return;
    }
    nextState();
    _puzzle.startPuzzle(_context);
  }

  /// Callback for puzzles when puzzle is finished.
  void onPuzzleFinished() {
    if (_puzzle == null) {
      return;
    }
    nextState();
    storyOutroWidgetyKey.currentState
        .show(_puzzle.getOutroTexts(), nextState, false);
    _addTextsToAlreadyShown(_puzzle.getOutroTexts());
    _puzzle = null;
  }

  /// Sets the state machine into the next state.
  void nextState() {
    if (_state.index < (gameState.values.length - 1)) {
      _state = gameState.values[_state.index + 1];
    }
    if (_state == gameState.searchPuzzle1) {
      _puzzle = Puzzle1.getInstance();
    } else if (_state == gameState.searchPuzzle2) {
      _puzzle = Puzzle2.getInstance();
    } else if (_state == gameState.searchPuzzle3) {
      _puzzle = Puzzle3();
    }
    _currentHints.clear();
    if ((_puzzle != null) && isSearchingForPuzzle()) {
      updateCurrentHints(_puzzle.getPuzzleSearchHints());
    }

    ///added by Sabari KM-------------
    switch (_state) {
      case gameState.searchPuzzle2:
        MainVariables.progressValue = 0.33;

        ///added by Sabari KM
        GameProgressbarState.getInstance().setStateCallback();
        break;

      case gameState.searchPuzzle3:
        MainVariables.progressValue = 0.66;

        ///added by Sabari KM
        GameProgressbarState.getInstance().setStateCallback();
        break;

      // case gameState.outroPuzzle3:
      //   MainVariables.progressValue = 1.0;///added by Sabari KM
      //   GameProgressbarState.getInstance().setStateCallback();
      //   break;
      case gameState.end:
        MainVariables.progressValue = 1.0;

        ///added by Sabari KM
        GameProgressbarState.getInstance().setStateCallback();
        break;
      default:
        break;
    }

    ///-------------------------------
    ///
    _testPrintState();
  }

  /// Checks if the player is currently searching for one of the puzzles.
  bool isSearchingForPuzzle() {
    switch (_state) {
      case gameState.searchPuzzle1:
      case gameState.searchPuzzle2:
      case gameState.searchPuzzle3:
        return true;
      default:
        return false;
    }
  }

  // Functions for development & testing

  /// Test callback for reaching the location for puzzle 1.
  void testOnPuzzleLocation() {
    if (!isSearchingForPuzzle()) {
      return;
    }
    nextState();
    _puzzle.setFinishedCallback(onPuzzleFinished);
    storyIntroWidgetyKey.currentState
        .show(_puzzle.getIntroTexts(), onStartPuzzle, true);
    _addTextsToAlreadyShown(_puzzle.getIntroTexts());
  }

  void _testPrintState() {
    String temp = "In state: ";
    switch (_state) {
      case gameState.start:
        temp += "Start";
        break;
      case gameState.searchPuzzle1:
        temp += "Puzzle 1 Search";
        break;
      case gameState.introPuzzle1:
        temp += "Puzzle 1 Intro";
        break;
      case gameState.puzzle1:
        temp += "Puzzle 1";
        break;
      case gameState.outroPuzzle1:
        temp += "Puzzle 1 Outro";
        break;
      case gameState.searchPuzzle2:
        temp += "Puzzle 2 Search";
        break;
      case gameState.introPuzzle2:
        temp += "Puzzle 2 Intro";
        break;
      case gameState.puzzle2:
        temp += "Puzzle 2";
        break;
      case gameState.outroPuzzle2:
        temp += "Puzzle 2 Outro";
        break;
      case gameState.searchPuzzle3:
        temp += "Puzzle 3 Search";
        break;
      case gameState.introPuzzle3:
        temp += "Puzzle 3 Intro";
        break;
      case gameState.puzzle3:
        temp += "Puzzle 3";
        break;
      case gameState.outroPuzzle3:
        temp += "Puzzle 3 Outro";
        break;
      case gameState.end:
        temp += "End";
        break;
      default:
        temp += "None";
        break;
    }
    print(temp + ".");
  }
}
