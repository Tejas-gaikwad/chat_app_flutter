part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GoogleLoginEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final UserDataModel user;
  final String password;

  SignUpEvent({
    required this.user,
    required this.password,
  });

  @override
  List<Object> get props => [user, password];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthEvent {}
