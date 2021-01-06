import 'package:flutter/material.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
class Puzzle2Screen extends StatefulWidget {
  @override
  Puzzle2ScreenState createState() => Puzzle2ScreenState();
}

class Puzzle2ScreenState extends State<Puzzle2Screen> {
  // @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scavenger Hunt 2'),
      ),

      ///add image
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ' Find the correct binary number.',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
          Text(
            '\r\n Hint:',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
          Image(
            image: AssetImage('assets/555.png'),
            width: 200,
            height: 200,
          ),
          FlatButton(
            child: Text(
              '1010101010',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
            ),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'some text',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            },
          ),
          FlatButton(
            child: Text(
              '1000101011',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
            ),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'some text',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            },
          ),
          FlatButton(
            child: Text(
              '1001101011',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
            ),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'some text',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            },
          ),
          FlatButton(
            child: Text(
              '1100101011',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
            ),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'some text',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            },
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: FlatButton(
              child: Text(
                'Quit',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                Puzzle2.getInstance().onFinished();
                Navigator.of(context).pop();

              },
              padding: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
