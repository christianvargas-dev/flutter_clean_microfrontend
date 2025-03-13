import 'package:equatable/equatable.dart';
import 'package:qr_app/domain/entities/scan_history.dart';

abstract class ScanHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanHistoryInitial extends ScanHistoryState {}

class ScanHistoryLoading extends ScanHistoryState {}

class ScanHistoryLoaded extends ScanHistoryState {
  final List<ScanHistory> history;

  ScanHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class ScanHistoryError extends ScanHistoryState {
  final String message;

  ScanHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
