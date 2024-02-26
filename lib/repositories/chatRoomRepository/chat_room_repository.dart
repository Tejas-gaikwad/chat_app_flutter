import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message_model.dart';

class ChatRoomRepository {
  Future<bool> sendMessage({
    required String chatRoomId,
    required ChatMessages chatMessageModel,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("chats")
          .doc()
          .set(chatMessageModel.toMap());

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

      // final dataList = res.docs;

      // for (var data in dataList) {
      //   final chatId = data.id;
      //   print("gettingAllMessagesOfChatRoom  ID  ->>>>>      ${chatId}");

      //   allChatsId.add(chatId);
      // }

      // return allChatsId;
    } catch (error) {
      rethrow;
    }
  }
}
