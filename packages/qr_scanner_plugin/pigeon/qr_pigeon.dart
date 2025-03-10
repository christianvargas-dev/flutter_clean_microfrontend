import 'package:pigeon/pigeon.dart';

class QRResult {
  String? value;
}

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/pigeon/qr_pigeon.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/example/qr_scanner/QRScannerApi.kt',
  swiftOut: 'ios/Classes/QRScannerApi.swift',
))

@HostApi()
abstract class QRScannerApi {
  @async
  QRResult scanQRCode();
}
