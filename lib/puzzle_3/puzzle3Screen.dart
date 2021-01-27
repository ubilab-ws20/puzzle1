import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';
import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import '../puzzle_base/puzzleBase.dart';
import 'puzzle3.dart';

double height = 0.0, width = 0.0;
double refHeight = 683.4, refWidth = 411.4;

class SecondRoute extends StatefulWidget {
 /*SecondRoute({
    Key key,
    this.parameter,
  }): super(key: key);
  final parameter;*/
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class ThirdRoute extends StatefulWidget {
  ThirdRoute({
    Key key,
    this.parameter,
  }): super(key: key);
  final parameter;
  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}


Color c5 = Colors.blue;
double soundIconSize = 60;


class _ThirdRouteState extends State<ThirdRoute > {

  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  int lastKnock = 0;
  int lastKnockTime = 0;
  bool disableKnock = false;
  int disableTime = 0;
  List<int> growableList = [];

  @override
  void initState() {
    super.initState();
    _noiseMeter = new NoiseMeter(onError);
  }

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) {
        this._isRecording = true;
      }
    });

    if (DateTime.now().millisecondsSinceEpoch - disableTime > 250) {
      disableKnock = false;
      c5 = Colors.blue;
      soundIconSize = 60;
    }

    if (noiseReading.maxDecibel > 70 && !disableKnock) {
      int time = DateTime.now().millisecondsSinceEpoch;
      growableList.add(time);
      print('knock');
      c5 = Colors.red;
      soundIconSize = 100;
      disableKnock = true;
      disableTime = DateTime.now().millisecondsSinceEpoch;

      //Check for pattern 2 1 1 2
      if (growableList.length >= 5) {
        int len = growableList.length;
        int distance = growableList[4] - growableList[0], distance43 = growableList[4] - growableList[3], distance32 = growableList[3] - growableList[2], distance21 = growableList[2] - growableList[1], distance10 = growableList[1] - growableList[0];
        if (distance < 5000) {
          if ( distance43 > (distance/3 - 250)  && distance43 < (distance/3 + 250) &&
              distance32 > (distance/6 - 250)  && distance32 < (distance/6 + 250) &&
              distance21 > (distance/6 - 250)  && distance21 < (distance/6 + 250) &&
              distance10 > (distance/3 - 250)  && distance10 < (distance/3 + 250)) {
            print('Puzzle solved');
            //finish puzzle
            Puzzle3.getInstance().onFinished();
            Navigator.of(context).pop();
          } else {
            print('pattern not correct');
          }
        } else {
          print('total pattern too long');
        }
        growableList.removeAt(0);
      }
    }
  }

  void onError(PlatformException e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    start();
    return Scaffold(
        appBar: AppBar(
          title: Text('The path'),
          automaticallyImplyLeading: false,
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/door2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
        child: Stack(
            children: <Widget>[
              CustomPaint( //                       <-- CustomPaint widget
                  size: Size(1000, 1000),
                  painter: MyPainter2()
              ),
              Positioned(
                top: 50*heightRatio,
                left: 15*widthRatio,
                child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.circle),
                        color: Colors.green,
                        onPressed: () {
                        },
                      ),
                      Text('Start')
                    ]),),
              Positioned(
                top: 50*heightRatio,
                left: 123*widthRatio,
                child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.circle),
                        color: Colors.green,
                        onPressed: () {
                        },
                      ),
                    ]),),
              Positioned(
                top: 50*heightRatio,
                left: 177*widthRatio,
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.green,
                  onPressed: () {
                  },
                ),),
              Positioned(
                top: 50*heightRatio,
                left: 231*widthRatio,
                child: IconButton(
                  icon: Icon(Icons.circle),
                  color: Colors.green,
                  onPressed: () {
                  },
                ),),
              Positioned(
                top: 50*heightRatio,
                left: 340*widthRatio,
                child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.circle),
                        color: Colors.green,
                        onPressed: () {
                        },
                      ),
                      Text('End')
                    ]),),
              Positioned(
                top: 50*heightRatio,
                left: (15*widthRatio+123*widthRatio)/2+20,
                child: Column(
                    children: <Widget>[
                      Text('1.8', style:  TextStyle(fontWeight: FontWeight.bold))
                    ]),),
              Positioned(
                top: 50*heightRatio,
                left: (123*widthRatio+177*widthRatio)/2+20,
                child: Column(
                    children: <Widget>[
                      Text('0.9', style:  TextStyle(fontWeight: FontWeight.bold))
                    ]),),
              Positioned(
                top: 50*heightRatio,
                left: (177*widthRatio+231*widthRatio)/2+20,
                child: Column(
                    children: <Widget>[
                      Text('0.9', style:  TextStyle(fontWeight: FontWeight.bold))
                    ]),),
              Positioned(
                top: 50*heightRatio,
                left: (231*widthRatio+340*widthRatio)/2+20,
                child: Column(
                    children: <Widget>[
                      Text('1.8', style:  TextStyle(fontWeight: FontWeight.bold))
                    ]),),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.text_snippet_outlined),
                      iconSize: 60,
                      color: Colors.blue,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return MyAlertDialog(title: 'Use your imagination.', content: 'Sometimes there is no well known solution for a problem and some creativity is required. Imagination is a powerfull tool, to think outside the box and to make sense of seemingly unconnected things. How could the information of the extracted path connect to this sound icon?');
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              /*Positioned(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('"Use your imagination". Sometimes there is no well known solution for a problem and some creativity is required. Imagination is a powerfull tool, to think outside the box and to make sense of seemingly unconnected things. How could the information of the extracted path connect to this sound icon?', style:  TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ),
              ),*/
              Positioned(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.volume_up),
                      iconSize: soundIconSize,
                      color: c5,
                      onPressed: () {
                      },
                    ),
                  ),
                ),
              ),
            ]
        ))
    );
  }

}

