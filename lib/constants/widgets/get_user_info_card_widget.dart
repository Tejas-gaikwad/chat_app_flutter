import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/chatRoom/bloc/chat_room_bloc.dart';
import '../../features/chatRoom/view/personal_chat_room.dart';

class GetUserInfoCardWidget extends StatelessWidget {
  final String uid;
  final String type;
  final String chatRoomId;
  final String currentUserId;

  const GetUserInfoCardWidget({
    super.key,
    required this.uid,
    required this.type,
    required this.chatRoomId,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("users").doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          final userData = data?.data();

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => ChatRoomBloc(ChatRoomInitialState()),
                      child: PersonalChatRoomScreen(
                        otherProfileId: userData?['uid'],
                        profile: userData?["imagePath"],
                        username: userData?["username"],
                        chatRoomId: chatRoomId,
                        currentUserId: currentUserId,
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
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      child: Image.network(
                        userData?["imagePath"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData?["username"],
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Column(
                  //     children: [
                  //       const Text(
                  //         "9 min ago",
                  //         style: TextStyle(fontSize: 10),
                  //       ), // Last message time
                  //       Container(
                  //           padding: const EdgeInsets.all(6),
                  //           decoration: const BoxDecoration(
                  //             color: chatMsgNotifyColor,
                  //             shape: BoxShape.circle,
                  //           ),
                  //           child: const Text(
                  //             "2",
                  //             style: TextStyle(fontSize: 12),
                  //           )), //
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
