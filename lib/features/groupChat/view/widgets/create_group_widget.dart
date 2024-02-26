import 'package:chat_app_flutter/constants/utils/colors.dart';
import 'package:chat_app_flutter/features/bottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:chat_app_flutter/features/personalChats/bloc/personal_chat_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupWidget extends StatefulWidget {
  final String currentUserId;
  const CreateGroupWidget({super.key, required this.currentUserId});

  @override
  State<CreateGroupWidget> createState() => _CreateGroupWidgetState();
}

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  late TextEditingController groupNameController;

  @override
  void initState() {
    super.initState();
    groupNameController = TextEditingController();
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
        title: Text(
          "Create Group",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      body: BlocConsumer<PersonalChatBloc, PersonalChatState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Group Name",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    TextField(
                      controller: groupNameController,
                      decoration: const InputDecoration(
                        hintText: "Enter Group Name",
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Add Group Members",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    userMembersAddingListWidget(),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        addUsersToGroupList.add(widget.currentUserId);

                        context.read<PersonalChatBloc>().add(
                              CreateGroupEvent(
                                groupName: groupNameController.text,
                                groupUsersList: addUsersToGroupList,
                              ),
                            );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                            color: primaryFairColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          "Create group",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is CreateGroupChatLoadingState) {
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

          if (state is CreateGroupChatErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "Error While Creating Group",
              style: Theme.of(context).textTheme.bodyText2,
            )));
          }

          if (state is CreateGroupChatSuccessfulLoadedState) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return BottomNavigationBarWidget(
                  userId: widget.currentUserId,
                );
              },
            ), (route) => false);
          }
        },
      ),
    );
  }

  Widget userMembersAddingListWidget() {
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
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: allUserIdList.length,
          itemBuilder: (context, index) {
            return allUserIdList[index] == widget.currentUserId
                ? const SizedBox()
                : BlocProvider<PersonalChatBloc>(
                    create: (context) =>
                        PersonalChatBloc(PersonalChatsInitialState()),
                    child: listingOfUsers(
                      receiverId: allUserIdList[index],
                    ),
                  );
          },
        );
      },
    );
  }

  List<String> addUsersToGroupList = [];

  Widget listingOfUsers({required String receiverId}) {
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
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
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
                          const SizedBox(width: 15),
                          Text(
                            userData?['username'],
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (addUsersToGroupList.contains(userData?['uid'])) {
                        addUsersToGroupList.remove(userData?['uid']);
                      } else {
                        addUsersToGroupList.add(userData?['uid']);
                      }
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: primaryFairColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        addUsersToGroupList.contains(userData?['uid'])
                            ? "Added"
                            : "Add User",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  )
                ],
              );
            },
            listener: (context, state) {},
          );
        }
        return const SizedBox();
      },
    );
  }
}
