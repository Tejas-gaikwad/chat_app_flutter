part of 'chat_room_bloc.dart';

sealed class ChatRoomState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatRoomInitialState extends ChatRoomState {}

class SendingChatLoadingState extends ChatRoomState {}

class SendingChatSuccessState extends ChatRoomState {}

class SendingChatErrorState extends ChatRoomState {}

class GettingChatsLoadingState extends ChatRoomState {}

class GettingChatsSuccessState extends ChatRoomState {
  final Stream<List<String>> chatsIdList;

  GettingChatsSuccessState({required this.chatsIdList});

  @override
  List<Object> get props => [chatsIdList];
}

class GettingChatsErrorState extends ChatRoomState {}
