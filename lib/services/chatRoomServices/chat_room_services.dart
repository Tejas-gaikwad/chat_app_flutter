import 'dart:io';

import 'package:chat_app_flutter/models/chat_message_model.dart';
import 'package:chat_app_flutter/repositories/chatRoomRepository/chat_room_repository.dart';

class ChatRoomServices {
  final chatRoomRepository = ChatRoomRepository();
  Future<bool> sendMessage({
    required String chatRoomId,
    required ChatMessages chatMessageModel,
    File? image,
    File? video,
  }) async {
    return chatRoomRepository.sendMessage(
      image: image,
      video: video,
      chatRoomId: chatRoomId,
      chatMessageModel: chatMessageModel,
    );
  }

  Stream<List<String>> gettingAllMessagesOfChatRoom({
    required String chatRoomId,
  }) {
    return chatRoomRepository.gettingAllMessagesOfChatRoom(
      chatRoomId: chatRoomId,
    );
  }
}
