part of 'personal_chat_bloc.dart';

sealed class PersonalChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllUsersChatsEvent extends PersonalChatEvent {
  final String userId;
  GetAllUsersChatsEvent({required this.userId});

  @override
  List<Object> get props => [];
}
