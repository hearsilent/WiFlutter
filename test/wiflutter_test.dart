import 'package:flutter_test/flutter_test.dart';
<<<<<<< HEAD
=======
import 'package:wiflutter/wiflutter.dart';
>>>>>>> 1d0974c (Create flutter plugin project)
import 'package:wiflutter/wiflutter_platform_interface.dart';
import 'package:wiflutter/wiflutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

<<<<<<< HEAD
class MockWiFlutterPlatform
    with MockPlatformInterfaceMixin
    implements WiFlutterPlatform {
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
=======
class MockWiflutterPlatform
    with MockPlatformInterfaceMixin
    implements WiflutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WiflutterPlatform initialPlatform = WiflutterPlatform.instance;

  test('$MethodChannelWiflutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWiflutter>());
  });

  test('getPlatformVersion', () async {
    Wiflutter wiflutterPlugin = Wiflutter();
    MockWiflutterPlatform fakePlatform = MockWiflutterPlatform();
    WiflutterPlatform.instance = fakePlatform;

    expect(await wiflutterPlugin.getPlatformVersion(), '42');
>>>>>>> 1d0974c (Create flutter plugin project)
  });
}
