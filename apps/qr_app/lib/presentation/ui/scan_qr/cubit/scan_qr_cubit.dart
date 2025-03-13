import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_app/domain/use_cases/scan_qr_use_case.dart';

import 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  final ScanQrUseCase scanQrUseCase;
  

  ScanQrCubit({required this.scanQrUseCase}) : super(ScanQrInitial());

  void scanQRCode() async {
    emit(ScanQrLoading());
    final result = await scanQrUseCase();
    result.fold(
      (failure) => emit(ScanQrError(failure.message!)),
      (qrData) => emit(ScanQrSuccess(qrData.value)),
    );
  }
}
