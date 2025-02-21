import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getPlatformVersion test', (WidgetTester tester) async {
    // Initialize the plugin
    final FlutterAccelerometerPlugin plugin = FlutterAccelerometerPlugin();
    
    // Fetch platform version
    try {
      final String? version = await plugin.getPlatformVersion();

      // Ensure the returned version is a valid string
      expect(version != null && version.isNotEmpty, true);
    } catch (e) {
      fail('Error fetching platform version: $e');
    }
  });
}
