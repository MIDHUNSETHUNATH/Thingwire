// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'package:flutter/services.dart';

class FlutterAccelerometerPlugin {
  static const MethodChannel _channel = MethodChannel('FlutterAccelerometerPlugin');

  static Future<void> startListening() async {
    await _channel.invokeMethod('startListening');
  }

  static Future<void> stopListening() async {
    await _channel.invokeMethod('stopListening');
  }

  static Stream<Map<String, double>> get sensorDataStream {
    return _eventChannel.receiveBroadcastStream().map((data) {
      return Map<String, double>.from(data);
    });
  }

  static const EventChannel _eventChannel = EventChannel('FlutterAccelerometerPlugin');

  getPlatformVersion() {}
}