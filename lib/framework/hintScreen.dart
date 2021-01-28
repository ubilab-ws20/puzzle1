import 'package:flutter/material.dart';
import 'dart:async';
import 'game.dart';
import 'hint.dart';

const String stringHints = "Hints";
const String stringPreviousHints = "All previous hints have to be opened first.";
const String stringOk = "Ok";
const String stringUseHint = "Do you really want to use a hint?";
const String stringCancel = "Cancel";
const String stringUse = "Use";

/// Method to get the hint icon button s.t. it always looks the same.
Widget hintIconButton(BuildContext context) {
  return HintIconButton();
}

class HintIconButton extends StatefulWidget {
  @override
  _HintIconButtonState createState() => _HintIconButtonState();
}

class _HintIconButtonState extends State<HintIconButton> {
  Timer _timer;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    List<Hint> hints = Game.getInstance().getCurrentHints();
    _isVisible = hints.isNotEmpty;
    _timer = new Timer.periodic(new Duration(milliseconds: 25), (timer) {
      setState(() {
        List<Hint> hints = Game.getInstance().getCurrentHints();
        _isVisible = hints.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisible,
      child: IconButton(
        icon: Icon(
          Icons.help,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return HintScreen();
                  }
              )
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}


class HintScreen extends StatefulWidget {
  @override
  _HintScreenState createState() => _HintScreenState();
}

class _HintScreenState extends State<HintScreen> {
  List<Hint> _hints;

  @override
  Widget build(BuildContext context) {
    _hints = Game.getInstance().getCurrentHints();
    return Scaffold(
      appBar: AppBar(
        title: Text(stringHints),
      ),
      body: SafeArea(
        child: _hintsListView(),
      ),
    );
  }

  /// Callback when a locked hint is pressed.
  void _onUseHintPressed(int index) {
    Hint hint = _hints[index];
    if ((index >= 1) && !_hints[index - 1].isUsed()) {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(
              stringPreviousHints,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(stringOk),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ],
          );
        },
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            stringUseHint,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(stringCancel),
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
            FlatButton(
              child: Text(stringUse),
              onPressed: () {
                hint.setUsed();
                Game.getInstance().useHint();
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// List view of all current hints.
  Widget _hintsListView() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: ListView.builder(
        itemCount: (_hints.length * 2),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }
          return _hintBox(i ~/ 2);
        }
      ),
    );
  }

  /// Single hint, either locked or unlocked & shown.
  Widget _hintBox(int index) {
    Hint hint = _hints[index];
    if (hint.isUsed()) {
      return _usedHint(hint);
    } else {
      return _unusedHint(index);
    }
  }

  /// Used hint, showing the text.
  Widget _usedHint(Hint hint) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 30.0,
            ),
          ),
          Text(
            hint.getText(),
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  /// Unused hint, only showing a lock icon.
  Widget _unusedHint(int index) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: IconButton(
        icon: Icon(Icons.lock),
        onPressed: () {
          _onUseHintPressed(index);
        },
      ),
    );
  }
}