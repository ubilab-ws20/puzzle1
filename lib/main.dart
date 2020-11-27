// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'gameMainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ubilab Scavenger Hunt',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ubilab Scavenger Hunt')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  child: Text('Operator Team'),
                  onPressed: () { pushOperatorTeam(context); },
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  child: Text('Puzzle Team 1'),
                  onPressed: () { pushPuzzleTeam1(context); },
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  child: Text('Puzzle Team 2'),
                  onPressed: () { pushPuzzleTeam2(context); },
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  child: Text('Puzzle Team 3'),
                  onPressed: () { pushPuzzleTeam3(context); },
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  void pushOperatorTeam(BuildContext context) {
  }

  void pushPuzzleTeam1(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return GameMap();
      })
    );
  }

  void pushPuzzleTeam2(BuildContext context) {
  }

  void pushPuzzleTeam3(BuildContext context) {
  }
}
