import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiflutter/wiflutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWiFlutter platform = MethodChannelWiFlutter();
  const MethodChannel channel = MethodChannel('wiflutter');

  setUp(() {});

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
