library globals;

import 'package:ubilab_scavenger_hunt/mqtt/MqttManager.dart';
import 'package:latlng/latlng.dart';

/// MQTT
final String stringHostName =
    "wss://earth.informatik.uni-freiburg.de/ubilab/ws/";
LatLng currentLocation = LatLng(48.013217, 7.833264);
MQTTManager globalMqttManager = MQTTManager(stringHostName);


/// Debugging & Testing
final bool globalIsTesting = true;
