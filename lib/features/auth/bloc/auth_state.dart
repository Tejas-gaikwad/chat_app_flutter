part of "auth_bloc.dart";

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class GoogleLoginLoadingState extends AuthState {}

class GoogleLoginSuccessState extends AuthState {
  final String userId;

  const GoogleLoginSuccessState({required this.userId});

  @override
  List<Object> get props => [userId];
}

class GoogleLoginErrorState extends AuthState {
  final String message;

  const GoogleLoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String userId;

  const LoginSuccessState({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoginErrorState extends AuthState {
  final String message;

  const LoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {
  final String userId;

  const SignUpSuccessState({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SignUpErrorState extends AuthState {
  final String message;

  const SignUpErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {
  final bool logoutStatus;

  const LogoutSuccessState({required this.logoutStatus});

  @override
  List<Object> get props => [logoutStatus];
}

class LogoutErrorState extends AuthState {
  final String message;

  const LogoutErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
