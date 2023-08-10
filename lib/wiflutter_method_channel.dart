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
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) async =>
      await methodChannel.invokeMethod<bool>('connect', {
        'ssid': ssid,
        "password": password,
        "withInternet": withInternet,
        "timeoutInSeconds": timeoutInSeconds
      });

  @override
  Future<bool?> disconnect() async =>
      await methodChannel.invokeMethod<bool>('disconnect');

  @override
  Future<String?> getCurrentSSID() async =>
      await methodChannel.invokeMethod<String>('get_current_ssid');

  @override
  Future<String?> getIP() async =>
      await methodChannel.invokeMethod<String>('get_ip');

  @override
  Future<bool?> isWifiEnabled() async =>
      await methodChannel.invokeMethod<bool>('is_wif_enabled');

  @override
  Future<bool?> setWifiEnabled(bool enable) async =>
      await methodChannel.invokeMethod<bool>('set_wifi_enabled');
}
