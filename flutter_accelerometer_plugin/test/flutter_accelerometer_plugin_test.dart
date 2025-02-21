import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin.dart';
import 'package:flutter/services.dart';

void main() {
  const MethodChannel methodChannel = MethodChannel('accelerometer_plugin');
  const EventChannel eventChannel = EventChannel('accelerometer_events');

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    methodChannel.setMockMethodCallHandler(null);
  });

  test('startListening', () async {
    methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'startListening') {
        return null;
      }
      return null;
    });

    await FlutterAccelerometerPlugin.startListening();
  });

  test('stopListening', () async {
    methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'stopListening') {
        return null;
      }
      return null;
    });

    await FlutterAccelerometerPlugin.stopListening();
  });

  test('sensorDataStream', () async {
    const mockData = {'x': 1.0, 'y': 2.0, 'z': 3.0};
    methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'startListening') {
        return null;
      }
      return null;
    });

    final stream = FlutterAccelerometerPlugin.sensorDataStream;
    expect(stream, isA<Stream<Map<String, double>>>());

    // Simulate data being sent through the event channel
    ServicesBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
      eventChannel.name,
      const StandardMethodCodec().encodeSuccessEnvelope(mockData),
      (ByteData? data) {},
    );

    expect(await stream.first, mockData);
  });
}