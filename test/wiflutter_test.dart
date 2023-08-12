import 'package:flutter_test/flutter_test.dart';
import 'package:wiflutter/enums/enterprise_certificate_enum.dart';
import 'package:wiflutter/wiflutter_platform_interface.dart';
import 'package:wiflutter/wiflutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWiFlutterPlatform
    with MockPlatformInterfaceMixin
    implements WiFlutterPlatform {
  @override
  Future<bool?> connect({
    required String ssid,
    required EnterpriseCertificateEnum security,
    String? bssid,
    String? password,
    bool joinOnce = true,
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> disconnect() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getCurrentSSID() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getIP() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isWifiEnabled() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> setWifiEnabled(bool enable) {
    throw UnimplementedError();
  }
}

void main() {
  final WiFlutterPlatform initialPlatform = WiFlutterPlatform.instance;

  test('$MethodChannelWiFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWiFlutter>());
  });
}
