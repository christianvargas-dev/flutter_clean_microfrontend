import 'package:flutter_bloc/flutter_bloc.dart';
import 'pin_auth_state.dart';

class PinAuthCubit extends Cubit<PinAuthState> {
  final String _correctPin = "1234"; 

  PinAuthCubit() : super(PinAuthInitial());

  void authenticateWithPin(String pin) {
    emit(PinAuthLoading());
    Future.delayed(Duration(seconds: 1), () {
      if (pin == _correctPin) {
        emit(PinAuthSuccess());
      } else {
        emit(PinAuthError("PIN incorrecto, intenta de nuevo."));
      }
    });
  }
}
