import 'package:flutter_test/flutter_test.dart';
import 'package:wiflutter/wiflutter.dart';
import 'package:wiflutter/wiflutter_platform_interface.dart';
import 'package:wiflutter/wiflutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
  });
}
