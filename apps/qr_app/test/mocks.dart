
import 'package:mockito/annotations.dart';
import 'package:qr_app/domain/repositories/auth_repository.dart';
import 'package:qr_app/domain/repositories/qr_scanner_repository.dart';
import 'package:qr_app/domain/repositories/scan_history_repository.dart';

@GenerateMocks([
  AuthRepository,         
  QrScannerRepository,    
  ScanHistoryRepository   
])
void main() {}
