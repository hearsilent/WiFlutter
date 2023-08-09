import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wiflutter_platform_interface.dart';

/// An implementation of [WiflutterPlatform] that uses method channels.
class MethodChannelWiflutter extends WiflutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wiflutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
