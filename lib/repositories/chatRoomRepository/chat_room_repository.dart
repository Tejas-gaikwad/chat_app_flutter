import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message_model.dart';
import '../../services/notification/notification_service.dart';

class ChatRoomRepository {
  Future<bool> sendMessage({
    required String chatRoomId,
    required ChatMessages chatMessageModel,
  }) async {
    try {
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
