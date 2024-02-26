import 'package:chat_app_flutter/repositories/allUserChats/all_users_chats_repository.dart';

class AllUsersChatsServices {
  final allUsersChatsRepository = AllUsersChatsRepository();

  Future<List<String>> getAllUsersChats({required String userId}) async {
    return allUsersChatsRepository.getAllUsersChats(userId: userId);
  }
}
