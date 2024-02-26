import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/firebaseServices/firebase_services.dart';

class SendMessage {
  static Future<bool> sendPersonalMessage(
      {required String text,
      required chatRoomId,
      File? image,
      File? video}) async {
    User? user = FirebaseAuth.instance.currentUser;
    String imageUrl = '';
    String videoUrl = '';
    if (video != null) {
      videoUrl = (await FirebaseServices.uploadFileToFirebaseStorage(video));
    }
    if (image != null) {
      imageUrl = (await FirebaseServices.uploadFileToFirebaseStorage(image));
    }

    CollectionReference pollsRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection("messages");
    pollsRef.add({
      'text': text,
      'userId': user!.uid,
      'image': imageUrl,
      'video': videoUrl,
      'createdAt': DateTime.now()
    });
    return true;
  }
}
