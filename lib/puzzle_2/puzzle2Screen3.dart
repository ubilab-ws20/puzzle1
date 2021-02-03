import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2MainScreen.dart';

import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';

import 'package:vibration/vibration.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';

class Puzzle2Screen3 extends StatefulWidget {
  @override
  Puzzle2Screen3State createState() => Puzzle2Screen3State();
}

class Puzzle2Screen3State extends State<Puzzle2Screen3> {
  Vector3 _orientation = Vector3.zero();
  int _groupValue = 0;

  List<String> hintTexts = [
    "Keeping a good diet requires right amount of flexibility "
        "in your system. It can be done by rotating your body right to left "
        "and repeat that till you feel that you have achieved your goal.",
  ];

  @override
  void initState() {
    super.initState();
    Game.getInstance().updateCurrentHints(hintTexts);
    motionSensors.orientationUpdateInterval =
        Duration.microsecondsPerSecond ~/ 1;
    motionSensors.isOrientationAvailable().then((available) {
      if (available) {
        motionSensors.orientation.listen((OrientationEvent event) {
          if (this.mounted) {
            setState(() {
              _orientation.setValues(event.yaw, event.pitch, event.roll);
            });
          }
        });
      }
    });
  }

  ///-----------------------------
/*
  void dataPlotAlert(double data) {
    AlertDialog(
      title: Text(
        data == 1
            ? 'high signal generated'
            : data == 0
                ? 'low signal generated'
                : 'no signal generated!',
        textAlign: TextAlign.center,
      ),
    );
  }
*/
  usageUpdate() {
    const hundredMillisecond = const Duration(milliseconds: 500);
    new Timer.periodic(
        hundredMillisecond,
            (Timer t) => (this.mounted)
            ? setState(() {
          Puzzle23Variables.timeCounter++;
          if (Puzzle23Variables.stopTimer) {
            // t.cancel();
            Puzzle23Variables.cpuUsage = 99;
            Puzzle23Variables.timeCounter = 0;
            Puzzle23Variables.stopTimer = false;
          } else if ((Puzzle23Variables.cpuUsage <= 100) &&
              (Puzzle23Variables.timeCounter == 1)) {
            Puzzle23Variables.cpuUsage -= 5;
          } else if (Puzzle23Variables.timeCounter == 2) {
            Puzzle23Variables.cpuUsage += 3;
          } else if (Puzzle23Variables.timeCounter == 3) {
            Puzzle23Variables.cpuUsage -= 3;
          } else if (Puzzle23Variables.timeCounter == 4) {
            Puzzle23Variables.cpuUsage += 4;
          } else if (Puzzle23Variables.timeCounter == 5) {
            Puzzle23Variables.cpuUsage -= 2;
          } else if (Puzzle23Variables.timeCounter == 6) {
            Puzzle23Variables.cpuUsage += 3;
          } else if (Puzzle23Variables.timeCounter == 7) {
            Puzzle23Variables.cpuUsage -= 3;
          } else if (Puzzle23Variables.timeCounter == 8) {
            Puzzle23Variables.timeCounter = 0;
            Puzzle23Variables.cpuUsage += 3;
          }
        })
            : null);
  }

