import 'package:chat_app_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app_flutter/features/splash_screen/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/utils/colors.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<AuthBloc>().add(LogoutEvent());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: redColor)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (state is LogoutLoadingState)
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: whiteColor,
                          ),
                        ))
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: redColor,
                            size: 20,
                          ),
                          SizedBox(width: 15),
                          Text(
                            "LogOut",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is LogoutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error while Logging out")));
        }
        if (state is LogoutSuccessState) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => AuthBloc(AuthInitialState()),
                child: const SplashScreen(),
              );
            },
          ), (route) => false);
        }
      },
    );
  }
}
