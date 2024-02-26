// import 'package:chat_app_flutter/features/profile/bloc/profile_bloc.dart';
// import 'package:chat_app_flutter/features/profile/view/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../constants/textfield_constant.dart';
// import '../../../constants/utils/colors.dart';
// import '../../../models/chat_message_model.dart';
// import '../bloc/chat_room_bloc.dart';

// class GroupChatRoomScreen extends StatefulWidget {
//   final String chatRoomId;
//   final String currentUserId;
//   final String otherProfileId;
//   const GroupChatRoomScreen({
//     super.key,
//     required this.chatRoomId,
//     required this.currentUserId,
//     required this.otherProfileId,
//   });

//   @override
//   State<GroupChatRoomScreen> createState() => _GroupChatRoomScreenState();
// }

// class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
//   late TextEditingController messageController;
//   @override
//   void initState() {
//     super.initState();
//     messageController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             profileHeader(context),
//             Expanded(
//               child: ListView.builder(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return Row(
//                     mainAxisAlignment: (index == 2 ||
//                             index == 3 ||
//                             index == 6 ||
//                             index == 8 ||
//                             index == 12)
//                         ? MainAxisAlignment.start
//                         : MainAxisAlignment.end,
//                     children: [
//                       const SizedBox(width: 10),
//                       Align(
//                         alignment: (index == 2 ||
//                                 index == 3 ||
//                                 index == 6 ||
//                                 index == 8 ||
//                                 index == 12)
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(vertical: 6),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: const Radius.circular(16.0),
//                               bottomLeft: (index == 2 ||
//                                       index == 3 ||
//                                       index == 6 ||
//                                       index == 8 ||
//                                       index == 12)
//                                   ? const Radius.circular(0.0)
//                                   : const Radius.circular(16.0),
//                               bottomRight: (index == 2 ||
//                                       index == 3 ||
//                                       index == 6 ||
//                                       index == 8 ||
//                                       index == 12)
//                                   ? const Radius.circular(16.0)
//                                   : const Radius.circular(0.0),
//                               topRight: const Radius.circular(16.0),
//                             ),
//                             color: (index == 2 ||
//                                     index == 3 ||
//                                     index == 6 ||
//                                     index == 8 ||
//                                     index == 12)
//                                 ? primaryColor
//                                 : greyColor,
//                           ),
//                           child: Text(
//                             "chat message",
//                             style: TextStyle(
//                               color: (index == 2 ||
//                                       index == 3 ||
//                                       index == 6 ||
//                                       index == 8 ||
//                                       index == 12)
//                                   ? whiteColor
//                                   : blackColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 12),
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: greyColor.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(14.0),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextfieldConstantWidget(
//                             controller: messageController,
//                             hintText: 'Type your Message here...',
//                             hintStyle: const TextStyle(
//                               color: greyColor,
//                               fontSize: 16,
//                             ),
//                             textStyle: const TextStyle(
//                               color: blackColor,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         const Icon(Icons.attach_file)
//                       ],
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     context
//                         .read<ChatRoomBloc>()
//                         .add(SendMessageInPersonalChatEvent(
//                           chatMessageModel: ChatMessages(
//                             idFrom: widget.currentUserId,
//                             idTo: widget.otherProfileId,
//                             timestamp: DateTime.now(),
//                             content: messageController.text,
//                             type: "personal",
//                           ),
//                           chatRoomId: widget.chatRoomId,
//                         ));
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                       color: primaryFairColor,
//                     ),
//                     child: const Icon(Icons.send),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget profileHeader(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return BlocProvider(
//               create: (context) => ProfileBloc(ProfileInitialState()),
//               child: ProfileScreen(
//                 userId: '',
//               ),
//             );
//           },
//         ));
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Container(
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                     border: Border.all(color: primaryFairColor, width: 3.0),
//                   ),
//                   height: 50,
//                   width: 50,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//                     child: Image.network(
//                       "https://i.pinimg.com/736x/c4/a6/ad/c4a6ad3a4bdcd5a8d5425f2afa2f81c6.jpg",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Group Name",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                       Text(
//                         "15 Members",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:chat_app_flutter/features/profile/bloc/profile_bloc.dart';
import 'package:chat_app_flutter/features/profile/view/profile_screen.dart';
import 'package:chat_app_flutter/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/textfield_constant.dart';
import '../../../constants/utils/colors.dart';
import '../bloc/chat_room_bloc.dart';
import 'widgets/messages_listing_widget.dart';

class GroupChatRoomScreen extends StatefulWidget {
  final String chatRoomId;
  final String? username;
  final String? currentUserId;
  final String? profile;
  // final String groupChatRoomId;

  const GroupChatRoomScreen({
    super.key,
    required this.chatRoomId,
    this.username,
    this.profile,
    // required this.groupChatRoomId,
    this.currentUserId,
  });

  @override
  State<GroupChatRoomScreen> createState() => _GroupChatRoomScreenState();
}

class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
  late TextEditingController messageController;
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    // context
    //     .read<ChatRoomBloc>()
    //     .add(GetAllMessagesOfChatRoomEvent(chatRoomId: widget.chatRoomId));
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            profileHeader(context),
            Expanded(
              child: BlocProvider<ChatRoomBloc>(
                create: (context) => ChatRoomBloc(ChatRoomInitialState()),
                child: MessagesListingWidget(
                  isGroup: true,
                  chatRoomId: widget.chatRoomId,
                  currentUserId: widget.currentUserId ?? "",
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: greyColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextfieldConstantWidget(
                            controller: messageController,
                            hintText: 'Type your Message here...',
                            hintStyle: const TextStyle(
                              color: greyColor,
                              fontSize: 16,
                            ),
                            textStyle: const TextStyle(
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Icon(Icons.attach_file)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<ChatRoomBloc>()
                        .add(SendMessageInPersonalChatEvent(
                          chatMessageModel: ChatMessages(
                            idFrom: widget.currentUserId ?? '',
                            // idTo: widget.groupChatRoomId,
                            timestamp: DateTime.now(),

                            content: messageController.text,
                            type: "group",
                          ),
                          chatRoomId: widget.chatRoomId,
                        ));

                    messageController.clear();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: primaryFairColor,
                    ),
                    child: const Icon(Icons.send),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget profileHeader(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => ProfileBloc(ProfileInitialState()),
              child: ProfileScreen(
                otherUserProfileCheck: true,
                userId: widget.chatRoomId,
              ),
            );
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: primaryFairColor, width: 3.0),
                  ),
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    child: Icon(
                        Icons.group), // TODO add a logic to show a group image
                    // Image.network(
                    //   widget.profile,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username ?? "Unknown",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "Online",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
