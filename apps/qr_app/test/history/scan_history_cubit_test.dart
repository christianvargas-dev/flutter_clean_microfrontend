import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:qr_app/domain/use_cases/get_scan_history_use_case.dart';
import 'package:qr_app/domain/use_cases/save_scan_use_case.dart';
import 'package:qr_app/domain/entities/scan_history.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/repositories/scan_history_repository.dart';
import 'package:qr_app/presentation/ui/history/cubit/scan_history_cubit.dart';
import 'package:qr_app/presentation/ui/history/cubit/scan_history_state.dart';


import '../mocks.mocks.dart'; 

@GenerateMocks([ScanHistoryRepository]) 
void main() {
  late ScanHistoryCubit scanHistoryCubit;
  late MockScanHistoryRepository mockScanHistoryRepository;
  late GetScanHistoryUseCase getScanHistoryUseCase;
  late SaveScanUseCase saveScanUseCase;

  setUp(() {
   
    mockScanHistoryRepository = MockScanHistoryRepository();
    getScanHistoryUseCase = GetScanHistoryUseCase(mockScanHistoryRepository);
    saveScanUseCase = SaveScanUseCase(mockScanHistoryRepository);
    scanHistoryCubit = ScanHistoryCubit(
      getScanHistoryUseCase: getScanHistoryUseCase,
      saveScanUseCase: saveScanUseCase,
    );
  });

  tearDown(() {
    scanHistoryCubit.close();
  });

  test('El estado inicial debe ser ScanHistoryInitial', () {
    expect(scanHistoryCubit.state, ScanHistoryInitial());
  });

  blocTest<ScanHistoryCubit, ScanHistoryState>(
    'Debe emitir [ScanHistoryLoading, ScanHistoryLoaded] cuando el historial se carga exitosamente',
    build: () {
      when(mockScanHistoryRepository.getScanHistory()).thenAnswer(
        (_) async => Right([
          ScanHistory(scannedCode: "Código 1", timestamp: DateTime.now()),
          ScanHistory(scannedCode: "Código 2", timestamp: DateTime.now()),
        ]),
      );
      return scanHistoryCubit;
    },
    act: (cubit) => cubit.loadHistory(),
    expect: () => [
      ScanHistoryLoading(),
      isA<ScanHistoryLoaded>(),
    ],
  );

  blocTest<ScanHistoryCubit, ScanHistoryState>(
    'Debe emitir [ScanHistoryLoading, ScanHistoryError] cuando hay un error cargando el historial',
    build: () {
      when(mockScanHistoryRepository.getScanHistory()).thenAnswer(
        (_) async => Left(StorageFailure("Error al cargar el historial")),
      );
      return scanHistoryCubit;
    },
    act: (cubit) => cubit.loadHistory(),
    expect: () => [
      ScanHistoryLoading(),
      ScanHistoryError("Error cargando el historial"),
    ],
  );

  blocTest<ScanHistoryCubit, ScanHistoryState>(
    'Debe llamar a saveScan y luego cargar el historial actualizado',
    build: () {
      when(mockScanHistoryRepository.saveScan(any)).thenAnswer((_) async => Right(null));
      when(mockScanHistoryRepository.getScanHistory()).thenAnswer(
        (_) async => Right([
          ScanHistory(scannedCode: "Nuevo Código", timestamp: DateTime.now()),
        ]),
      );
      return scanHistoryCubit;
    },
    act: (cubit) => cubit.saveScan("Nuevo Código"),
    verify: (cubit) {
      verify(mockScanHistoryRepository.saveScan(any)).called(1);
      verify(mockScanHistoryRepository.getScanHistory()).called(1);
    },
  );
}
