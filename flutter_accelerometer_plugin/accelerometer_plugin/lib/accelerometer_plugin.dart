
import 'accelerometer_plugin_platform_interface.dart';

class AccelerometerPlugin {
  Future<String?> getPlatformVersion() {
    return AccelerometerPluginPlatform.instance.getPlatformVersion();
  }
}
