import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_app/domain/use_cases/auth_use_case.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  AuthCubit({required this.authUseCase}) : super(AuthInitial());

  void authenticate() async {
    emit(AuthLoading()); 

    try {
      final result = await authUseCase();
      await Future.delayed(Duration(milliseconds: 500)); 

      result.fold(
        (failure) => emit(AuthError(failure.message!)), 
        (authResult) {
          if (authResult.success) {
            emit(AuthSuccess(authResult.success));
          } else {
            emit(AuthError(authResult.message ?? "⚠️ Autenticación fallida"));
          }
        },
      );
    } catch (e) {
      emit(AuthError("Error inesperado: $e"));
    }
  }
}
