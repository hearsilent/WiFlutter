import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wiflutter_method_channel.dart';

abstract class WiflutterPlatform extends PlatformInterface {
  /// Constructs a WiflutterPlatform.
  WiflutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WiflutterPlatform _instance = MethodChannelWiflutter();

  /// The default instance of [WiflutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWiflutter].
  static WiflutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WiflutterPlatform] when
  /// they register themselves.
  static set instance(WiflutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
