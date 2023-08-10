import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wiflutter_platform_interface.dart';

/// An implementation of [WiFlutterPlatform] that uses method channels.
class MethodChannelWiFlutter extends WiFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wiflutter');

  @override
  Future<bool?> connect({
    required String ssid,
    String? bssid,
    String? password,
    bool joinOnce = true,
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) async {
    return await methodChannel.invokeMethod<bool>('connect', {
      'ssid': ssid,
      "password": password,
      "joinOnce": joinOnce,
      "withInternet": withInternet,
      "timeoutInSeconds": timeoutInSeconds
    });
  }

  @override
  Future<bool?> disconnect() async {
    return await methodChannel.invokeMethod<bool>('disconnect');
  }
}
