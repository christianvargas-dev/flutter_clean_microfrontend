
import 'package:auth_biometric_plugin/auth_biometric_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_scanner_plugin/qr_scanner_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection.config.dart'; 

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  getIt.init();
  
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  
  getIt.registerLazySingleton<QrScannerPlugin>(() => QrScannerPlugin());
  getIt.registerLazySingleton<AuthBiometricPlugin>(() => AuthBiometricPlugin());
}

