import 'package:chat_app_flutter/constants/utils/colors.dart';
import 'package:chat_app_flutter/features/chatRoom/bloc/chat_room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/chatRoomRepository/chat_room_repository.dart';
import 'chat_body_widget.dart';

class MessagesListingWidget extends StatefulWidget {
  final String chatRoomId;
  final String currentUserId;
  final bool isGroup;

  const MessagesListingWidget({
    super.key,
    required this.chatRoomId,
    required this.currentUserId,
    this.isGroup = false,
  });

  @override
  State<MessagesListingWidget> createState() => _MessagesListingWidgetState();
}

class _MessagesListingWidgetState extends State<MessagesListingWidget> {
  @override
  void initState() {
    super.initState();
    context
        .read<ChatRoomBloc>()
        .add(GetAllMessagesOfChatRoomEvent(chatRoomId: widget.chatRoomId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      builder: (context, state) {
        if (state is GettingChatsLoadingState) {
          const SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        }
        if (state is GettingChatsSuccessState) {
          return streamFunction();
        }
        return const SizedBox();
      },
    );
  }

  streamFunction() {
    final chatRoomRepository = ChatRoomRepository();
    return StreamBuilder<List<String>>(
      stream: chatRoomRepository.gettingAllMessagesOfChatRoom(
          chatRoomId: widget.chatRoomId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
              height: 50,
              width: 50,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(
            'No chats available',
            style: Theme.of(context).textTheme.bodyText2,
          );
        } else {
          List<String> chatsIdList = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: chatsIdList.length,
            itemBuilder: (context, index) {
              return ChatBodyWidget(
                isGroup: widget.isGroup,
                chatRoomId: widget.chatRoomId,
                chatId: chatsIdList[index],
                currentUserId: widget.currentUserId,
              );
            },
          );
        }
      },
    );
  }
}
