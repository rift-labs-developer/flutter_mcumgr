import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_mcumgr_platform_interface.dart';

/// An implementation of [FlutterMcumgrPlatform] that uses method channels.
class MethodChannelFlutterMcumgr extends FlutterMcumgrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_mcumgr');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
