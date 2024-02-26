part of 'personal_chat_bloc.dart';

sealed class PersonalChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonalChatsInitialState extends PersonalChatState {}

class PersonalChatsLoadingState extends PersonalChatState {}

class PersonalChatsSuccessfulLoadedState extends PersonalChatState {
  final List<String> chatsUsersList;

  PersonalChatsSuccessfulLoadedState({required this.chatsUsersList});
}

class PersonalChatsErrorState extends PersonalChatState {}

class StartChatLoadingState extends PersonalChatState {}

class StartChatSuccessfulLoadedState extends PersonalChatState {
  final bool status;

  StartChatSuccessfulLoadedState({required this.status});
}

class StartChatErrorState extends PersonalChatState {}

class CreateGroupChatLoadingState extends PersonalChatState {}

class CreateGroupChatSuccessfulLoadedState extends PersonalChatState {
  final bool status;

  CreateGroupChatSuccessfulLoadedState({required this.status});
}

class CreateGroupChatErrorState extends PersonalChatState {}
