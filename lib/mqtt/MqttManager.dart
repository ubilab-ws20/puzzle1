import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManager {
  MqttServerClient client;
  final String _host;
  final String topicName = "testID/testtopic";
  List<String> teamDetails = [];

  MQTTManager({@required String host}) : _host = host;

  void initialiseMQTTClient() {
    client = MqttServerClient(_host, 'android_123');

    //client.clientIdentifier = 'TestID';
    client.useWebSocket = true;
    client.port = 443;
    //client.secure = true;
    client.logging(on: false);
    client.keepAlivePeriod = 5;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = true;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;

    //final connMessage = MqttConnectMessage().authenticateAs('ubilab', 'ubilab');

    //client.connectionMessage = connMessage;
  }

  void connect() async {
    assert(client != null);
    try {
      print('EXAMPLE::start client connecting....');
      //_currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await client.connect('ubilab', 'ubilab');
      print("connected");
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
    print('Disconnected');
    client.disconnect();
  }

  void onConnected() {
    print('EXAMPLE::Mosquitto client connected....');
    _subscribeToTopic(topicName);
  }

  void _subscribeToTopic(String topicName) {
    //print('MQTTClientWrapper::Subscribing to the $topicName topic');

    //client.subscribe(topicName, MqttQos.atMostOnce);
    publish(topicName);
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

  void publish(String topic) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(teamDetails[0]);
    builder.addString(",");
    builder.addString(teamDetails[1]);

    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  void setTeamDetails(String teamName, String teamSize) {
    teamDetails.add(teamName);
    teamDetails.add(teamSize);
  }
}
