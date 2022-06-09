import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_mcumgr_method_channel.dart';

abstract class FlutterMcumgrPlatform extends PlatformInterface {
  /// Constructs a FlutterMcumgrPlatform.
  FlutterMcumgrPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMcumgrPlatform _instance = MethodChannelFlutterMcumgr();

  /// The default instance of [FlutterMcumgrPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMcumgr].
  static FlutterMcumgrPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMcumgrPlatform] when
  /// they register themselves.
  static set instance(FlutterMcumgrPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
