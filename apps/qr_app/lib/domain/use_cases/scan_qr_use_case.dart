import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/qr_result.dart';
import 'package:qr_app/domain/repositories/qr_scanner_repository.dart';

@LazySingleton()
class ScanQrUseCase {
  final QrScannerRepository repository;

  ScanQrUseCase(this.repository);

  Future<Either<Failure, QrResult>> call() async {
    return repository.scanQRCode();
  }
}
