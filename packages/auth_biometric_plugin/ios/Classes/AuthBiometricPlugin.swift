import Flutter
import LocalAuthentication

public class AuthBiometricPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = AuthBiometricPlugin()
        BiometricAuthApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }
}

extension AuthBiometricPlugin: BiometricAuthApi {
    public func authenticate() throws -> BiometricResult {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            var result: BiometricResult?

            let semaphore = DispatchSemaphore(value: 0)
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Usa Face ID o Touch ID para autenticación") { success, _ in
                if success {
                    result = BiometricResult(success: true, message: "Autenticación exitosa.")
                } else {
                    result = BiometricResult(success: false, message: "Falló la autenticación.")
                }
                semaphore.signal()
            }
            semaphore.wait()
            
            return result ?? BiometricResult(success: false, message: "Error desconocido en autenticación.")
        } else {
            return BiometricResult(success: false, message: "⚠️ Face ID / Touch ID no está disponible.")
        }
    }
}


