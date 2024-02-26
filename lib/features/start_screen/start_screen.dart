import 'package:chat_app_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/bottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:chat_app_flutter/features/splash_screen/views/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_data_model.dart';
import '../../services/shared_prefs.dart';

class StartCheckScreen extends StatefulWidget {
  const StartCheckScreen({super.key});

  @override
  State<StartCheckScreen> createState() => _StartCheckScreenState();
}

class _StartCheckScreenState extends State<StartCheckScreen> {
  bool isLoggedIn = false;
  late UserDataModel userData;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    getUserData();
  }

  //   Future<bool> isLoggedIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   isLoggedInStatus = prefs.getBool('isLoggedIn') ?? false;

  //   print("isLoggedInStatus   ->>>>>>>>    ${isLoggedInStatus}");
  //   return isLoggedInStatus;
  // }

  Future<void> _checkLoginStatus() async {
    final userLoginStatus = await SharedPreferencesService.getUserLoginStatus();
    setState(() {
      isLoggedIn = userLoginStatus;
    });

    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    print("userLoginStatus  ------------      ${userLoginStatus}");
    print(" user?.uid  ------------      ${user?.uid}");

    if (isLoggedIn == true) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BottomNavigationBarWidget(userId: user?.uid ?? "");
          },
        ),
        (route) => false,
      );
      await SharedPreferencesService.setUserLoginStatus(status: true);
    } else {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (context) => AuthBloc(AuthInitialState()),
          child: const SplashScreen(),
        );
      }));
    }
  }

  Future<void> getUserData() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      userData = UserDataModel(
        username: user?.displayName ?? '',
        email: user?.email ?? '',
        imagePath: user?.photoURL ?? '',
        uid: user?.uid ?? '',
      );
    } catch (e) {
      print("Splash screen getUserData Error -->>    $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
