import 'package:chat_app_flutter/constants/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bottomNavigationBar/bottom_navigation_bar_widget.dart';
import '../../bloc/personal_chat_bloc.dart';

class UserProfileListingWidget extends StatelessWidget {
  final String receiverId;
  final String senderId;
  const UserProfileListingWidget({
    super.key,
    required this.receiverId,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection("users").doc(receiverId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Unknown",
            style: Theme.of(context).textTheme.bodyText2,
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data;
          final userData = data?.data();
          return BlocConsumer<PersonalChatBloc, PersonalChatState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Wrap(
                          direction: Axis.vertical,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              "Add in Chats",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              userData?['username'],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(height: 15),
                            InkWell(
                              onTap: () {
                                context
                                    .read<PersonalChatBloc>()
                                    .add(StartChatWithUserEvent(
                                      senderId: senderId,
                                      receiverId: receiverId,
                                    ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.green,
                                ),
                                child: (state is StartChatLoadingState)
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.white,
                                        )),
                                      )
                                    : Text(
                                        "Add to Chat",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              userData?['imagePath'] ??
                                  "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
                            )),
                      ),
                      Text(
                        userData?['username'],
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              );
            },
            listener: (context, state) {
              if (state is StartChatSuccessfulLoadedState) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return BottomNavigationBarWidget(
                      userId: senderId,
                    );
                  },
                ));
              }
              if (state is StartChatErrorState) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "Error, There is some issue.",
                  style: Theme.of(context).textTheme.bodyText2,
                )));
              }

              if (state is StartChatLoadingState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: whiteColor,
                      ),
                    );
                  },
                );
              }
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
