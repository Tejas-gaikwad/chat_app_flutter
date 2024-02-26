import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/personal_chat_bloc.dart';
import 'user_profile_card_widget.dart';

class AllUsersListingWidget extends StatelessWidget {
  final String senderId;
  const AllUsersListingWidget({super.key, required this.senderId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("users").get(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        final allUsers = data?.docs;

        List<String> allUserIdList = [];

        allUsers?.forEach((element) {
          allUserIdList.add(element.id);
        });

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: allUserIdList.length,
          itemBuilder: (context, index) {
            return allUserIdList[index] == senderId
                ? const SizedBox()
                : BlocProvider<PersonalChatBloc>(
                    create: (context) =>
                        PersonalChatBloc(PersonalChatsInitialState()),
                    child: UserProfileListingWidget(
                      senderId: senderId,
                      receiverId: allUserIdList[index],
                    ),
                  );
          },
        );
      },
    );
  }
}
