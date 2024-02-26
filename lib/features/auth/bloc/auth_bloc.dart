import 'package:bloc/bloc.dart';
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

        print("userId  ----------    $userId");

        if (userId != "") {
          emit(GoogleLoginSuccessState(userId: userId));
        } else {
          emit(
              const GoogleLoginErrorState(message: "Error while Google Login"));
        }
      } catch (error) {
        print("Error  ->    $error");
        emit(const GoogleLoginErrorState(message: "Error while Google Login"));
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
        print("Error  ->    $error");
        emit(const LogoutErrorState(message: "Error while Logout"));
      }
    });
  }
}
