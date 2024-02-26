// import 'package:chat_app_flutter/constants/utils/colors.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../bottomNavigationBar/bottom_navigation_bar_widget.dart';
// import '../../bloc/personal_chat_bloc.dart';

// class UserProfileCardForGroupChatAdditionWidget extends StatefulWidget {
//   final String receiverId;
//   final String senderId;
//   const UserProfileCardForGroupChatAdditionWidget({
//     super.key,
//     required this.receiverId,
//     required this.senderId,
//   });

//   @override
//   State<UserProfileCardForGroupChatAdditionWidget> createState() =>
//       _UserProfileCardForGroupChatAdditionWidgetState();
// }

// class _UserProfileCardForGroupChatAdditionWidgetState
//     extends State<UserProfileCardForGroupChatAdditionWidget> {
//   List<String> addUsersToGroupList = [];
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance
//           .collection("users")
//           .doc(widget.receiverId)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text(
//             "Unknown",
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 10,
//             ),
//           );
//         }
//         if (snapshot.hasData) {
//           final data = snapshot.data;
//           final userData = data?.data();
//           return BlocConsumer<PersonalChatBloc, PersonalChatState>(
//             builder: (context, state) {
//               return Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 20),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: 30,
//                             width: 30,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(50.0),
//                                 child: Image.network(userData?['imagePath'])),
//                           ),
//                           const SizedBox(width: 15),
//                           Text(
//                             userData?['username'],
//                             maxLines: 1,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if (addUsersToGroupList.contains(userData?['uid'])) {
//                         addUsersToGroupList.remove(userData?['uid']);
//                       } else {
//                         addUsersToGroupList.add(userData?['uid']);
//                       }
//                       setState(() {});
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 8, horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: primaryFairColor,
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Text(
//                         addUsersToGroupList.contains(userData?['uid'])
//                             ? "Added"
//                             : "Add User",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: whiteColor,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             },
//             listener: (context, state) {
//               if (state is StartChatSuccessfulLoadedState) {
//                 Navigator.pushReplacement(context, MaterialPageRoute(
//                   builder: (context) {
//                     return BottomNavigationBarWidget(
//                       userId: widget.senderId,
//                     );
//                   },
//                 ));
//               }
//               if (state is StartChatErrorState) {
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     content: Text("Error, There is some issue.")));
//               }
//             },
//           );
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }
