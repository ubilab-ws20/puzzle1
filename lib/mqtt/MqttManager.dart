import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ubilab_scavenger_hunt/globals.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class MQTTManager {
  MqttServerClient _client;
  final String host;
  final String _topicName = "testID/scavenger_hunt";
  var _teamDetails = [];
  String _uuid = "";
  Uuid uuid = Uuid();

  MQTTManager({@required this.host});

  void initialiseMQTTClient() {
    _uuid = uuid.v1();
    _client = MqttServerClient(host, _uuid);
    _client.useWebSocket = true;
    _client.port = 443;
    _client.logging(on: false);
    _client.keepAlivePeriod = 5;
    _client.autoReconnect = true;
    _client.resubscribeOnAutoReconnect = true;
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.onDisconnected = onDisconnected;
    _client.onAutoReconnected = onAutoReconnected;
  }

  void connect() async {
    assert(_client != null);
    try {
      print('MQTTManager::connect()');
      print("Start client connecting....");
      await _client.connect('ubilab', 'ubilab');
      mqttConnected = true;
    } on Exception catch (e) {
      print('MQTTManager::client exception - $e');
      disconnect();
    }
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      print(
          'MQTTManager:: Received message in Framework:$payload from topic: ${c[0].topic}>');
    });
  }

  void disconnect() {
    publishString(_topicName, "$globalTeamName: disconnecting from $host");
    _client.disconnect();
    mqttConnected = false;
  }

  void onConnected() {
    print('MQTTManager::onConnected() Mosquitto client connected....');
  }

  void onDisconnected() {
    print('MQTTManager::onDisconnected() Disconnected from $host');
    _teamDetails.clear();
  }

  void onAutoReconnected() {
    print("MQTTManager::onAutoReconnected");
    connect();
  }

  void _subscribeToTopic(String _topicName) {
    print(
        'MQTTManager::_subscribeToTopic() Subscribing to the $_topicName topic');
    _client.subscribe(_topicName, MqttQos.atMostOnce);
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('MQTTManager::onSubscribed() Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('MQTTManager::onSubscribeFail() Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('MQTTManager::onUnsubscribed() Unsubscribed topic: $topic');
  }

  void publishList(String topic, var _teamDetails) {
    final builder = MqttClientPayloadBuilder();
    if ((_teamDetails != null) || (_teamDetails.length > 0)) {
      for (int i = 0; i < _teamDetails.length - 1; i++) {
        builder.addString(_teamDetails[i]);
        builder.addString(",");
      }
      builder.addString(_teamDetails[_teamDetails.length - 1]);
    } else {
      builder.addString('');
    }
    _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  void publishString(String topic, String message) {
    print("MQTTManager::Publishing: $message");
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  void updateDetail(Map listTeamDetails) {
    if (mqttConnected) {
      print("MQTTManager::updateDetail()");
      var _jsonList = json.encode(listTeamDetails);
      print(_jsonList);
      publishString(_topicName, _jsonList);
    }
    return;
  }
}
