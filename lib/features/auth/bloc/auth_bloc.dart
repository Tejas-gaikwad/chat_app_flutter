import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/models/user_data_model.dart';
import 'package:chat_app_flutter/services/auth/auth_services.dart';
import 'package:equatable/equatable.dart';
part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(super.initialState) {
    final authService = AuthServices();
    on<GoogleLoginEvent>((event, emit) async {
      try {
        emit(GoogleLoginLoadingState());

        final userId = await authService.googleLogin();

        if (userId != "") {
          emit(GoogleLoginSuccessState(userId: userId));
        } else {
          emit(
              const GoogleLoginErrorState(message: "Error while Google Login"));
        }
      } catch (error) {
        emit(const GoogleLoginErrorState(message: "Error while Google Login"));
      }
    });

    on<SignUpEvent>((event, emit) async {
      try {
        emit(SignUpLoadingState());

        final userId = await authService.signup(
            user: event.user, password: event.password);

        if (userId != "") {
          emit(SignUpSuccessState(userId: userId));
        } else {
          emit(const SignUpErrorState(message: "Error while Google Login"));
        }
      } catch (error) {
        emit(const SignUpErrorState(message: "Error while Google Login"));
      }
    });

    on<LoginEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());

        final userId = await authService.login(
          email: event.email,
          password: event.password,
        );

        if (userId != "") {
          emit(LoginSuccessState(userId: userId));
        } else {
          emit(const LoginErrorState(message: "Error while Google Login"));
        }
      } catch (error) {
        emit(const LoginErrorState(message: "Error while Google Login"));
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        emit(LogoutLoadingState());

        final logoutStatus = await authService.logout();

        if (logoutStatus) {
          emit(LogoutSuccessState(logoutStatus: logoutStatus));
        } else {
          emit(const LogoutErrorState(message: "Error while Logout"));
        }
      } catch (error) {
        emit(const LogoutErrorState(message: "Error while Logout"));
      }
    });
  }
}
