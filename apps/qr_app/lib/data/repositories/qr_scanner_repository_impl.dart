import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/qr_result.dart';
import 'package:qr_app/domain/repositories/qr_scanner_repository.dart';
import 'package:qr_scanner_plugin/qr_scanner_plugin.dart';

@LazySingleton(as: QrScannerRepository)
class QrScannerRepositoryImpl implements QrScannerRepository {
  final QrScannerPlugin qrScannerPlugin;

  QrScannerRepositoryImpl(this.qrScannerPlugin);

  @override
  Future<Either<Failure, QrResult>> scanQRCode() async {
    try {
      final result = await qrScannerPlugin.scanQRCode();
      return Right(QrResult(value: result.value!));
    } catch (e) {
      return Left(ScanFailure("Error al escanear QR: $e"));
    }
  }
}
