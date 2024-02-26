import '../../repositories/auth/auth_repository.dart';

class AuthServices {
  final authRepository = AuthRepository();

  Future<String> googleLogin() async {
    return authRepository.googleLogin();
  }

  Future<bool> logout() async {
    return authRepository.logout();
  }
}
