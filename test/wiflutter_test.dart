import 'package:flutter_test/flutter_test.dart';
import 'package:wiflutter/wiflutter.dart';
import 'package:wiflutter/wiflutter_platform_interface.dart';
import 'package:wiflutter/wiflutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWiFlutterPlatform
    with MockPlatformInterfaceMixin
    implements WiFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> connect({
    String? ssid,
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
    // TODO: implement isWifiEnabled
    throw UnimplementedError();
  }

  @override
  Future<bool?> setWifiEnabled(bool enable) {
    // TODO: implement setWifiEnabled
    throw UnimplementedError();
  }
}

void main() {
  final WiFlutterPlatform initialPlatform = WiFlutterPlatform.instance;

  test('$MethodChannelWiFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWiFlutter>());
  });
}