  tiltToGenerateSignal() {
    if (!((degrees(_orientation.z) > 40) || (degrees(_orientation.z) < -40))) {
      // dataPlotAlert(2.0);
      Puzzle23Variables.phoneTilt = false;
      Puzzle23Variables.generateSignal = true;
    } else if (((degrees(_orientation.z) > 40) ||
        (degrees(_orientation.z) < -40))) {
      Puzzle23Variables.phoneTilt = true;
    }

    if ((Puzzle23Variables.phoneTilt == true) &&
        (Puzzle23Variables.generateSignal == true)) {
      if (Puzzle23Variables.pointCounter == 1) {
        Vibration.vibrate(duration: 100);
        if (degrees(_orientation.z) > 40)
          Puzzle23Variables.point1 = 2;
        else if (degrees(_orientation.z) < -40) Puzzle23Variables.point1 = 0;
        if ((degrees(_orientation.z) > 40) || (degrees(_orientation.z) < -40)) {
          // dataPlotAlert(Puzzle23Variables.point1);
          Puzzle23Variables.pointCounter++;
        }
      } else if (Puzzle23Variables.pointCounter == 2) {
        Vibration.vibrate(duration: 100);
        if (degrees(_orientation.z) > 40)
          Puzzle23Variables.point2 = 2;
        else if (degrees(_orientation.z) < -40) Puzzle23Variables.point2 = 0;
        if ((degrees(_orientation.z) > 40) || (degrees(_orientation.z) < -40)) {
          // dataPlotAlert(Puzzle23Variables.point2);
          Puzzle23Variables.pointCounter++;
        }
      } else if (Puzzle23Variables.pointCounter == 3) {
        Vibration.vibrate(duration: 100);
        if (degrees(_orientation.z) > 40)
          Puzzle23Variables.point3 = 2;
        else if (degrees(_orientation.z) < -40) Puzzle23Variables.point3 = 0;
        if ((degrees(_orientation.z) > 40) || (degrees(_orientation.z) < -40)) {
          // dataPlotAlert(Puzzle23Variables.point3);
          Puzzle23Variables.pointCounter++;
        }
      } else if (Puzzle23Variables.pointCounter == 4) {
        Vibration.vibrate(duration: 100);
        if (degrees(_orientation.z) > 40)
          Puzzle23Variables.point4 = 2;
        else if (degrees(_orientation.z) < -40) Puzzle23Variables.point4 = 0;
        if ((degrees(_orientation.z) > 40) || (degrees(_orientation.z) < -40)) {
          // dataPlotAlert(Puzzle23Variables.point4);
          Puzzle23Variables.pointCounter++;
        }
      } else if (Puzzle23Variables.pointCounter == 5) {
        Vibration.vibrate(duration: 100);
        if (degrees(_orientation.z) > 40)
          Puzzle23Variables.point5 = 2;
        else if (degrees(_orientation.z) < -40) Puzzle23Variables.point5 = 0;
        if ((degrees(_orientation.z) > 40) || (degrees(_orientation.z) < -40)) {
          // dataPlotAlert(Puzzle23Variables.point5);
          Puzzle23Variables.pointCounter++;
        }
      } else if (Puzzle23Variables.pointCounter == 6) {
        Vibration.vibrate(duration: 100);
        if (degrees(_orientation.z) > 40)
          Puzzle23Variables.point6 = 2;
        else if (degrees(_orientation.z) < -40) Puzzle23Variables.point6 = 0;
        if ((degrees(_orientation.z) > 40) || (degrees(_orientation.z) < -40)) {
          // dataPlotAlert(Puzzle23Variables.point6);
          Puzzle23Variables.pointCounter++;
        }
      }

      /*
  else if (Puzzle23Variables.pointCounter == 7) {
  if (degrees(_orientation.z) > 40)
  Puzzle23Variables.point7 = 1;
  else if (degrees(_orientation.z) < -40)
  Puzzle23Variables.point7 = 0;
  if ((degrees(_orientation.z) > 40) ||
  (degrees(_orientation.z) < -40)) {
  dataPlotAlert(Puzzle23Variables.point7);
  Puzzle23Variables.pointCounter++;
  }
  }
*/
      Puzzle23Variables.generateSignal = false;
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    usageUpdate();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Function generator'),
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        'AI to player:'
                            '\r\n-> If you are able to generate the right signal sequence in square wave then you might be able to turn the table'
                            ' around in our favor by sharing your phone\'s hardware resources.'
                            '\r\n-> Saving the world takes high precedence and if we work together, we might be able to pull through.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontFamily: 'VT323'),
                      ),
                    )
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: SfRadialGauge(
                            animationDuration: 3500,
                            enableLoadingAnimation: true,
                            axes: <RadialAxis>[
                              RadialAxis(
                                  startAngle: 130,
                                  endAngle: 50,
                                  minimum: 0,
                                  maximum: 100,
                                  interval: 20,
                                  minorTicksPerInterval: 9,
                                  showAxisLine: false,
                                  radiusFactor: 0.9,
                                  labelOffset: 0,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        endValue: 10,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            34, 144, 199, 0.75)),
                                    GaugeRange(
                                        startValue: 10,
                                        endValue: 20,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            34, 195, 199, 0.75)),
                                    GaugeRange(
                                        startValue: 20,
                                        endValue: 40,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            123, 199, 34, 0.75)),
                                    GaugeRange(
                                        startValue: 40,
                                        endValue: 70,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            238, 193, 34, 0.75)),
                                    GaugeRange(
                                        startValue: Puzzle23Variables.puzzleSolved
                                            ? 70
                                            : 0,
                                        endValue: 100,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            238, 79, 34, 0.65)),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 90,
                                        positionFactor: 0.75,
                                        widget: Container(
                                            child: const Text('CPU',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    decoration:
                                                    TextDecoration.underline,
                                                    color: Colors.red,
                                                    fontSize: 15)))),
                                    GaugeAnnotation(
                                        angle: 90,
                                        positionFactor: 1.05,
                                        widget: Container(
                                          child: Text(
                                            '${(Puzzle23Variables.cpuUsage).round()} %',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ))
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: Puzzle23Variables.cpuUsage,
                                      needleLength: 0.6,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      needleStartWidth: 1,
                                      needleEndWidth: 5,
                                      animationType: AnimationType.easeOutBack,
                                      enableAnimation: true,
                                      animationDuration: 1200,
                                      knobStyle: KnobStyle(
                                          knobRadius: 0.06,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          borderColor: const Color(0xFFF8B195),
                                          color: Colors.white,
                                          borderWidth: 0.035),
                                      tailStyle: TailStyle(
                                          color: const Color(0xFFF8B195),
                                          width: 4,
                                          lengthUnit: GaugeSizeUnit.factor,
                                          length: 0.15),
                                      needleColor: const Color(0xFFF8B195),
                                    )
                                  ],
                                  axisLabelStyle: GaugeTextStyle(fontSize: 10),
                                  majorTickStyle: MajorTickStyle(
                                      length: 0.25,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      thickness: 1.5),
                                  minorTickStyle: MinorTickStyle(
                                      length: 0.13,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      thickness: 1))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SfRadialGauge(
                            animationDuration: 3500,
                            enableLoadingAnimation: true,
                            axes: <RadialAxis>[
                              RadialAxis(
                                  startAngle: 130,
                                  endAngle: 50,
                                  minimum: 0,
                                  maximum: 100,
                                  interval: 20,
                                  minorTicksPerInterval: 9,
                                  showAxisLine: false,
                                  radiusFactor: 0.9,
                                  labelOffset: 0,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        endValue: 10,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            34, 144, 199, 0.75)),
                                    GaugeRange(
                                        startValue: 10,
                                        endValue: 20,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            34, 195, 199, 0.75)),
                                    GaugeRange(
                                        startValue: 20,
                                        endValue: 40,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            123, 199, 34, 0.75)),
                                    GaugeRange(
                                        startValue: 40,
                                        endValue: 70,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            238, 193, 34, 0.75)),
                                    GaugeRange(
                                        startValue: Puzzle23Variables.puzzleSolved
                                            ? 70
                                            : 0,
                                        endValue: 100,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            238, 79, 34, 0.65)),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 90,
                                        positionFactor: 0.75,
                                        widget: Container(
                                            child: const Text('GPU',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    decoration:
                                                    TextDecoration.underline,
                                                    color: Colors.red,
                                                    fontSize: 15)))),
                                    GaugeAnnotation(
                                        angle: 90,
                                        positionFactor: 1.05,
                                        widget: Container(
                                          child: Text(
                                            Puzzle23Variables.cpuUsage > 0
                                                ? '${(Puzzle23Variables.cpuUsage).round()} %'
                                                : '0 %',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ))
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: Puzzle23Variables.cpuUsage,
                                      // - 20,
                                      needleLength: 0.6,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      needleStartWidth: 1,
                                      needleEndWidth: 5,
                                      animationType: AnimationType.easeOutBack,
                                      enableAnimation: true,
                                      animationDuration: 1200,
                                      knobStyle: KnobStyle(
                                          knobRadius: 0.06,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          borderColor: const Color(0xFFF8B195),
                                          color: Colors.white,
                                          borderWidth: 0.035),
                                      tailStyle: TailStyle(
                                          color: const Color(0xFFF8B195),
                                          width: 4,
                                          lengthUnit: GaugeSizeUnit.factor,
                                          length: 0.15),
                                      needleColor: const Color(0xFFF8B195),
                                    )
                                  ],
                                  axisLabelStyle: GaugeTextStyle(fontSize: 10),
                                  majorTickStyle: MajorTickStyle(
                                      length: 0.25,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      thickness: 1.5),
                                  minorTickStyle: MinorTickStyle(
                                      length: 0.13,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      thickness: 1))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SfRadialGauge(
                            animationDuration: 3500,
                            enableLoadingAnimation: true,
                            axes: <RadialAxis>[
                              RadialAxis(
                                  startAngle: 130,
                                  endAngle: 50,
                                  minimum: 0,
                                  maximum: 100,
                                  interval: 20,
                                  minorTicksPerInterval: 9,
                                  showAxisLine: false,
                                  radiusFactor: 0.9,
                                  labelOffset: 0,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        endValue: 10,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            34, 144, 199, 0.75)),
                                    GaugeRange(
                                        startValue: 10,
                                        endValue: 20,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            34, 195, 199, 0.75)),
                                    GaugeRange(
                                        startValue: 20,
                                        endValue: 40,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            123, 199, 34, 0.75)),
                                    GaugeRange(
                                        startValue: 40,
                                        endValue: 70,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            238, 193, 34, 0.75)),
                                    GaugeRange(
                                        startValue: Puzzle23Variables.puzzleSolved
                                            ? 70
                                            : 0,
                                        endValue: 100,
                                        startWidth: 0.265,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        endWidth: 0.265,
                                        color: const Color.fromRGBO(
                                            238, 79, 34, 0.65)),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 90,
                                        positionFactor: 0.75,
                                        widget: Container(
                                            child: const Text('RAM',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    decoration:
                                                    TextDecoration.underline,
                                                    color: Colors.red,
                                                    fontSize: 15)))),
                                    GaugeAnnotation(
                                        angle: 90,
                                        positionFactor: 1.05,
                                        widget: Container(
                                          child: Text(
                                            Puzzle23Variables.cpuUsage > 0
                                                ? '${(Puzzle23Variables.cpuUsage).round()} %'
                                                : '0 %',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ))
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: Puzzle23Variables.cpuUsage,
                                      // - 10,
                                      needleLength: 0.6,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      needleStartWidth: 1,
                                      needleEndWidth: 5,
                                      animationType: AnimationType.easeOutBack,
                                      enableAnimation: true,
                                      animationDuration: 1200,
                                      knobStyle: KnobStyle(
                                          knobRadius: 0.06,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          borderColor: const Color(0xFFF8B195),
                                          color: Colors.white,
                                          borderWidth: 0.035),
                                      tailStyle: TailStyle(
                                          color: const Color(0xFFF8B195),
                                          width: 4,
                                          lengthUnit: GaugeSizeUnit.factor,
                                          length: 0.15),
                                      needleColor: const Color(0xFFF8B195),
                                    )
                                  ],
                                  axisLabelStyle: GaugeTextStyle(fontSize: 10),
                                  majorTickStyle: MajorTickStyle(
                                      length: 0.25,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      thickness: 1.5),
                                  minorTickStyle: MinorTickStyle(
                                      length: 0.13,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      thickness: 1))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text('\r\n Signal\r\n graph ->')),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: LineChart(
                          LineChartData(
                              backgroundColor: Colors.black,
                              minX: 0,
                              maxX: 6,
                              minY: 0,
                              maxY: 3,
                              lineBarsData: [
                                LineChartBarData(
                                  belowBarData: BarAreaData(
                                    show: true,
                                    // colors: red,
                                  ),
                                  spots: [
                                    FlSpot(0, Puzzle23Variables.point1),
                                    FlSpot(1, Puzzle23Variables.point1),
                                    FlSpot(1, Puzzle23Variables.point2), //1
                                    FlSpot(2, Puzzle23Variables.point2), //1
                                    FlSpot(2, Puzzle23Variables.point3),
                                    FlSpot(3, Puzzle23Variables.point3),
                                    FlSpot(3, Puzzle23Variables.point4), //1
                                    FlSpot(4, Puzzle23Variables.point4), //1
                                    FlSpot(4, Puzzle23Variables.point5),
                                    FlSpot(5, Puzzle23Variables.point5),
                                    FlSpot(5, Puzzle23Variables.point6), //1
                                    FlSpot(6, Puzzle23Variables.point6), //1
                                    /*
                                    FlSpot(6, Puzzle23Variables.point7),
                                    FlSpot(7, Puzzle23Variables.point7),

                                    FlSpot(7, Puzzle23Variables.point8),
                                    FlSpot(8, Puzzle23Variables.point8),
                                    */
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    /*
                    Text('Orientation'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('X: ${degrees(_orientation.x).toStringAsFixed(2)}'),
                        Text('Y: ${degrees(_orientation.y).toStringAsFixed(2)}'),
                        Text('Z: ${degrees(_orientation.z).toStringAsFixed(2)}'),
                      ],
                    ),
                    */
                    tiltToGenerateSignal(),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlatButton(
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                Puzzle23Variables.pointCounter = 1;
                                Puzzle23Variables.point1 = 1;
                                Puzzle23Variables.point2 = 1;
                                Puzzle23Variables.point3 = 1;
                                Puzzle23Variables.point4 = 1;
                                Puzzle23Variables.point5 = 1;
                                Puzzle23Variables.point6 = 1;
                                Puzzle23Variables.point7 = 1;
                                Puzzle23Variables.point8 = 1;
                              });
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'Send',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {

                                if (((Puzzle23Variables.point1 == 2) &&
                                    (Puzzle23Variables.point2 == 0) &&
                                    (Puzzle23Variables.point3 == 2) &&
                                    (Puzzle23Variables.point4 == 0) &&
                                    (Puzzle23Variables.point5 == 2) &&
                                    (Puzzle23Variables.point6 == 0)) ||
                                    ((Puzzle23Variables.point1 == 0) &&
                                        (Puzzle23Variables.point2 == 2) &&
                                        (Puzzle23Variables.point3 == 0) &&
                                        (Puzzle23Variables.point4 == 2) &&
                                        (Puzzle23Variables.point5 == 0) &&
                                        (Puzzle23Variables.point6 == 2))) {
                                  //puzzle solved
                                  Puzzle2Variables.puzzle2_3Staus = 'green';
                                  Puzzle2Variables.subPuzzle = 4;
                                  Puzzle23Variables.stopTimer = true;
                                  Puzzle23Variables.puzzleSolved = true;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Puzzle solved.'
                                              '\r\nLook at the gauges!',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Wrong wave generated!',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  );
                                }
                              });
                            },
                          ),

                        ],
                      ),


                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RaisedButton.icon(
                                padding: EdgeInsets.all(10),
                                onPressed: () {
                                  if (Puzzle2Variables.subPuzzle == 3){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Solve the puzzle to proceed.',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                    );
                                  }

                                  else if (Puzzle2Variables.subPuzzle == 4){
                                    Puzzle2MainScreenState.getInstance().setStateCallback();
                                    Navigator.of(context).pop();
                                  }
                                },
                                icon: Icon(
                                  Icons.next_plan_outlined,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                label: Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0),
                                ),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Puzzle23Variables {
  static double cpuUsage = 5.0;
  static bool stopTimer = false;
  static double timeCounter = 0;
  static double point1 = 1; //1
  static double point2 = 1; //0
  static double point3 = 1; //1
  static double point4 = 1; //0
  static double point5 = 1; //1
  static double point6 = 1; //0
  static double point7 = 1; //1
  static double point8 = 1; //1
  static int pointCounter = 1;
  static bool puzzleSolved = false;
  static bool phoneTilt = false;
  static bool generateSignal = true;
}
