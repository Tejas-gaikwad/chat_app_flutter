import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/services/chatRoomServices/chat_room_services.dart';
import 'package:equatable/equatable.dart';
import '../../../models/chat_message_model.dart';
part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc(super.initialState) {
    final chatRoomServices = ChatRoomServices();
    on<SendMessageInPersonalChatEvent>((event, emit) async {
      try {
        emit(SendingChatLoadingState());

        final sendMessageStatus = await chatRoomServices.sendMessage(
          chatRoomId: event.chatRoomId,
          chatMessageModel: event.chatMessageModel,
        );

        print(
            "sendMessageStatus   - >>>>>>>>>>>>>>>>>.    ${sendMessageStatus}");
        print(
            "chatMessageModel   - >>>>>>>>>>>>>>>>>.    ${event.chatMessageModel.toJson()}");

        if (sendMessageStatus) {
          emit(SendingChatSuccessState());
        } else {
          emit(SendingChatErrorState());
        }
      } catch (err) {
        emit(SendingChatErrorState());
      }
    });

    on<GetAllMessagesOfChatRoomEvent>((event, emit) async {
      try {
        emit(GettingChatsLoadingState());

        final list = chatRoomServices.gettingAllMessagesOfChatRoom(
            chatRoomId: event.chatRoomId);

        // print("list  ID  ->>>>>      ${list}");

        emit(GettingChatsSuccessState(chatsIdList: list));
      } catch (err) {
        emit(GettingChatsErrorState());
      }
    });
  }
}
