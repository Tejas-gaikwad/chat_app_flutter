import 'package:chat_app_flutter/constants/utils/colors.dart';
import 'package:chat_app_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottomNavigationBar/bottom_navigation_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Login"),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 50),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Wrap(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: "Enter Email id",
                              hintStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                        ),
                        TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                              hintText: "Enter Password",
                              hintStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 50),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) async {
            if (state is LoginLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }

            if (state is LoginSuccessState) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', true);
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return BottomNavigationBarWidget(userId: state.userId);
                },
              ), (route) => false);
            }

            if (state is LoginErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Sign Up Error")));
            }
          },
        ),
      ),
    );
  }
}
