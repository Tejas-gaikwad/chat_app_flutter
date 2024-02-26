import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/utils/colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/views/register_view.dart';
import '../../bottomNavigationBar/bottom_navigation_bar_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Stack(
              children: [
                Image.asset(
                  "assets/chat_splash_image-2.png",
                  fit: BoxFit.fitWidth,
                ),
                splashIntroductionWidget(context),
              ],
            ),
          );
        },
        listener: (context, state) async {
          if (state is GoogleLoginErrorState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Error While Google Login"),
              ),
            );
          }
          if (state is GoogleLoginLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          if (state is GoogleLoginSuccessState) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);
            // if (!mounted) return;
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BottomNavigationBarWidget(
                    userId: state.userId,
                  );
                },
              ),
              (route) => false,
            );
          }
        },
      )),
    );
  }

  Widget splashIntroductionWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.8,
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Chat with friends & meet new ones",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Text(
              "Your bew facourite app to chat with friends & meet new ones",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RegisterNow();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: primaryColor,
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO add google logo here

                    Text(
                      "Register Now",
                      style: TextStyle(color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.read<AuthBloc>().add(GoogleLoginEvent());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: googleLoginButtonColor,
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO add google logo here

                    Text(
                      "Sign in with Google",
                      style: TextStyle(color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
