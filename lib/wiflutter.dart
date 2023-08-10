import 'wiflutter_platform_interface.dart';

class WiFlutter {
  Future<String?> getPlatformVersion() {
    return WiFlutterPlatform.instance.getPlatformVersion();
  }

  Future<bool?> connect({
    required String ssid,
    String? bssid,
    String? password,
    bool joinOnce = true,
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) async {
    return WiFlutterPlatform.instance.connect(
      ssid: ssid,
      bssid: bssid,
      password: password,
      joinOnce: joinOnce,
      withInternet: withInternet,
      timeoutInSeconds: timeoutInSeconds,
    );
  }

  Future<bool?> disconnect() async {
    return WiFlutterPlatform.instance.disconnect();
  }
}
