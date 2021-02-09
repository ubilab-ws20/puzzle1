library globals;

import 'dart:async';
import 'package:ubilab_scavenger_hunt/mqtt/MqttManager.dart';
import 'package:latlng/latlng.dart';

/// MQTT
final String stringHostName =
    "wss://earth.informatik.uni-freiburg.de/ubilab/ws/";
MQTTManager manager = MQTTManager(host: stringHostName);
String globalTeamName = "";
Timer globalTimer;
bool mqttConnected = false;
LatLng currentLocation = LatLng(48.013217, 7.833264);

/// Debugging & Testing
final bool globalIsTesting = true;
