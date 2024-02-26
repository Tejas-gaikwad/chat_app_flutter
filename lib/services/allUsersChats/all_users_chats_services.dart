import 'package:chat_app_flutter/repositories/allUserChats/all_users_chats_repository.dart';

class AllUsersChatsServices {
  final allUsersChatsRepository = AllUsersChatsRepository();

  Future<List<String>> getAllUsersChats({required String userId}) async {
    return allUsersChatsRepository.getAllUsersChats(userId: userId);
  }

  Future<bool> startChatWithUser({
    required String senderUserId,
    required String receiverUserId,
  }) async {
    return allUsersChatsRepository.startChatWithUser(
      receiverUserId: receiverUserId,
      senderUserId: senderUserId,
    );
  }

  Future<bool> createGroupChat({
    required String groupName,
    required List<String> listOfUsersInGroup,
  }) async {
    return allUsersChatsRepository.createGroupChat(
      groupName: groupName,
      listOfUsersInGroup: listOfUsersInGroup,
    );
  }
}
