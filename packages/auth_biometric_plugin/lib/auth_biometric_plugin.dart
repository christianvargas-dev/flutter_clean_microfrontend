import 'src/pigeon/auth_pigeon.g.dart';

export 'src/pigeon/auth_pigeon.g.dart'; 

class AuthBiometricPlugin {
  Future<BiometricResult> authenticate() {
    final api = BiometricAuthApi(); 
    return api.authenticate(); 
  }
}
