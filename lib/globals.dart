library globals;

import 'package:ubilab_scavenger_hunt/mqtt/MqttManager.dart';

/// MQTT
MQTTManager globalMqttManager = MQTTManager("wss://earth.informatik.uni-freiburg.de/ubilab/ws/");
double globalMaxTime = 2;

/// Debugging & Testing
final bool globalIsTesting = true;
