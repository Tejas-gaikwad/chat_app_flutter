import 'package:chat_app_flutter/constants/app_bar_header_widget.dart';
import 'package:chat_app_flutter/constants/widgets/chat_inital_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/utils/colors.dart';
import '../bloc/personal_chat_bloc.dart';
import 'widgets/all_users_listing_widget.dart';

class PersonalChatsListingScreen extends StatefulWidget {
  final String userId;
  final Function()? onTap;
  const PersonalChatsListingScreen({
    super.key,
    required this.userId,
    this.onTap,
  });

  @override
  State<PersonalChatsListingScreen> createState() =>
      _PersonalChatsListingScreenState();
}

class _PersonalChatsListingScreenState
    extends State<PersonalChatsListingScreen> {
  @override
  void initState() {
    super.initState();

    context
        .read<PersonalChatBloc>()
        .add(GetAllUsersChatsEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PersonalChatBloc, PersonalChatState>(
          builder: (context, state) {
            if (state is PersonalChatsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            if (state is PersonalChatsSuccessfulLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarHeaderWidget(
                      headerTitle: "Messages",
                      userId: widget.userId,
                      onProfileTap: widget.onTap,
                    ),
                    searchWidget(),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 6,
                      child: AllUsersListingWidget(
                        senderId: widget.userId,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Chats",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.chatsUsersList.length,
                        itemBuilder: (context, index) {
                          return state.chatsUsersList.isEmpty
                              ? Center(
                                  child: Text(
                                    "No Chats Available",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                )
                              : ChatInitialProfileWidget(
                                  currentUserId: widget.userId,
                                  chatRoomId: state.chatsUsersList[index],
                                  type: 'personal',
                                );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is PersonalChatsErrorState) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: primaryColor, size: 50),
                    Text(
                      "Error",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          },
          listener: (context, state) {
            if (state is PersonalChatsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "Error While Fetching chats",
                style: Theme.of(context).textTheme.bodyText2,
              )));
            }
          },
        ),
      ),
    );
  }

  // Widget headerWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         const Text(
  //           "Messages",
  //           style: TextStyle(
  //             fontWeight: FontWeight.w700,
  //             fontSize: 28,
  //           ),
  //         ),
  //         InkWell(
  //             onTap: widget.onTap,
  //             child: ProfileImageWidget(userId: widget.userId)),
  //       ],
  //     ),
  //   );
  // }

  Widget searchWidget() {
    return Container();
  }
}
