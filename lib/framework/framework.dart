import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';
import 'game.dart';
import 'storyWidget.dart';
import 'gameMenuScreen.dart';
import 'hintScreen.dart';

// Coordinates of Technical Faculty
// 48.012684, 7.835044

const String stringAppName = "Ubilab Scavenger Hunt";

class GameMainScreen extends StatefulWidget {
  @override
  _GameMainScreen createState() => _GameMainScreen();
}

class _GameMainScreen extends State<GameMainScreen> {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];
  Game game = Game.getInstance();

  @override
  Widget build(BuildContext context) {
    game.setContext(context);
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      onLocationUpdate: game.onLocationChanged,
      updateMapLocationOnPositionChange: false,
      zoomToCurrentLocationOnLoad: false,
      defaultZoom: 16,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(stringAppName),
          automaticallyImplyLeading: false,
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: FlutterMap(
          options: MapOptions(
            // Coordinates of Technical Faculty
            center: LatLng(48.012684, 7.835044),
            zoom: 16.0,
            plugins: [
              UserLocationPlugin(),
            ],
          ),
          mapController: mapController,
          layers: [
            MarkerLayerOptions(markers: markers),
            userLocationOptions,
          ],
          children: <Widget>[
            TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                )),
            Column(
              children: [
                GameProgressbar(),
                _testPuzzleButtonRow(),
                StoryWidget(key: game.storyIntroWidgetyKey),
                StoryWidget(key: game.storyOutroWidgetyKey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Functions for development & testing

  /// Creates a row of test buttons to trigger reaching the location for a puzzle.
  Widget _testPuzzleButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _testPuzzleButton("Puzzle", game.testOnPuzzleLocation),
      ],
    );
  }

  /// Creates a test button to trigger reaching the location for a puzzle.
  Widget _testPuzzleButton(String buttonText, Function onButtonPressed) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        margin: const EdgeInsets.all(1.0),
        child: OutlinedButton(
          child: Text(buttonText),
          onPressed: onButtonPressed,
        ),
      ),
    );
  }
}

///added by Sabari KM-----------------------------///
class GameProgressbar extends StatefulWidget {
  @override
  GameProgressbarState createState() => GameProgressbarState();
}

class GameProgressbarState extends State<GameProgressbar> {
  static GameProgressbarState _instance;

  GameProgressbarState() {
    _instance = this;
  }

  /// Static singleton method.
  static GameProgressbarState getInstance() {
    if (_instance == null) {
      _instance = GameProgressbarState();
    }
    return _instance;
  }

  void setStateCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        value: MainVariables.progressValue,
        minHeight: 20,
        backgroundColor: Colors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }
}

class MainVariables {
  static double progressValue = 0.1; //accepted values 0 to 1
}

///----------------------------------------------------///