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

class StartChatWithUserEvent extends PersonalChatEvent {
  final String senderId;
  final String receiverId;

  StartChatWithUserEvent({
    required this.senderId,
    required this.receiverId,
  });

  @override
  List<Object> get props => [senderId, receiverId];
}

class CreateGroupEvent extends PersonalChatEvent {
  final String groupName;
  final List<String> groupUsersList;

  CreateGroupEvent({
    required this.groupName,
    required this.groupUsersList,
  });

  @override
  List<Object> get props => [groupName, groupUsersList];
}
