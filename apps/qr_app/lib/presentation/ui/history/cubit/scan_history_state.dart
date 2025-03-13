part of 'scan_history_cubit.dart';

abstract class ScanHistoryState {}

class ScanHistoryInitial extends ScanHistoryState {}

class ScanHistoryLoading extends ScanHistoryState {}

class ScanHistoryLoaded extends ScanHistoryState {
  final List<ScanHistory> history;
  ScanHistoryLoaded(this.history);
}

class ScanHistoryError extends ScanHistoryState {
  final String message;
  ScanHistoryError(this.message);
}
