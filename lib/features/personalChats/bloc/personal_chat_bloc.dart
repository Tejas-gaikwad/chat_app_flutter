import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../services/allUsersChats/all_users_chats_services.dart';
part 'personal_chat_event.dart';
part 'personal_chat_state.dart';

class PersonalChatBloc extends Bloc<PersonalChatEvent, PersonalChatState> {
  PersonalChatBloc(super.initialState) {
    final allUsersChatsServices = AllUsersChatsServices();
    on<GetAllUsersChatsEvent>((event, emit) async {
      try {
        emit(PersonalChatsLoadingState());

        final list =
            await allUsersChatsServices.getAllUsersChats(userId: event.userId);

        emit(PersonalChatsSuccessfulLoadedState(chatsUsersList: list));
      } catch (err) {
        print("error ->>>>   $err");
        emit(PersonalChatsErrorState());
      }
    });

    on<StartChatWithUserEvent>((event, emit) async {
      try {
        emit(StartChatLoadingState());

        final status = await allUsersChatsServices.startChatWithUser(
          receiverUserId: event.senderId,
          senderUserId: event.receiverId,
        );

        emit(StartChatSuccessfulLoadedState(status: status));
      } catch (err) {
        print("error ->>>>   $err");
        emit(StartChatErrorState());
      }
    });

    on<CreateGroupEvent>((event, emit) async {
      try {
        emit(CreateGroupChatLoadingState());

        final status = await allUsersChatsServices.createGroupChat(
          groupName: event.groupName,
          listOfUsersInGroup: event.groupUsersList,
        );

        emit(CreateGroupChatSuccessfulLoadedState(status: status));
      } catch (err) {
        print("error ->>>>   $err");
        emit(CreateGroupChatErrorState());
      }
    });
  }
}