double heightRatio;
double widthRatio;
double x0 , x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11;

Color c1 = Colors.blue;
Color c2 = Colors.blue;
Color c3 = Colors.blue;
Color c4 = Colors.blue;
Color cursorColor = Color.fromRGBO(255, 0, 0, 0);

bool checkReachedNode(double x, double y) {
  if ( (x > x0+15 && x < x0+30 && y > y0+95 && y < y0+110) || (x > x1+15 && x < x1+30 && y > y1+95 && y < y1+110) ||
      (x > x2+15 && x < x2+30 && y > y2+95 && y < y2+110) || (x > x3+15 && x < x3+30 && y > y3+95 && y < y3+110) ||
      (x > x4+15 && x < x4+30 && y > y4+95 && y < y4+110) || (x > x5+15 && x < x5+30 && y > y5+95 && y < y5+110) ||
      (x > x6+15 && x < x6+30 && y > y6+95 && y < y6+110) || (x > x7+15 && x < x7+30 && y > y7+95 && y < y7+110) ||
      (x > x8+15 && x < x8+30 && y > y8+95 && y < y8+110) || (x > x9+15 && x < x9+30 && y > y9+95 && y < y9+110) ||
      (x > x10+15 && x < x10+30 && y > y10+95 && y < y10+110) || (x > x11+15 && x < x11+30 && y > y11+95 && y < y11+110)) {
    return true;
  }
  return false;
}

double xpos = 0.0, ypos = 0.0;
double nodex = x0, nodey = y0;

class _SecondRouteState extends State<SecondRoute > {

  List<String> hintGraph = [
    "Find the shortest path in the graph!",
  ];
  List<String> hintKnock = [
    "Notice how the sound icon changes when you produce a (louder) sound. Works best in silent environemnts!",
      "Why is there a door knocker in the background?",
        "What could the edge weights of the path represent?",
          "Try knocking with path nodes representing knocks, and edge weights representing pauses in between.",
  ];
  @override
  void initState() {
    super.initState();
    Game.getInstance().updateCurrentHints(hintGraph);
  }


