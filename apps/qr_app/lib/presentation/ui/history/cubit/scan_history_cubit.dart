import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_app/domain/entities/scan_history.dart';
import 'package:qr_app/domain/use_cases/get_scan_history_use_case.dart';
import 'package:qr_app/domain/use_cases/save_scan_use_case.dart';

part 'scan_history_state.dart';

class ScanHistoryCubit extends Cubit<ScanHistoryState> {
  final GetScanHistoryUseCase getScanHistoryUseCase;
  final SaveScanUseCase saveScanUseCase;

  ScanHistoryCubit({required this.getScanHistoryUseCase, required this.saveScanUseCase})
      : super(ScanHistoryInitial());

  void loadHistory() async {
    emit(ScanHistoryLoading());
    final result = await getScanHistoryUseCase();
    result.fold(
      (failure) => emit(ScanHistoryError("Error cargando el historial")),
      (history) => emit(ScanHistoryLoaded(history)),
    );
  }

  void saveScan(String scannedCode) async {
    final scan = ScanHistory(scannedCode: scannedCode, timestamp: DateTime.now());
    await saveScanUseCase(scan);
    loadHistory();
  }
}
