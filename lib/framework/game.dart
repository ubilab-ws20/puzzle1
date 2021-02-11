import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ubilab_scavenger_hunt/globals.dart';
import 'package:ubilab_scavenger_hunt/puzzle_base/puzzleBase.dart';
import 'package:ubilab_scavenger_hunt/puzzle_1/puzzle1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/puzzle3.dart';
import 'gameProgressBar.dart';
import 'storyWidget.dart';
import 'hint.dart';
import 'storyText.dart';

enum gameState {
  none,
  start,
  searchPuzzle1,
  introPuzzle1,
  puzzle1,
  outroPuzzle1,
  searchPuzzle3,
  introPuzzle3,
  puzzle3,
  outroPuzzle3,
  searchPuzzle2,
  introPuzzle2,
  puzzle2,
  outroPuzzle2,
  end,
}

class Game {
  static Game _instance;

  GlobalKey<StoryWidgetState> storyIntroWidgetyKey = GlobalKey();
  GlobalKey<StoryWidgetState> storyOutroWidgetyKey = GlobalKey();
  GlobalKey<GameProgressBarState> gameProgressBarStateKey = GlobalKey();

  List<StoryText> gameStartTexts = [
    StoryText("A few days ago something mysterious happened in Freiburg.", false),
    StoryText("The famous and ingenious Prof. Dr. Y has disappeared and no one really knows what has happend to him.", false),
    StoryText("The official version is that he is suffering from a severe illness.", false),
    StoryText("But people who were working closely with him are heavily doubting this.", false),
    StoryText("While thinking about the real reason for his disappearance you see a strange text message popping up on your phone. It says:", false),
    StoryText("Scientists discovered the key elements for a balanced, peaceful and happy life. The first one of them is healthy nutrition. So whY don't you go and search for the right food for your personal needs?", true),
    StoryText("Strange...", false)
  ];

  BuildContext _context;
  String _teamName = "";
  int _teamSize = 0;
  gameState _state = gameState.none;
  PuzzleBase _puzzle;

  Stopwatch _stopWatch = Stopwatch();
  List<StoryText> _alreadyShownTexts = [];

  List<Hint> _currentHints = [];
  int _totalHints = 0;
  int _hintsUsed = 0;
  double _progress = 0.01;

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

  /// Getter (deep copy) for already shown texts.
  List<StoryText> getAlreadyShownTexts() {
    List<StoryText> alreadyShownTexts = [];
    for (StoryText storyText in _alreadyShownTexts) {
      alreadyShownTexts.add(StoryText(storyText.text, storyText.fromAi));
    }
    return alreadyShownTexts;
  }

  /// Adds new texts to the already shown ones, along with a seperator.
  void addTextsToAlreadyShown(List<StoryText> texts) {
    if (_alreadyShownTexts.isNotEmpty) {
      _alreadyShownTexts.add(StoryText("- - - - - - - - - - - - - - -", false));
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
    globalMqttManager.publishGameDetails();
  }

  /// Increase the counter of used hints.
  void useHint() {
    _hintsUsed += 1;
  }

  /// Getter for current game progress value.
  double getProgress() {
    return _progress;
  }

  /// To start the game resp. the state machine.
  bool start() {
    if (_state != gameState.none) {
      return false;
    }
    _state = gameState.none;
    _puzzle = null;
    _stopWatch.start();
    addTextsToAlreadyShown(gameStartTexts);
    nextState();
    globalMqttManager.connect();
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
    _progress = 0.01;
    globalMqttManager.disconnect();
  }

  /// Callback for map when location of player changed.
  void onLocationChanged(LatLng coords) {
    currentLocation.latitude = coords.latitude;
    currentLocation.longitude = coords.longitude;
    if ((_puzzle == null) || !isSearchingForPuzzle()) {
      return;
    }
    LatLng pCoords = _puzzle.getStartLocation();
    double distance = Geolocator.distanceBetween(
        coords.latitude, coords.longitude, pCoords.latitude, pCoords.longitude);
    if (distance <= 10) {
      nextState();
      _puzzle.setFinishedCallback(onPuzzleFinished);
      storyIntroWidgetyKey.currentState
          .show(_puzzle.getIntroTexts(), onStartPuzzle, true);
      addTextsToAlreadyShown(_puzzle.getIntroTexts());
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
    addTextsToAlreadyShown(_puzzle.getOutroTexts());
    _puzzle = null;
  }

  /// Sets the state machine into the next state.
  void nextState() {
    if (_state.index < (gameState.values.length - 1)) {
      _state = gameState.values[_state.index + 1];
    }
    // Update puzzle instance
    if (_state == gameState.searchPuzzle1) {
      _puzzle = Puzzle1.getInstance();
    } else if (_state == gameState.searchPuzzle2) {
      _puzzle = Puzzle2.getInstance();
    } else if (_state == gameState.searchPuzzle3) {
      _puzzle = Puzzle3.getInstance();
    }
    // Update hints
    _currentHints.clear();
    if ((_puzzle != null) && isSearchingForPuzzle()) {
      updateCurrentHints(_puzzle.getPuzzleSearchHints());
    }
    // Update game progress
    if (_state == gameState.introPuzzle1) {
      _progress = 0.166; // Found puzzle 1
      gameProgressBarStateKey.currentState.setStateCallback();
    } else if (_state == gameState.outroPuzzle1) {
      _progress = 0.333; // Finished puzzle 1
      gameProgressBarStateKey.currentState.setStateCallback();
    } else if (_state == gameState.introPuzzle3) {
      _progress = 0.5; // Found puzzle 3
      gameProgressBarStateKey.currentState.setStateCallback();
    } else if (_state == gameState.outroPuzzle3) {
      _progress = 0.666; // Finished puzzle 3
      gameProgressBarStateKey.currentState.setStateCallback();
    } else if (_state == gameState.introPuzzle2) {
      _progress = 0.833; // Found puzzle 2
      gameProgressBarStateKey.currentState.setStateCallback();
    } else if (_state == gameState.outroPuzzle2) {
      _progress = 1.0; // Finished puzzle 2
      gameProgressBarStateKey.currentState.setStateCallback();
    }
    // MQTT
    globalMqttManager.publishGameDetails();
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

  int getCurrentPuzzleInfo() {
    switch (_state) {
      case gameState.puzzle1:
      case gameState.introPuzzle1:
      case gameState.searchPuzzle1:
      case gameState.outroPuzzle1:
        return 1;
      case gameState.puzzle2:
      case gameState.introPuzzle2:
      case gameState.searchPuzzle2:
      case gameState.outroPuzzle2:
        return 3;
      case gameState.puzzle3:
      case gameState.introPuzzle3:
      case gameState.searchPuzzle3:
      case gameState.outroPuzzle3:
        return 2;
      default:
        return 0;
    }
  }

  // Functions for development & testing

  /// Test callback for reaching a puzzle location.
  void testOnPuzzleLocation() {
    if (!isSearchingForPuzzle()) {
      return;
    }
    nextState();
    _puzzle.setFinishedCallback(onPuzzleFinished);
    storyIntroWidgetyKey.currentState
        .show(_puzzle.getIntroTexts(), onStartPuzzle, true);
    addTextsToAlreadyShown(_puzzle.getIntroTexts());
  }

  /// Prints the current state of the game.
  void _testPrintState() {
    if (!globalIsTesting) {
      return;
    }
    String temp = "Game: In state: ";
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
