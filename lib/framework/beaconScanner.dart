import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'dart:math';

/// Convenience class for Bluetooth beacon information.
class Beacon {
  String name;
  List<int> mac;
  double distance = -1;

  Beacon(this.name, this.mac);

  bool isMacInData(List<int> data) {
    if (data.length < 6) {
      return false;
    }
    for (int i = 1; i <= 6; i++) {
      if (data[data.length - i] != mac[mac.length - i]) {
        return false;
      }
    }
    return true;
  }
}

/// Class for handling scanning for Bluetooth beacons.
class BeaconScanner {
  static BeaconScanner _instance;

  FlutterBlue _flutterBlue;
  Timer _beaconHandleTimer;
  final List<Beacon> _beacons = [
    Beacon("p1_1_46", [0xC9, 0x96, 0xD9, 0xA0, 0xEC, 0xB2]),
    Beacon("p1_2_2", [0xDB, 0xCD, 0xDF, 0x5A, 0xE1, 0xC7]),
    Beacon("p1_3_30", [0xE8, 0x63, 0x97, 0xD4, 0xEB, 0x3B]),
    Beacon("p1_4_89", [0xD9, 0xF5, 0xB7, 0xB1, 0x57, 0x64]),
    Beacon("p1_5_51", [0xCB, 0x69, 0x61, 0x67, 0xA9, 0xB9]),
    Beacon("p1_6_73", [0xEB, 0x65, 0x46, 0x4A, 0x5E, 0x21]),
  ];
  double _maxBeaconDist = 0;
  Function _closestBeaconCallback;

  BeaconScanner() {
    _instance = this;
  }

  /// Static singleton method.
  static BeaconScanner getInstance() {
    if (_instance == null) {
      _instance = BeaconScanner();
    }
    return _instance;
  }

  /// Starts the beacon scanner. The function closestBeaconCallback is called
  /// with the name of a beacon as an argument. It is called beacons are encountered
  /// not more far away than maxBeaconDist. It is only called for the closest beacon.
  void start(Function closestBeaconCallback, double maxBeaconDist) {
    _maxBeaconDist = maxBeaconDist;
    _closestBeaconCallback = closestBeaconCallback;
    _flutterBlue = FlutterBlue.instance;
    _flutterBlue.scanResults.listen((results) {
      _onDevicesDiscovered(results);
    });
    _beaconHandleTimer = new Timer.periodic(new Duration(seconds: 5), (timer) {
      _handleBeacons();
    });
  }

  /// Stops the beacon scanner.
  void stop() {
    _beaconHandleTimer.cancel();
    _flutterBlue.stopScan();
    _flutterBlue = null;
    _maxBeaconDist = 0;
    _closestBeaconCallback = null;
  }

  /// Handler callback for the timer.
  void _handleBeacons() {
    _findClosestBeacon();
    for (Beacon beacon in _beacons) {
      beacon.distance = -1;
    }
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  /// Callback for discovered Bluetooth devices.
  void _onDevicesDiscovered(List<ScanResult> results) {
    int rssi = 0;
    List<int> data;
    for (ScanResult result in results) {
      if (!result.advertisementData.manufacturerData.containsKey(1177)) {
        continue;
      }
      data = result.advertisementData.manufacturerData[1177];
      rssi = result.rssi;
      for (Beacon beacon in _beacons) {
        if (beacon.isMacInData(data)) {
          // Formula for distance based on rssi
          beacon.distance = pow(10, ((-69 - rssi) / (10 * 4)));
          break;
        }
      }
    }
  }

  /// Handler for finding the closest beacon & calling the user callback.
  void _findClosestBeacon() {
    double closestDist = 100;
    Beacon closestBeacon;
    for (Beacon beacon in _beacons) {
      if (beacon.distance == -1) {
        continue;
      }
      if (beacon.distance < closestDist) {
        closestDist = beacon.distance;
        closestBeacon = beacon;
      }
    }
    if ((closestBeacon != null) && (closestBeacon.distance <= _maxBeaconDist)) {
      print("Beacon ${closestBeacon.name} is closest!");
      if (_closestBeaconCallback != null) {
        _closestBeaconCallback(closestBeacon.name);
      }
    } else {
      if (closestBeacon == null) {
        print("No beacon found!");
      } else {
        print("No beacon in range found!");
      }
    }
  }
}
