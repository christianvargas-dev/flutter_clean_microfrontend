import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/scan_history.dart';
import 'package:qr_app/domain/repositories/scan_history_repository.dart';

@LazySingleton()
class SaveScanUseCase {
  final ScanHistoryRepository repository;

  SaveScanUseCase(this.repository);

  Future<Either<Failure, void>> call(ScanHistory scan) {
    return repository.saveScan(scan);
  }
}
