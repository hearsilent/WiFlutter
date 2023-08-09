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
}

void main() {
  final WiFlutterPlatform initialPlatform = WiFlutterPlatform.instance;

  test('$MethodChannelWiFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWiFlutter>());
  });

  test('getPlatformVersion', () async {
    WiFlutter wiflutterPlugin = WiFlutter();
    MockWiFlutterPlatform fakePlatform = MockWiFlutterPlatform();
    WiFlutterPlatform.instance = fakePlatform;

    expect(await wiflutterPlugin.getPlatformVersion(), '42');
  });
}
