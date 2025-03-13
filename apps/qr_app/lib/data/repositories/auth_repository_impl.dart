import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/auth_result.dart';
import 'package:qr_app/domain/repositories/auth_repository.dart';
import 'package:auth_biometric_plugin/auth_biometric_plugin.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthBiometricPlugin authPlugin;

  AuthRepositoryImpl(this.authPlugin);

  @override
  Future<Either<Failure, AuthResult>> authenticate() async {
    try {
      print("📡 [AuthRepositoryImpl] Iniciando autenticación...");

      final result = await authPlugin.authenticate();
      
      print("✅ [AuthRepositoryImpl] Resultado recibido:");
      print("   - success: ${result.success}");
      print("   - message: ${result.message}");

      return Right(AuthResult(success: result.success, message: result.message ?? ""));
    } catch (e, stacktrace) {
      print("❌ [AuthRepositoryImpl] Error en autenticación: $e");
      print(stacktrace);
      return Left(AuthFailure("Error en autenticación: $e"));
    }
  }
}

