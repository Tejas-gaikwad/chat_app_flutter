import 'package:chat_app_flutter/constants/widgets/chat_inital_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/utils/colors.dart';
import '../bloc/personal_chat_bloc.dart';

class PersonalChatsListingScreen extends StatefulWidget {
  final String userId;
  const PersonalChatsListingScreen({
    super.key,
    required this.userId,
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
              return Column(
                children: [
                  headerWidget(),
                  searchWidget(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.chatsUsersList.length,
                    itemBuilder: (context, index) {
                      return ChatInitialProfileWidget(
                        currentUserId: widget.userId,
                        chatRoomId: state.chatsUsersList[index],
                        type: 'personal',
                      );
                    },
                  ),
                ],
              );
            }

            if (state is PersonalChatsErrorState) {
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: primaryColor, size: 50),
                    Text(
                      "Error",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Error While Fetching chats")));
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
            "Messages",
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