  BuildContext scaffoldContext;
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;
  int lastNode = 0;

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    double X = details.position.dx;
    double Y = details.position.dy;
    xpos = X;
    ypos = Y;
    setState(() {
      x = X;
      y = Y;
    });
    if (X > x0 + 15 && X < x0 + 30 && Y > y0 + 95 && Y < y0 + 110 &&
        lastNode == 0) {
      nodex = x0;
      nodey = y0;
      lastNode = 1;
      c1 = Colors.green;
      cursorColor = Color.fromRGBO(255, 0, 0, 0.4);
      print("first node");
    }
    if (checkReachedNode(X, Y)) {
      if (!(X > x0 + 15 && X < x0 + 30 && Y > y0 + 95 && Y < y0 + 110) &&
          lastNode == 1) {
        if (X > x3 + 15 && X < x3 + 30 && Y > y3 + 95 && Y < y3 + 110) {
          lastNode = 2;
          nodex = x3;
          nodey = y3;
          c2 = Colors.green;
          print("second node");
        } else {
          c1 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
          cursorColor = Color.fromRGBO(255, 0, 0, 0);
        }
      }

      if (!(X > x3 + 15 && X < x3 + 30 && Y > y3 + 95 && Y < y3 + 110) &&
          lastNode == 2){
        if (X > x5 + 15 && X < x5 + 30 && Y > y5 + 95 && Y < y5 + 110) {
          lastNode = 3;
          nodex = x5;
          nodey = y5;
          c3 = Colors.green;
          print("thrid node");
        } else {
          c1 = Colors.blue;
          c2 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
          cursorColor = Color.fromRGBO(255, 0, 0, 0);
        }
      }

      if (!(X > x5 + 15 && X < x5 + 30 && Y > y5 + 95 && Y < y5 + 110) &&
          lastNode == 3){
        if (X > x11 + 15 && X < x11 + 30 && Y > y11 + 95 && Y < y11 + 110) {
          lastNode = 4;
          nodex = x11;
          nodey = y11;
          c4 = Colors.green;
          print("fourth node");
        } else {
          c1 = Colors.blue;
          c2 = Colors.blue;
          c3 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
          cursorColor = Color.fromRGBO(255, 0, 0, 0);
        }
      }

      if(!(X > x11 + 15 && X < x11 + 30 && Y > y11 + 95 && Y < y11 + 110) && lastNode == 4){
        cursorColor = Color.fromRGBO(255, 0, 0, 0);
        if (X > x1+15 && X < x1+30 && Y > y1+95 && Y < y1+110 ) {
          lastNode = 5;
          c5 = Colors.green;
          // switch to the next screen
        } else {
          c1 = Colors.blue;
          c2 = Colors.blue;
          c3 = Colors.blue;
          c4 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
        }
      }

    }

  }

  Widget ourButton(BuildContext context) {
    final snackBar = new SnackBar(content: new Text("aa"),
        backgroundColor: Colors.red);
    //Scaffold.of(context).showSnackBar(snackBar);
    return lastNode == 5 ?
    ElevatedButton(
      child: Text('Continue'),
      onPressed: () {
        Game.getInstance().updateCurrentHints(hintKnock);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ThirdRoute()),
        );
      },
    ) :
    Container();
  }

  Widget ourText() {
    return lastNode == 5 ?
    Text("Congratulations! You have found the correct path!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        :
    Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16) );
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    // Additional code
  }
  @override
  void dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    if (height < width) {
      refWidth = 683.4;
      refHeight = 411.4;
    }
    heightRatio = height/refHeight;
    widthRatio = width/refWidth;
    x0 = 50*heightRatio; y0 = 150*widthRatio; x1 = 600*heightRatio; y1 = 150*widthRatio; x2 = 350*heightRatio; y2 = 50*widthRatio; x3 = 150*heightRatio; y3 = 50*widthRatio; x4 = 153*heightRatio; y4 = 103*widthRatio; x5 = 239*heightRatio ;
    y5 = 240*widthRatio; x6 = 135*heightRatio; y6 = 201*widthRatio; x7 = 400*heightRatio; y7 = 250*widthRatio; x8 = 489*heightRatio; y8 = 105*widthRatio; x9 = 350*heightRatio; y9 = 189*widthRatio; x10 = 230*heightRatio; y10 = 130*widthRatio; x11 = 530*heightRatio; y11 = 200*widthRatio;

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
        appBar: AppBar(
          title: Text("The path"),
          automaticallyImplyLeading: false,
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: Builder(
          builder: (context) => Stack(
              children: <Widget>[
                CustomPaint( //                       <-- CustomPaint widget
                    size: Size(1000, 1000),
                    painter: MyPainter()
                ),
                Positioned(
                  top: y1,
                  left: x1,
                  child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.circle),
                          color: c5,
                          onPressed: () {
                          },
                        ),
                        Text("End")
                      ]),),
                Positioned(
                  top: y0,
                  left: x0,
                  child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.circle),
                          color: c1,
                          onPressed: () {
                          },
                        ),
                        Text("Start")
                      ]),),
                Positioned(
                  top: y2,
                  left: x2,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: Colors.blue,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y3,
                  left: x3,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: c2,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y4,
                  left: x4,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: Colors.blue,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y5,
                  left: x5,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: c3,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y6,
                  left: x6,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: Colors.blue,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y7,
                  left: x7,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: Colors.blue,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y8,
                  left: x8,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: Colors.blue,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y9,
                  left: x9,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: Colors.blue,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y10,
                  left: x10,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: Colors.blue,
                    onPressed: () {
                    },
                  ),),
                Positioned(
                  top: y11,
                  left: x11,
                  child: IconButton(
                    icon: Icon(Icons.circle),
                    color: c4,
                    onPressed: () {
                    },
                  ),),
                ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(1000.0, 1000.0)),
                  child: Listener(
                    onPointerDown: _incrementDown,
                    onPointerMove: _updateLocation,
                    onPointerUp: _incrementUp,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                  ),),
                Positioned(
                  top: 250*widthRatio,
                  left: 580*heightRatio,
                  child: Column(
                      children: <Widget>[
                        ourButton(context)
                      ]),),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: ourText()
                    ),
                  ),
                ),
                Positioned(
                  top: (y0+y3)/2+10,
                  left: (x0+x3)/2+5,
                  child: Column(
                      children: <Widget>[
                        Text('1.8')
                      ]),),
                Positioned(
                  top: (y5+y3)/2+15,
                  left: (x5+x3)/2+30,
                  child: Column(
                      children: <Widget>[
                        Text('0.9')
                      ]),),
                Positioned(
                  top: (y5+y11)/2+10,
                  left: (x5+x11)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('0.9')
                      ]),),
                Positioned(
                  top: (y11+y1)/2+12,
                  left: (x11+x1)/2+7,
                  child: Column(
                      children: <Widget>[
                        Text('1.8')
                      ]),),
                Positioned(
                  top: (y0+y2)/2+15,
                  left: (x0+x2)/2+65,
                  child: Column(
                      children: <Widget>[
                        Text('1.6')
                      ]),),
                Positioned(
                  top: (y2+y5)/2+10,
                  left: (x2+x5)/2+5,
                  child: Column(
                      children: <Widget>[
                        Text('2.7')
                      ]),),
                Positioned(
                  top: (y10+y3)/2+10,
                  left: (x10+x3)/2+25,
                  child: Column(
                      children: <Widget>[
                        Text('3.5')
                      ]),),
                Positioned(
                  top: (y10+y7)/2+5,
                  left: (x10+x7)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('3')
                      ]),),
                Positioned(
                  top: (y11+y7)/2+10,
                  left: (x11+x7)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('2')
                      ]),),
                Positioned(
                  top: (y6+y8)/2+10,
                  left: (x6+x8)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('3.5')
                      ]),),
                Positioned(
                  top: (y9+y1)/2+10,
                  left: (x9+x1)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('1')
                      ]),),
                Positioned(
                  top: (y9+y2)/2+10,
                  left: (x9+x2)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('3')
                      ]),),
                Positioned(
                  top: (y0+y6)/2+5,
                  left: (x0+x6)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('1.4')
                      ]),),
                Positioned(
                  top: (y4+y6)/2+10,
                  left: (x4+x6)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('1.5')
                      ]),),
                Positioned(
                  top: (y4+y3)/2+15,
                  left: (x4+x3)/2+5,
                  child: Column(
                      children: <Widget>[
                        Text('1.7')
                      ]),),
                Positioned(
                  top: (y2+y3)/2+10,
                  left: (x2+x3)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('2')
                      ]),),
                Positioned(
                  top: (y8+y2)/2+5,
                  left: (x8+x2)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('2.5')
                      ]),),
                Positioned(
                  top: (y8+y1)/2+5,
                  left: (x8+x1)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('1.8')
                      ]),),
                Positioned(
                  top: (y6+y5)/2+5,
                  left: (x6+x5)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('3')
                      ]),),
                Positioned(
                  top: (y7+y8)/2,
                  left: (x7+x8)/2+15,
                  child: Column(
                      children: <Widget>[
                        Text('0.9')
                      ]),),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(Icons.text_snippet_outlined),
                        iconSize: 60,
                        color: Colors.blue,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return MyAlertDialog(title: 'Life is like a graph.', content: 'There are different scenarios (nodes) and different choices (edges) connecting them. On the way to your goal, there are many possible paths to chose from. To make a plan you optimally find the shortest path to your goal and make your choice accordingly.');
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ]),)

    ));
  }

}


