part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email, password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {}
