import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mcumgr/flutter_mcumgr.dart';
import 'package:flutter_mcumgr/flutter_mcumgr_platform_interface.dart';
import 'package:flutter_mcumgr/flutter_mcumgr_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMcumgrPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterMcumgrPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterMcumgrPlatform initialPlatform = FlutterMcumgrPlatform.instance;

  test('$MethodChannelFlutterMcumgr is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMcumgr>());
  });

  test('getPlatformVersion', () async {
    FlutterMcumgr flutterMcumgrPlugin = FlutterMcumgr();
    MockFlutterMcumgrPlatform fakePlatform = MockFlutterMcumgrPlatform();
    FlutterMcumgrPlatform.instance = fakePlatform;
  
    expect(await flutterMcumgrPlugin.getPlatformVersion(), '42');
  });
}
