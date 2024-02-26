part of 'chat_room_bloc.dart';

sealed class ChatRoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessageInPersonalChatEvent extends ChatRoomEvent {
  final String chatRoomId;
  final ChatMessages chatMessageModel;

  SendMessageInPersonalChatEvent({
    required this.chatRoomId,
    required this.chatMessageModel,
  });

  @override
  List<Object> get props => [chatMessageModel, chatRoomId];
}

class GetAllMessagesOfChatRoomEvent extends ChatRoomEvent {
  final String chatRoomId;

  GetAllMessagesOfChatRoomEvent({
    required this.chatRoomId,
  });

  @override
  List<Object> get props => [chatRoomId];
}