class MyPainter extends CustomPainter { //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    final p0 = Offset(x0+25, y0+25);
    final p1 = Offset(x1+25, y1+25);
    final p2 = Offset(x2+25, y2+25);
    final p3 = Offset(x3+25, y3+25);
    final p4 = Offset(x4+25, y4+25);
    final p5 = Offset(x5+25, y5+25);
    final p6 = Offset(x6+25, y6+25);
    final p7 = Offset(x7+25, y7+25);
    final p8 = Offset(x8+25, y8+25);
    final p9 = Offset(x9+25, y9+25);
    final p10 = Offset(x10+25, y10+25);
    final p11 = Offset(x11+25, y11+25);
    final node = Offset(nodex+25, nodey+25);
    final cursor = Offset(xpos,ypos-75);
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;
    final paint1 = Paint()
      ..color = c2
      ..strokeWidth = 4;
    final paint2 = Paint()
      ..color = c3
      ..strokeWidth = 4;
    final paint3 = Paint()
      ..color = c4
      ..strokeWidth = 4;
    final paint4 = Paint()
      ..color = c5
      ..strokeWidth = 4;
    final paintCursor = Paint()
      ..color = cursorColor
      ..strokeWidth = 4;
    canvas.drawLine(p0, p3, paint1);
    canvas.drawLine(p3, p5, paint2);
    canvas.drawLine(p5, p11, paint3);
    canvas.drawLine(p11, p1, paint4);
    canvas.drawLine(p0, p2, paint);
    canvas.drawLine(p2, p5, paint);
    canvas.drawLine(p3, p10, paint);
    canvas.drawLine(p7, p10, paint);
    canvas.drawLine(p11, p7, paint);
    canvas.drawLine(p6, p8, paint);
    canvas.drawLine(p9, p1, paint);
    canvas.drawLine(p9, p2, paint);
    canvas.drawLine(p0, p6, paint);
    canvas.drawLine(p4, p6, paint);
    canvas.drawLine(p4, p3, paint);
    canvas.drawLine(p3, p2, paint);
    canvas.drawLine(p8, p2, paint);
    canvas.drawLine(p8, p1, paint);
    canvas.drawLine(p6, p5, paint);
    canvas.drawLine(p7, p8, paint);
    canvas.drawLine(node,cursor, paintCursor);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class MyPainter2 extends CustomPainter { //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    final p0 = Offset(15*widthRatio+25, 50*heightRatio+25);
    final p1 = Offset(123*widthRatio+25, 50*heightRatio+25);
    final p2 = Offset(177*widthRatio+25, 50*heightRatio+25);
    final p3 = Offset(231*widthRatio+25, 50*heightRatio+25);
    final p4 = Offset(340*widthRatio+25, 50*heightRatio+25);
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4;
    canvas.drawLine(p0, p1, paint);
    canvas.drawLine(p1, p2, paint);
    canvas.drawLine(p2, p3, paint);
    canvas.drawLine(p3, p4, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
