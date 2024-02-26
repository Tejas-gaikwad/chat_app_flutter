import 'package:chat_app_flutter/constants/utils/colors.dart';
import 'package:chat_app_flutter/features/chatRoom/bloc/chat_room_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/chatRoom/view/group_chat_room.dart';
import 'get_user_info_card_widget.dart';

class ChatInitialProfileWidget extends StatelessWidget {
  final String currentUserId;
  final String chatRoomId;
  final String type;

  const ChatInitialProfileWidget({
    super.key,
    required this.chatRoomId,
    required this.type,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("chatRooms")
          // .where("type", isEqualTo: type)
          .doc(chatRoomId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("ERRROR  ->>>>    ${snapshot.error}");
          return Center(
            child: Text(
              "Error",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data;
          String? receiverId;

          // final lastMessageNotReadByUserId =
          //     data?.data()?['lastMessageNotReadBy'];
          // final DateTime lastMessageSentAt =
          //     data?.data()?['lastMessageSentAt']?.toDate();

          for (var uid in data?['users']) {
            if (uid != currentUserId && data?['type'] == "personal") {
              receiverId = uid;
            }
          }

          if (data?['type'] == type) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                type == "personal"
                    ? GetUserInfoCardWidget(
                        // lastMessageNotReadByUserId: lastMessageNotReadByUserId,
                        // lastMessageSentAt: lastMessageSentAt,
                        currentUserId: currentUserId,
                        uid: receiverId ?? '',
                        chatRoomId: chatRoomId,
                        type: type,
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) =>
                                      ChatRoomBloc(ChatRoomInitialState()),
                                  child: GroupChatRoomScreen(
                                    username: data?['groupName'],
                                    currentUserId: currentUserId,
                                    chatRoomId: chatRoomId,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                height: 50,
                                width: 50,
                                child: const ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    child: Icon(Icons.group)),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?['groupName'],
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                const Divider(),
              ],
            );
          }
        }

        return const SizedBox();
      },
    );
  }
}
