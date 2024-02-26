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
          .doc(chatRoomId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          String? receiverId;

          for (var uid in data?['users']) {
            if (uid != currentUserId && data?['type'] == "personal") {
              receiverId = uid;
            }
          }

          if (data?['type'] == type) {
            return Column(
              children: [
                type == "personal"
                    ? GetUserInfoCardWidget(
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
                                    currentUserId: currentUserId,
                                    otherProfileId: receiverId ?? "",
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
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  child: Image.network(
                                    "https://i.pinimg.com/736x/c4/a6/ad/c4a6ad3a4bdcd5a8d5425f2afa2f81c6.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chatRoomId,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    // Text(
                                    //   "Devloper last Message",
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 12,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    const Text(
                                      "9 min ago",
                                      style: TextStyle(fontSize: 10),
                                    ), // Last message time
                                    Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: chatMsgNotifyColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Text(
                                          "2",
                                          style: TextStyle(fontSize: 12),
                                        )), //
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                Divider(),
              ],
            );
          }
        }

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

        return const SizedBox();
      },
    );
  }
}
