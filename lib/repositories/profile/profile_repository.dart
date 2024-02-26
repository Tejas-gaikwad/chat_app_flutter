import 'package:chat_app_flutter/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  Future<UserDataModel> getProfileInformation({required String userId}) async {
    final res =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    final userInfo = res.data();

    final data = UserDataModel(
      uid: userInfo?['uid'],
      username: userInfo?['username'],
      email: userInfo?['email'],
      imagePath: userInfo?['imagePath'],
    );

    return data;
  }
}
