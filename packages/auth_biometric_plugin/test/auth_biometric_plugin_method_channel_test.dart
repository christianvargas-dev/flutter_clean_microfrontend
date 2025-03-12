import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auth_biometric_plugin/auth_biometric_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAuthBiometricPlugin platform = MethodChannelAuthBiometricPlugin();
  const MethodChannel channel = MethodChannel('auth_biometric_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
