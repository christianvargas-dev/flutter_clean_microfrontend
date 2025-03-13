import 'package:dartz/dartz.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/scan_history.dart';

abstract class ScanHistoryRepository {
  Future<Either<Failure, void>> saveScan(ScanHistory scan);
  Future<Either<Failure, List<ScanHistory>>> getScanHistory();
}
