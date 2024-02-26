import 'package:chat_app_flutter/services/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user_data_model.dart';

class AuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      print(
          "googleAuth?.accessToken   ->>>>>>>>>>   ${googleAuth?.accessToken}");

      print("googleAuth?.idToken   ->>>>>>>>>>   ${googleAuth?.idToken}");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userData = await auth.signInWithCredential(credential);

      String uid = userData.user?.uid ?? '';
      print("uid   ->>>>>>>>>>   ${uid}");

      DocumentReference userDocRef = _firestore.collection('users').doc(uid);

      final snapshot = await userDocRef.get();

      print("snapshot   ->>>>>>>>>>   ${snapshot.data()}");

      if (snapshot.exists) {
        UserDataModel(
          uid: uid,
          username: userData.user?.displayName ?? '',
          email: userData.user?.email ?? '',
          imagePath: userData.user?.photoURL ?? '',
        );
      } else {
        final messagingData = await FirebaseMessaging.instance.getToken();
        final data = messagingData;
        final userProfilePicture = userData.user?.photoURL;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'username': userData.user?.displayName,
          'email': userData.user?.email,
          'imagePath': userProfilePicture,
          'fcmToken': data,
        });
      }

      return uid;
    } catch (error) {
      print("Google login error  ->   $error");
      rethrow;
    }
  }

  Future<bool> logout() async {
    try {
      // Sign out from Google if the user is signed in with Google
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Clear user's login status
      await SharedPreferencesService.setUserLoginStatus(status: false);

      await Future.delayed(const Duration(seconds: 2));

      return true;
    } catch (error) {
      print("Google login error  ->   $error");
      rethrow;
    }
  }
}
