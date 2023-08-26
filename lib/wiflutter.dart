import 'enums/enterprise_certificate_enum.dart';
import 'wiflutter_platform_interface.dart';

class WiFlutter {
  Future<bool?> connect({
    required String ssid,
    String? bssid,
    String? password,
    EnterpriseCertificateEnum enterpriseCertificate =
        EnterpriseCertificateEnum.WPA2_PSK,
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) =>
      WiFlutterPlatform.instance.connect(
        ssid: ssid,
        bssid: bssid,
        password: password,
        enterpriseCertificate: enterpriseCertificate,
        withInternet: withInternet,
        timeoutInSeconds: timeoutInSeconds,
      );

  Future<bool?> disconnect() => WiFlutterPlatform.instance.disconnect();

  Future<String?> getCurrentSSID() =>
      WiFlutterPlatform.instance.getCurrentSSID();

  Future<String?> getIP() => WiFlutterPlatform.instance.getIP();

  Future<bool?> isWifiEnabled() => WiFlutterPlatform.instance.isWifiEnabled();

  Future<bool?> setWifiEnabled(bool enable) =>
      WiFlutterPlatform.instance.setWifiEnabled(enable);
}
