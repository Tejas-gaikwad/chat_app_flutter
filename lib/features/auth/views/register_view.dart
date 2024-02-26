import 'package:flutter/material.dart';
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
        child: Container(
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
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
                      Container(
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
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
