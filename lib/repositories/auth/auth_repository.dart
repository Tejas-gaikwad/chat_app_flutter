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

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userData = await auth.signInWithCredential(credential);

      String uid = userData.user?.uid ?? '';

      DocumentReference userDocRef = _firestore.collection('users').doc(uid);

      final snapshot = await userDocRef.get();

      if (snapshot.exists) {
        UserDataModel(
          uid: uid,
          username: userData.user?.displayName ?? '',
          email: userData.user?.email ?? '',
          imagePath: userData.user?.photoURL ??
              "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
        );
      } else {
        final messagingData = await FirebaseMessaging.instance.getToken();
        final data = messagingData;
        final userProfilePicture = userData.user?.photoURL;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          "chatRoomId": [],
          'username': userData.user?.displayName,
          'email': userData.user?.email,
          'imagePath': userProfilePicture ??
              "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
          'fcmToken': data,
        });
      }

      return uid;
    } catch (error) {
      print("Google login error  ->   $error");
      rethrow;
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return userCredential.user!.uid;
      }
      return "";
    } catch (error) {
      print("Google login error  ->   $error");
      rethrow;
    }
  }

  Future<String> signUp({
    required UserDataModel user,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      String uid = userCredential.user?.uid ?? '';

      userCredential.user?.photoURL;
      final messagingData = await FirebaseMessaging.instance.getToken();
      final fcmToken = messagingData;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'username': user.username,
        'email': user.email,
        'fcmToken': fcmToken,
        'imagePath': "",
      });

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
