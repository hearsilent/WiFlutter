import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enums/enterprise_certificate_enum.dart';
import 'wiflutter_method_channel.dart';

abstract class WiFlutterPlatform extends PlatformInterface {
  /// Constructs a WiFlutterPlatform.
  WiFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WiFlutterPlatform _instance = MethodChannelWiFlutter();

  /// The default instance of [WiFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWiFlutter].
  static WiFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WiFlutterPlatform] when
  /// they register themselves.
  static set instance(WiFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> connect({
    required String ssid,
    required EnterpriseCertificateEnum enterpriseCertificate,
    String? bssid,
    String? password,
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) async {
    throw UnimplementedError('connect() has not been implemented.');
  }

  Future<bool?> disconnect() async {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  Future<String?> getCurrentSSID() async {
    throw UnimplementedError('getCurrentSSID() has not been implemented.');
  }

  Future<String?> getIP() async {
    throw UnimplementedError('getIP() has not been implemented.');
  }

  Future<bool?> isWifiEnabled() async {
    throw UnimplementedError('isWifiEnabled() has not been implemented.');
  }

  Future<bool?> setWifiEnabled(bool enable) async {
    throw UnimplementedError('setWifiEnabled() has not been implemented.');
  }
}
