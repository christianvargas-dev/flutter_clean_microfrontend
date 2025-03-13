// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth_biometric_plugin/auth_biometric_plugin.dart' as _i251;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:qr_app/data/repositories/auth_repository_impl.dart' as _i466;
import 'package:qr_app/data/repositories/qr_scanner_repository_impl.dart'
    as _i829;
import 'package:qr_app/data/repositories/scan_history_repository_impl.dart'
    as _i626;
import 'package:qr_app/domain/repositories/auth_repository.dart' as _i541;
import 'package:qr_app/domain/repositories/qr_scanner_repository.dart' as _i638;
import 'package:qr_app/domain/repositories/scan_history_repository.dart'
    as _i146;
import 'package:qr_app/domain/use_cases/auth_use_case.dart' as _i958;
import 'package:qr_app/domain/use_cases/get_scan_history_use_case.dart'
    as _i491;
import 'package:qr_app/domain/use_cases/save_scan_use_case.dart' as _i931;
import 'package:qr_app/domain/use_cases/scan_qr_use_case.dart' as _i374;
import 'package:qr_scanner_plugin/qr_scanner_plugin.dart' as _i122;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i638.QrScannerRepository>(
        () => _i829.QrScannerRepositoryImpl(gh<_i122.QrScannerPlugin>()));
    gh.lazySingleton<_i146.ScanHistoryRepository>(() =>
        _i626.ScanHistoryRepositoryImpl(prefs: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i541.AuthRepository>(
        () => _i466.AuthRepositoryImpl(gh<_i251.AuthBiometricPlugin>()));
    gh.lazySingleton<_i374.ScanQrUseCase>(
        () => _i374.ScanQrUseCase(gh<_i638.QrScannerRepository>()));
    gh.lazySingleton<_i958.AuthUseCase>(
        () => _i958.AuthUseCase(gh<_i541.AuthRepository>()));
    gh.lazySingleton<_i491.GetScanHistoryUseCase>(
        () => _i491.GetScanHistoryUseCase(gh<_i146.ScanHistoryRepository>()));
    gh.lazySingleton<_i931.SaveScanUseCase>(
        () => _i931.SaveScanUseCase(gh<_i146.ScanHistoryRepository>()));
    return this;
  }
}
