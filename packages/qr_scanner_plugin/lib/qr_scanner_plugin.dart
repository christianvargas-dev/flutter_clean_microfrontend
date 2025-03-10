
import 'package:qr_scanner_plugin/qr_scanner_plugin.dart';

export 'src/pigeon/qr_pigeon.g.dart'; // ✅ Solo exportamos Pigeon

class QrScannerPlugin {
  Future<QRResult> scanQRCode() {
    final api = QRScannerApi();
    return api.scanQRCode(); // ✅ Llama directamente a la API generada por Pigeon
  }
}
