import 'package:equatable/equatable.dart';

abstract class PinAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PinAuthInitial extends PinAuthState {}

class PinAuthLoading extends PinAuthState {}

class PinAuthSuccess extends PinAuthState {}

class PinAuthError extends PinAuthState {
  final String message;
  PinAuthError(this.message);

  @override
  List<Object?> get props => [message];
}
