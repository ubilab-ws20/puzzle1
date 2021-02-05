import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ubilab_scavenger_hunt/globals.dart';
import 'dart:convert';
import 'dart:async';

import 'package:uuid/uuid.dart';

class MQTTManager {
  MqttServerClient client;
  final String _host;
  final String topicName = "testID/testtopic";
  var teamDetails = [];
  String _uuid = "";
  Uuid uuid = Uuid();

  MQTTManager({@required String host}) : _host = host;

  void initialiseMQTTClient() {
    _uuid = uuid.v1();
    client = MqttServerClient(_host, _uuid);

    client.useWebSocket = true;
    client.port = 443;
    //client.secure = true;
    client.logging(on: false);
    client.keepAlivePeriod = 5;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = true;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
  }

  void connect() async {
    assert(client != null);
    try {
      print('EXAMPLE::start client connecting....');
      //_currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await client.connect('ubilab', 'ubilab');
      print("connected");
      mqttConnected = true;
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print(
          'Received message in Framework:$payload from topic: ${c[0].topic}>');
    });
  }

  void disconnect() {
    publishString(topicName, "$globalTeamName Disconnecting from $_host");
    print('Disconnected from $_host');
    clear(teamDetails);
    client.disconnect();
    mqttConnected = false;
  }

  void onConnected() {
    print('EXAMPLE::Mosquitto client connected....');
    _subscribeToTopic(topicName);
  }

  void _subscribeToTopic(String topicName) {
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    publishList(topicName, teamDetails);

    //client.subscribe(topicName, MqttQos.atMostOnce);
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

  void publishList(String topic, var teamDetails) {
    final builder = MqttClientPayloadBuilder();
    if ((teamDetails != null) || (teamDetails.length > 0)) {
      for (int i = 0; i < teamDetails.length - 1; i++) {
        builder.addString(teamDetails[i]);
        builder.addString(",");
      }
      builder.addString(teamDetails[teamDetails.length - 1]);
    } else {
      builder.addString('');
    }
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishString(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  void updateDetail(List<dynamic> listTeamDetails) {
    print("Function updateDetail called");
    for (int i = 0; i < listTeamDetails.length - 1; i++) {
      teamDetails = listTeamDetails;
    }
    publishList(topicName, teamDetails);
    clear(teamDetails);
  }

  void clear(var teamDetails) {
    teamDetails.clear();
  }
}
