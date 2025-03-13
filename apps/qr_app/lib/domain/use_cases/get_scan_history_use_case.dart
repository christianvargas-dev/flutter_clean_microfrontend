import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/scan_history.dart';
import 'package:qr_app/domain/repositories/scan_history_repository.dart';

@LazySingleton()
class GetScanHistoryUseCase {
  final ScanHistoryRepository repository;

  GetScanHistoryUseCase(this.repository);

  Future<Either<Failure, List<ScanHistory>>> call() {
    return repository.getScanHistory();
  }
}
