library globals;

import 'package:ubilab_scavenger_hunt/mqtt/MqttManager.dart';

const String stringHostName =
    "wss://earth.informatik.uni-freiburg.de/ubilab/ws/";

MQTTManager manager = MQTTManager(host: stringHostName);
String globalTeamName = "";
