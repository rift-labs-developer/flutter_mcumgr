
import 'flutter_mcumgr_platform_interface.dart';

class FlutterMcumgr {
  Future<String?> getPlatformVersion() {
    return FlutterMcumgrPlatform.instance.getPlatformVersion();
  }
}
