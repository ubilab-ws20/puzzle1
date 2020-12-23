import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/puzzle3.dart';
import 'storyWidget.dart';

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
  List<String> gameStartTexts = ["Start 1", "Start 2", "Start 3"];

  BuildContext _context;
  String _teamName = "";
  gameState _state = gameState.none;
  PuzzleBase _puzzle;

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

  /// To start the game resp. the state machine.
  bool start() {
    if (_state != gameState.none) {
      return false;
    }
    print("Game started with teamname: " + _teamName);
    _state = gameState.none;
    _puzzle = null;
    nextState();
    return true;
  }

  /// Resets the game in order to start it again.
  void reset() {
    _context = null;
    _teamName = "";
    _state = gameState.none;
    _puzzle = null;
  }

  /// Callback for map when location of player changed.
  void onLocationChanged(LatLng coords) {
    print("Location changed.");
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
    storyOutroWidgetyKey.currentState.show(_puzzle.getOutroTexts(), nextState, false);
    _puzzle = null;
  }

  /// Sets the state machine into the next state.
  void nextState() {
    if (_state.index < (gameState.values.length - 1)) {
      _state = gameState.values[_state.index + 1];
    }
    _testPrintState();
  }

  // Functions for development & testing

  /// Test callback for reaching the location for puzzle 1.
  void testOnPuzzleLocation() {
    if (_state == gameState.searchPuzzle1) {
      _puzzle = Puzzle1.getInstance();
    } else if (_state == gameState.searchPuzzle2) {
      _puzzle = Puzzle2();
    } else if (_state == gameState.searchPuzzle3) {
      _puzzle = Puzzle3();
    } else {
      return;
    }
    nextState();
    _puzzle.setFinishedCallback(onPuzzleFinished);
    storyIntroWidgetyKey.currentState.show(_puzzle.getIntroTexts(), onStartPuzzle, true);
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
