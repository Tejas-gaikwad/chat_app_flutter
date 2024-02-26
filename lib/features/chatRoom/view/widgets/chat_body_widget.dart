import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/utils/colors.dart';
import 'app_image_widget.dart';
import 'get_user_details_widget.dart';
import 'image_screen.dart';
import 'video_app_widget.dart';

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

          final imageUrl = chatData?['imageUrl'];
          final videoUrl = chatData?['videoUrl'];

          bool hasImage =
              chatData?['imageUrl'] != null && chatData?['imageUrl'].isNotEmpty;
          bool hasVideo =
              chatData?['videoUrl'] != null && chatData?['videoUrl'].isNotEmpty;

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
                            // if (hasImage)
                            //   InkWell(
                            //     onTap: () => Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => ImageScreen(
                            //                   imageUrl: imageUrl,
                            //                 ))),
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(8),
                            //       child: AppImageWidget(
                            //         imageHeight: 200,
                            //         imageWidth: double.maxFinite,
                            //         url: imageUrl,
                            //         imageFit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            // if (hasVideo)
                            //   InkWell(
                            //     onTap: () => Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => VideoApp(
                            //                   url: videoUrl,
                            //                 ))),
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //           color: Colors.grey.shade900,
                            //           borderRadius: BorderRadius.circular(12)),
                            //       height: 150,
                            //       width: double.maxFinite,
                            //       child: const Icon(
                            //         Icons.play_arrow,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // if (hasImage || hasVideo)
                            //   const SizedBox(
                            //     height: 10,
                            //   ),
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
