import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:qr_app/domain/use_cases/scan_qr_use_case.dart';
import 'package:qr_app/domain/entities/qr_result.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/repositories/qr_scanner_repository.dart';
import 'package:qr_app/presentation/ui/scan_qr/cubit/scan_qr_cubit.dart';
import 'package:qr_app/presentation/ui/scan_qr/cubit/scan_qr_state.dart';

import '../mocks.mocks.dart'; 

@GenerateMocks([QrScannerRepository]) 
void main() {
  late ScanQrCubit scanQrCubit;
  late MockQrScannerRepository mockQrScannerRepository;
  late ScanQrUseCase scanQrUseCase;

  setUp(() {
   
    mockQrScannerRepository = MockQrScannerRepository();
    scanQrUseCase = ScanQrUseCase(mockQrScannerRepository);
    scanQrCubit = ScanQrCubit(scanQrUseCase: scanQrUseCase);
  });

  tearDown(() {
  
    scanQrCubit.close();
  });

  test('El estado inicial debe ser ScanQrInitial', () {
    expect(scanQrCubit.state, ScanQrInitial());
  });

  blocTest<ScanQrCubit, ScanQrState>(
    'Debe emitir [ScanQrLoading, ScanQrSuccess] cuando el escaneo es exitoso',
    build: () {
      when(mockQrScannerRepository.scanQRCode()).thenAnswer(
        (_) async => Right(QrResult(value: "Código QR válido")),
      );
      return scanQrCubit;
    },
    act: (cubit) => cubit.scanQRCode(),
    expect: () => [
      ScanQrLoading(),
      ScanQrSuccess("Código QR válido"),
    ],
  );

  blocTest<ScanQrCubit, ScanQrState>(
    'Debe emitir [ScanQrLoading, ScanQrError] cuando el escaneo falla',
    build: () {
      when(mockQrScannerRepository.scanQRCode()).thenAnswer(
        (_) async => Left(ScanFailure("Error al escanear QR")),
      );
      return scanQrCubit;
    },
    act: (cubit) => cubit.scanQRCode(),
    expect: () => [
      ScanQrLoading(),
      ScanQrError("Error al escanear QR"),
    ],
  );
}
