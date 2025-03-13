import 'package:dartz/dartz.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/qr_result.dart';

abstract class QrScannerRepository {
  Future<Either<Failure, QrResult>> scanQRCode();
}
