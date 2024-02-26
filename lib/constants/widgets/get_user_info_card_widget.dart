import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/chatRoom/bloc/chat_room_bloc.dart';
import '../../features/chatRoom/view/personal_chat_room.dart';
import '../utils/colors.dart';

class GetUserInfoCardWidget extends StatelessWidget {
  final String uid;
  final String type;
  final String chatRoomId;
  final String currentUserId;
  final String? lastMessageNotReadByUserId;
  final DateTime? lastMessageSentAt;

  const GetUserInfoCardWidget({
    super.key,
    required this.uid,
    required this.type,
    required this.chatRoomId,
    required this.currentUserId,
    this.lastMessageNotReadByUserId,
    this.lastMessageSentAt,
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
                        profile: userData?["imagePath"] ??
                            "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
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
                        userData?["imagePath"] ??
                            "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
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
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
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
