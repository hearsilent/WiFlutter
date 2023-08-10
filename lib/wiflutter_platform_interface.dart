import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> connect({
    required String ssid,
    String? bssid,
    String? password,
    bool joinOnce = true,
    bool withInternet = false,
    int timeoutInSeconds = 30,
  }) async {
    throw UnimplementedError('connect() has not been implemented.');
  }

  Future<bool?> disconnect() async {
    throw UnimplementedError('disconnect() has not been implemented.');
  }
}
