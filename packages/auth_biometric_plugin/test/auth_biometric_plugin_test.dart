import 'package:flutter_test/flutter_test.dart';
import 'package:auth_biometric_plugin/auth_biometric_plugin.dart';
import 'package:auth_biometric_plugin/auth_biometric_plugin_platform_interface.dart';
import 'package:auth_biometric_plugin/auth_biometric_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAuthBiometricPluginPlatform
    with MockPlatformInterfaceMixin
    implements AuthBiometricPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AuthBiometricPluginPlatform initialPlatform = AuthBiometricPluginPlatform.instance;

  test('$MethodChannelAuthBiometricPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAuthBiometricPlugin>());
  });

  test('getPlatformVersion', () async {
    AuthBiometricPlugin authBiometricPlugin = AuthBiometricPlugin();
    MockAuthBiometricPluginPlatform fakePlatform = MockAuthBiometricPluginPlatform();
    AuthBiometricPluginPlatform.instance = fakePlatform;

    expect(await authBiometricPlugin.getPlatformVersion(), '42');
  });
}
