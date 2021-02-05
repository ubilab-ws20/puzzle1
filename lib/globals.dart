library globals;

import 'dart:async';

import 'package:ubilab_scavenger_hunt/mqtt/MqttManager.dart';

/// MQTT
final String stringHostName =
    "wss://earth.informatik.uni-freiburg.de/ubilab/ws/";
MQTTManager manager = MQTTManager(host: stringHostName);
String globalTeamName = "";
Timer globalTimer;
bool mqttConnected = false;

/// Debugging & Testing
final bool globalIsTesting = true;
