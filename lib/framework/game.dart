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
  GlobalKey<StoryWidgetState> storyIntroWidgetyKey = GlobalKey();
  GlobalKey<StoryWidgetState> storyOutroWidgetyKey = GlobalKey();

  BuildContext _context;
  gameState _state = gameState.none;
  PuzzleBase _puzzle;
  List<String> _gameStartTexts = ["Start 1", "Start 2", "Start 3"];

  /// Setter for the BuildContext with which the puzzles start function is called.
  void setContext(BuildContext context) {
    _context = context;
  }

  /// To start the game resp. the state machine.
  void start() {
    if ((_state != gameState.none) && (_state != gameState.end)) {
      return;
    }
    _state = gameState.none;
    _puzzle = null;
    _nextState();
    storyIntroWidgetyKey.currentState.show(_gameStartTexts, _nextState, true);
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
    _nextState();
    _puzzle.startPuzzle(_context);
  }

  /// Callback for puzzles when puzzle is finished.
  void onPuzzleFinished() {
    if (_puzzle == null) {
      return;
    }
    _nextState();
    storyOutroWidgetyKey.currentState.show(_puzzle.getOutroTexts(), _nextState, false);
    _puzzle = null;
  }

  /// Sets the state machine into the next state.
  void _nextState() {
    if (_state.index < (gameState.values.length - 1)) {
      _state = gameState.values[_state.index + 1];
    }
    _testPrintState();
  }

  // Functions for development & testing

  /// Test callback for reaching the location for puzzle 1.
  void testOnPuzzleLocation() {
    if (_state == gameState.searchPuzzle1) {
      _puzzle = Puzzle1();
    } else if (_state == gameState.searchPuzzle2) {
      _puzzle = Puzzle2();
    } else if (_state == gameState.searchPuzzle3) {
      _puzzle = Puzzle3();
    } else {
      return;
    }
    _nextState();
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
