<<<<<<< HEAD
import 'package:flutter_test/flutter_test.dart';
=======
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiflutter/wiflutter_method_channel.dart';
>>>>>>> 1d0974c (Create flutter plugin project)

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

<<<<<<< HEAD
  setUp(() {});

  tearDown(() {});
=======
  MethodChannelWiflutter platform = MethodChannelWiflutter();
  const MethodChannel channel = MethodChannel('wiflutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
>>>>>>> 1d0974c (Create flutter plugin project)
}
