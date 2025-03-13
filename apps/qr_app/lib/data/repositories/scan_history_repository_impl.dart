import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/scan_history.dart';
import 'package:qr_app/domain/repositories/scan_history_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

@LazySingleton(as: ScanHistoryRepository)
class ScanHistoryRepositoryImpl implements ScanHistoryRepository {
  final SharedPreferences prefs;

  ScanHistoryRepositoryImpl({required this.prefs});

  @override
  Future<Either<Failure, void>> saveScan(ScanHistory scan) async {
    try {
      final List<String> scans = prefs.getStringList('scan_history') ?? [];
      scans.add(jsonEncode({'scannedCode': scan.scannedCode, 'timestamp': scan.timestamp.toIso8601String()}));
      await prefs.setStringList('scan_history', scans);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure("Error guardando el escaneo"));
    }
  }

  @override
  Future<Either<Failure, List<ScanHistory>>> getScanHistory() async {
    try {
      final List<String>? storedScans = prefs.getStringList('scan_history');
      if (storedScans == null) return const Right([]);

      final history = storedScans
          .map((scan) => jsonDecode(scan))
          .map((map) => ScanHistory(scannedCode: map['scannedCode'], timestamp: DateTime.parse(map['timestamp'])))
          .toList();

      return Right(history);
    } catch (e) {
      return Left(StorageFailure("Error obteniendo el historial"));
    }
  }
}
