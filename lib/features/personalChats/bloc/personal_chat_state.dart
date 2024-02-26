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
