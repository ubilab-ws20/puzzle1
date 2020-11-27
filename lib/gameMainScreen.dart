import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';

// Coordinates of Technical Faculty
// 48.012684, 7.835044

class GameMap extends StatefulWidget {
  @override
  _GameMapState createState() => _GameMapState();
}

class _GameMapState extends State<GameMap> {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    // You can use the userLocationOptions object to change the properties
    // of UserLocationOptions in runtime
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      updateMapLocationOnPositionChange: false,
      zoomToCurrentLocationOnLoad: true,
      defaultZoom: 16,
    );
    return Scaffold(
        appBar: AppBar(title: Text("Game Map")),
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
            TileLayerWidget(options: TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
            )),
          ],
        )
    );
  }
}
