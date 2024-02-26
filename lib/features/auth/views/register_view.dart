import 'package:chat_app_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/bottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:chat_app_flutter/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/textfield_constant.dart';
import '../../../constants/utils/colors.dart';

class RegisterNow extends StatefulWidget {
  const RegisterNow({super.key});
  @override
  State<RegisterNow> createState() => _RegisterNowState();
}

class _RegisterNowState extends State<RegisterNow> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController mobileNumberController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Register".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Wrap(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: registerForm(),
                        ),
                        InkWell(
                          onTap: () {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              context.read<AuthBloc>().add(
                                    SignUpEvent(
                                      user: UserDataModel(
                                        email: emailController.text,
                                        username: fullNameController.text,
                                      ),
                                      password: passwordController.text,
                                    ),
                                  );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) async {
          if (state is SignUpLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }

          if (state is SignUpSuccessState) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);
            if (!mounted) return;
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return BottomNavigationBarWidget(userId: state.userId);
              },
            ), (route) => false);
          }

          if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Sign Up Error")));
          }
        },
      )),
    );
  }

  Widget registerForm() {
    return Column(
      children: [
        textfieldWidget(
          hintText: "Full Name",
          controller: fullNameController,
        ),
        textfieldWidget(
          hintText: 'Email id',
          controller: emailController,
        ),
        textfieldWidget(
          hintText: "Mobile Number",
          controller: mobileNumberController,
          keyboardType: TextInputType.number,
        ),
        textfieldWidget(
          hintText: "Password",
          controller: passwordController,
          obscureText: !showPassword,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                showPassword = !(showPassword);
              });
            },
            child: Icon(
              !showPassword ? Icons.visibility : Icons.visibility_off,
              color: greyColor,
            ),
          ),
        ),
        textfieldWidget(
          hintText: "Confirm Password",
          controller: confirmPasswordController,
          obscureText: !showConfirmPassword,
          suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  showConfirmPassword = !(showConfirmPassword);
                });
              },
              child: Icon(
                !showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                color: greyColor,
              )),
        ),
      ],
    );
  }

  Widget textfieldWidget({
    required String hintText,
    required TextEditingController controller,
    bool? obscureText,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextfieldConstantWidget(
        textStyle: const TextStyle(
          fontSize: 12,
          color: primaryColor,
        ),
        hintText: hintText,
        controller: controller,
        hintStyle: const TextStyle(
          color: greyColor,
          fontSize: 12,
        ),
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        suffixIcon: suffixIcon ?? const SizedBox(),
      ),
    );
  }
}
