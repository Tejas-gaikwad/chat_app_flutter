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
      final chatRoomIds = data?["chatRooms"];

      for (var id in chatRoomIds) {
        allUsersChatRoom.add(id);
      }

      return allUsersChatRoom;
    } catch (error) {
      print("error ->>>>   $error");
      rethrow;
    }
  }

  // List<String> allPersonalChatRoom = [];
  // Future<List<String>> getAllUsersChats() async {
  //   final ref = await FirebaseFirestore.instance
  //       .collection("chatRooms")
  //       .where("type", isEqualTo: "personal")
  //       .get();

  //   final chatRoomIds = ref.docs;

  //   for (var chatRoom in chatRoomIds) {
  //     print("personal chatRoom id ===>>>>>>>>>     ${chatRoom.id}");
  //     allPersonalChatRoom.add(chatRoom.id);
  //   }

  //   return allPersonalChatRoom;
  // }

  // List<String> allGroupChatRoom = [];
  // Future<List<String>> getAllGroupChats() async {
  //   final ref = await FirebaseFirestore.instance
  //       .collection("chatRooms")
  //       .where("type", isEqualTo: "group")
  //       .get();

  //   final chatRoomIds = ref.docs;

  //   for (var chatRoom in chatRoomIds) {
  //     print("group chatRoom id ===>>>>>>>>>     ${chatRoom.id}");
  //     allGroupChatRoom.add(chatRoom.id);
  //   }

  //   return allGroupChatRoom;
  // }
}
