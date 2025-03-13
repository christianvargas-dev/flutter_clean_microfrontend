import 'package:equatable/equatable.dart';

abstract class ScanQrState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanQrInitial extends ScanQrState {}
class ScanQrLoading extends ScanQrState {}
class ScanQrSuccess extends ScanQrState {
  final String qrData;
  ScanQrSuccess(this.qrData);
  @override
  List<Object?> get props => [qrData];
}
class ScanQrError extends ScanQrState {
  final String message;
  ScanQrError(this.message);
  @override
  List<Object?> get props => [message];
}
