import 'package:dartz/dartz.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/auth_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> authenticate();
}
