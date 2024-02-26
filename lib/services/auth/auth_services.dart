import 'package:chat_app_flutter/models/user_data_model.dart';

import '../../repositories/auth/auth_repository.dart';

class AuthServices {
  final authRepository = AuthRepository();

  Future<String> googleLogin() async {
    return authRepository.googleLogin();
  }

  Future<bool> logout() async {
    return authRepository.logout();
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    return authRepository.login(email: email, password: password);
  }

  Future<String> signup(
      {required UserDataModel user, required String password}) async {
    return authRepository.signUp(user: user, password: password);
  }
}
