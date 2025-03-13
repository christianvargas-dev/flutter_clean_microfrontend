import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:qr_app/domain/use_cases/auth_use_case.dart';
import 'package:qr_app/presentation/ui/auth/cubit/auth_cubit.dart';
import 'package:qr_app/presentation/ui/auth/cubit/auth_state.dart';
import 'package:qr_app/domain/repositories/auth_repository.dart';
import 'package:qr_app/core/errors/failures.dart';
import 'package:qr_app/domain/entities/auth_result.dart';

import '../mocks.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late AuthCubit authCubit;
  late MockAuthRepository mockAuthRepository;
  late AuthUseCase authUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authUseCase = AuthUseCase(mockAuthRepository);
    authCubit = AuthCubit(authUseCase: authUseCase);
  });

  tearDown(() {
    authCubit.close();
  });

  test('El estado inicial debe ser AuthInitial', () {
    expect(authCubit.state, AuthInitial());
  });

  blocTest<AuthCubit, AuthState>(
    'Debe emitir [AuthLoading, AuthSuccess] cuando la autenticación es exitosa',
    build: () {
      when(mockAuthRepository.authenticate()).thenAnswer(
        (_) async => Right(AuthResult(success: true, message: "Éxito")),
      );
      return authCubit;
    },
    act: (cubit) => cubit.authenticate(),
    expect: () => [
      AuthLoading(),
      AuthSuccess(true),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'Debe emitir [AuthLoading, AuthError] cuando la autenticación falla',
    build: () {
      when(mockAuthRepository.authenticate()).thenAnswer(
        (_) async => Left(AuthFailure("Error en autenticación")),
      );
      return authCubit;
    },
    act: (cubit) => cubit.authenticate(),
    expect: () => [
      AuthLoading(),
      AuthError("Error en autenticación"),
    ],
  );
}
