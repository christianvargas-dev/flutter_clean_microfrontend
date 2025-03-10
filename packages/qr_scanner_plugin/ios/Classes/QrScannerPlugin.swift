import Flutter
import UIKit

public class QrScannerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = QRScannerApiImpl()
        QRScannerApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }
}
