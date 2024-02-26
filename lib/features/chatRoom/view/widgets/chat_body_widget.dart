import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/utils/colors.dart';
import 'get_user_details_widget.dart';

class ChatBodyWidget extends StatelessWidget {
  final String chatRoomId;
  final String chatId;
  final String currentUserId;
  final bool isGroup;

  const ChatBodyWidget({
    super.key,
    required this.chatRoomId,
    required this.chatId,
    required this.currentUserId,
    this.isGroup = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("chats")
          .doc(chatId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          final chatData = data?.data();
          final receiverId = chatData?['idTo'];
          final senderId = chatData?['idFrom'];
          final time = chatData?['timestamp'];
          final messageData = chatData?['content'];

          DateTime dateTime = time.toDate();

          return Row(
            mainAxisAlignment: (currentUserId == senderId)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              (currentUserId == senderId)
                  ? const SizedBox(width: 50)
                  : const SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: (currentUserId == receiverId)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16.0),
                        bottomLeft: (currentUserId != senderId)
                            ? const Radius.circular(0.0)
                            : const Radius.circular(16.0),
                        bottomRight: (currentUserId == senderId)
                            ? const Radius.circular(0.0)
                            : const Radius.circular(16.0),
                        topRight: const Radius.circular(16.0),
                      ),
                      color: (currentUserId == senderId)
                          ? primaryFairColor
                          : greyColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        isGroup
                            ? Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GetUserDataWidget(
                                      senderUserId: senderId,
                                      currentUserId: currentUserId,
                                      nameColor: senderId == currentUserId
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Row(
                          mainAxisAlignment: (currentUserId == senderId)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                messageData,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: (currentUserId == senderId)
                                      ? whiteColor
                                      : blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            DateFormat("HH:mm a").format(dateTime),
                            style: TextStyle(
                              fontSize: 10,
                              color: (currentUserId == senderId)
                                  ? whiteColor
                                  : blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              (currentUserId != senderId)
                  ? const SizedBox(width: 50)
                  : const SizedBox(width: 10),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
