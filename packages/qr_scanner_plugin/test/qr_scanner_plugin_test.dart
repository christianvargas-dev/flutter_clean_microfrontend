import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scanner_plugin/qr_scanner_plugin.dart';
import 'package:qr_scanner_plugin/qr_scanner_plugin_platform_interface.dart';
import 'package:qr_scanner_plugin/qr_scanner_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQrScannerPluginPlatform
    with MockPlatformInterfaceMixin
    implements QrScannerPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final QrScannerPluginPlatform initialPlatform = QrScannerPluginPlatform.instance;

  test('$MethodChannelQrScannerPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQrScannerPlugin>());
  });

  test('getPlatformVersion', () async {
    QrScannerPlugin qrScannerPlugin = QrScannerPlugin();
    MockQrScannerPluginPlatform fakePlatform = MockQrScannerPluginPlatform();
    QrScannerPluginPlatform.instance = fakePlatform;

    expect(await qrScannerPlugin.getPlatformVersion(), '42');
  });
}
