import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message_model.dart';
import '../../services/notification/notification_service.dart';

class ChatRoomRepository {
  Future<bool> sendMessage({
    required String chatRoomId,
    required ChatMessages chatMessageModel,
    File? image,
    File? video,
  }) async {
    try {
      // String imageUrl = '';
      // String videoUrl = '';

      // // if (video != null) {
      // //   videoUrl = (await FirebaseServices.uploadFileToFirebaseStorage(video));
      // // }
      // // if (image != null) {
      // //   imageUrl = (await FirebaseServices.uploadFileToFirebaseStorage(image));
      // // }

      // final chatRoomIdRef = FirebaseFirestore.instance
      //     .collection("chatRooms")
      //     .doc(chatRoomId)
      //     .collection("chats")
      //     .doc();

      // // print("imageUrl  ++++++++++++++++     $imageUrl");
      // // print("videoUrl  ++++++++++++++++     $videoUrl");

      // final chatRef = chatRoomIdRef.doc(chatRoomIdRef.id);

      // await chatRef.set(chatMessageModel.toMap());

      // // await chatRef.update({
      // //   "imageUrl": imageUrl,
      // //   "videoUrl": videoUrl,
      // // });

      // final receiverUserId = chatMessageModel.idTo;

      // final res = await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(receiverUserId)
      //     .get();
      // final data = res.data();

      final chatRoomIdRef = FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("chats")
          .doc();

      await chatRoomIdRef.set(chatMessageModel.toMap());

      final receiverUserId = chatMessageModel.idTo;

      final res = await FirebaseFirestore.instance
          .collection("users")
          .doc(receiverUserId)
          .get();
      final data = res.data();

      SendNotification().sendNotification(
        body: "New Message",
        title: data?['username'],
        token: data?['fcmToken'],
        notificationCategory: "message",
      );

      return true;
    } catch (error) {
      return false; // Handle error as needed in your app
    }
  }

  Stream<List<String>> gettingAllMessagesOfChatRoom({
    required String chatRoomId,
  }) {
    List<String> allChatsId = [];
    try {
      allChatsId.clear();
      return FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("chats")
          .orderBy("timestamp", descending: true)
          .snapshots()
          .map((querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.id).toList());
    } catch (error) {
      rethrow;
    }
  }
}
