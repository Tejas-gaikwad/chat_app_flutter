import 'package:chat_app_flutter/constants/widgets/chat_inital_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_bar_header_widget.dart';
import '../../../constants/utils/colors.dart';
import '../../personalChats/bloc/personal_chat_bloc.dart';
import 'widgets/create_group_widget.dart';

class GroupChatScreen extends StatefulWidget {
  final String userId;
  final Function()? onTap;
  const GroupChatScreen({super.key, required this.userId, this.onTap});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
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
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return BlocProvider<PersonalChatBloc>(
                create: (context) =>
                    PersonalChatBloc(PersonalChatsInitialState()),
                child: CreateGroupWidget(
                  currentUserId: widget.userId,
                ),
              );
            },
          ));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryFairColor,
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const SizedBox(width: 10),
              const Icon(
                Icons.add,
                color: whiteColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                "Create Group",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
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
              return Column(
                children: [
                  AppBarHeaderWidget(
                    headerTitle: "Groups",
                    userId: widget.userId,
                    onProfileTap: widget.onTap,
                  ),
                  searchWidget(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.chatsUsersList.length,
                    itemBuilder: (context, index) {
                      return ChatInitialProfileWidget(
                        chatRoomId: state.chatsUsersList[index],
                        type: 'group',
                        currentUserId: widget.userId,
                      );
                    },
                  ),
                ],
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

  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Groups",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: primaryFairColor, width: 3.0),
            ),
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: Image.network(
                "https://i.pinimg.com/736x/c4/a6/ad/c4a6ad3a4bdcd5a8d5425f2afa2f81c6.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchWidget() {
    return Container();
  }
}
