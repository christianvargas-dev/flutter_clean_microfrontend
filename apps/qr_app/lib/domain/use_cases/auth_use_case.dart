import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/auth_result.dart';
import 'package:qr_app/domain/repositories/auth_repository.dart';

@LazySingleton()
class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<Either<Failure, AuthResult>> call() async {
    return repository.authenticate();
  }
}
