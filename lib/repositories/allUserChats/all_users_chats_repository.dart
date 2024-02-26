import 'package:cloud_firestore/cloud_firestore.dart';

class AllUsersChatsRepository {
  List<String> allUsersChatRoom = [];
  Future<List<String>> getAllUsersChats({required String userId}) async {
    try {
      allUsersChatRoom.clear();
      final ref = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      final data = ref.data();
      final chatRoomIds = data?["chatRoomId"];

      if (chatRoomIds != null && chatRoomIds != []) {
        for (var id in chatRoomIds) {
          allUsersChatRoom.add(id);
        }
      }

      return allUsersChatRoom;
    } catch (error) {
      print("error ->>>>   $error");
      rethrow;
    }
  }

  Future<bool> startChatWithUser({
    required String receiverUserId,
    required String senderUserId,
  }) async {
    try {
      final chatRoomRef =
          FirebaseFirestore.instance.collection("chatRooms").doc();

      await chatRoomRef.set({
        "chatRoomId": chatRoomRef.id,
        "type": "personal",
        "users": [senderUserId, receiverUserId]
      });

      final senderUserRef =
          FirebaseFirestore.instance.collection("users").doc(senderUserId);
      final receiverUserRef =
          FirebaseFirestore.instance.collection("users").doc(receiverUserId);

      final senderData = await senderUserRef.get();
      final senderInfo = senderData.data();

      final senderChatRoomsList = senderInfo?['chatRoomId'];

      List<String> senderChatRoomArray = [];
      if (senderChatRoomsList != null) {
        for (var chatRoomId in senderChatRoomsList) {
          senderChatRoomArray.add(chatRoomId);
        }
      }

      senderChatRoomArray.add(chatRoomRef.id);

      await senderUserRef.update({
        "chatRoomId": senderChatRoomArray,
      });

      final receiverData = await receiverUserRef.get();

      final receiverInfo = receiverData.data();

      final recieverChatRoomsList = receiverInfo?['chatRoomId'];

      List<String> recieverchatRoomArray = [];
      if (recieverChatRoomsList != null) {
        for (var chatRoomId in recieverChatRoomsList) {
          recieverchatRoomArray.add(chatRoomId);
        }
      }

      recieverchatRoomArray.add(chatRoomRef.id);

      await receiverUserRef.update({
        "chatRoomId": recieverchatRoomArray,
      });

      return true;
    } catch (error) {
      print("error ->>>>   $error");
      return false;
    }
  }

  Future<bool> createGroupChat({
    required String groupName,
    required List<String> listOfUsersInGroup,
  }) async {
    try {
      final chatRoomRef =
          FirebaseFirestore.instance.collection("chatRooms").doc();

      await chatRoomRef.set({
        "chatRoomId": chatRoomRef.id,
        "type": "group",
        "users": listOfUsersInGroup,
        "groupName": groupName,
      });

      List<String> userChatList = [];
      for (var user in listOfUsersInGroup) {
        final res = await FirebaseFirestore.instance
            .collection("users")
            .doc(user)
            .get();
        final userData = res.data();

        userChatList.clear();

        final userChatRoomsList = userData?["chatRoomId"];

        if (userChatRoomsList != null || userChatRoomsList != []) {
          for (var userChatRoomId in userChatRoomsList) {
            userChatList.add(userChatRoomId);
          }
          userChatList.add(chatRoomRef.id);
        } else {
          userChatList.add(chatRoomRef.id);
        }

        await FirebaseFirestore.instance
            .collection("users")
            .doc(user)
            .update({"chatRoomId": userChatList});
      }

      return true;
    } catch (error) {
      print("error ->>>>   $error");
      return false;
    }
  }
}
