import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wiflutter_platform_interface.dart';

/// An implementation of [WiFlutterPlatform] that uses method channels.
class MethodChannelWiFlutter extends WiFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wiflutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> connect({
    String? ssid,
    String? bssid,
    String? password,
    bool joinOnce = true,
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) async {
    final version = await methodChannel.invokeMethod<bool>('connect');
    return version;
  }

  @override
  Future<bool?> disconnect() async {
    final version = await methodChannel.invokeMethod<bool>('disconnect');
    return version;
  }
}
