import 'package:chat_app_flutter/constants/utils/colors.dart';
import 'package:chat_app_flutter/features/personalChats/bloc/personal_chat_bloc.dart';
import 'package:chat_app_flutter/features/personalChats/view/personal_chat_listing_screen.dart';
import 'package:chat_app_flutter/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../groupChat/view/group_chat_screen.dart';
import '../profile/view/profile_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final String userId;
  const BottomNavigationBarWidget({super.key, required this.userId});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      BlocProvider(
          create: (context) => PersonalChatBloc(PersonalChatsInitialState()),
          child: PersonalChatsListingScreen(userId: widget.userId)),
      BlocProvider(
        create: (context) => PersonalChatBloc(PersonalChatsInitialState()),
        child: GroupChatScreen(userId: widget.userId),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(ProfileInitialState()),
        child: ProfileScreen(userId: widget.userId),
      ),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        selectedIconTheme: const IconThemeData(color: whiteColor, size: 30),
        unselectedIconTheme: const IconThemeData(color: greyColor, size: 24),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Personal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
