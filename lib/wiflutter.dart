
import 'wiflutter_platform_interface.dart';

class Wiflutter {
  Future<String?> getPlatformVersion() {
    return WiflutterPlatform.instance.getPlatformVersion();
  }
}
