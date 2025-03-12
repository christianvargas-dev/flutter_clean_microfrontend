import 'package:pigeon/pigeon.dart';

class BiometricResult {
  final bool success;
  final String? message;

  BiometricResult({required this.success, this.message});
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/auth_pigeon.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/example/auth_biometric_plugin/AuthPigeon.kt',
    swiftOptions: SwiftOptions(isNullSafe: true, public: true),
    swiftOut: 'ios/Classes/AuthPigeon.swift',
   
   
  ),
)

@HostApi()
abstract class BiometricAuthApi {
  BiometricResult authenticate();
}