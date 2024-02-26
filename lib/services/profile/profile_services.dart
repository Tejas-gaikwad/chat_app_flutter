import 'package:chat_app_flutter/models/user_data_model.dart';
import 'package:chat_app_flutter/repositories/profile/profile_repository.dart';

class ProfileServices {
  final profileRepo = ProfileRepository();

  Future<UserDataModel> getProfileInformation({required String userId}) async {
    return profileRepo.getProfileInformation(userId: userId);
  }
}
