import 'wiflutter_platform_interface.dart';

class WiFlutter {
  Future<String?> getPlatformVersion() {
    return WiFlutterPlatform.instance.getPlatformVersion();
  }
}
