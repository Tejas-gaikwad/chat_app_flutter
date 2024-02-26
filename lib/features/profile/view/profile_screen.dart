import 'package:chat_app_flutter/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/utils/colors.dart';
import '../../../services/shared_prefs.dart';
import '../../auth/bloc/auth_bloc.dart';
import 'widgets/dark_mode_widget.dart';
import 'widgets/logout_button_widget.dart';
import 'widgets/profile_options.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  final bool otherUserProfileCheck;

  const ProfileScreen({
    super.key,
    required this.userId,
    this.otherUserProfileCheck = false,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    print("widget.userId  ->>>>   ${widget.userId}");
    context
        .read<ProfileBloc>()
        .add(GetProfileInformationEvent(userId: widget.userId));
  }

  Future<String> getUserId() async {
    final userId = await SharedPreferencesService.getUserId();
    return userId ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is GetProfileSuccessfulState) {
            return Container(
              color: blackColor,
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 3.1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: coverImageWidget(context)),
                        Positioned(
                            left: 2,
                            top: 20,
                            child: Container(
                                width: size.width,
                                child: backButtonWithProfileText())),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: profilePictureWidget(
                            context: context,
                            imageUrl: state.userInformation.imagePath,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  informationWidget(
                    context: context,
                    personEmailId: state.userInformation.email,
                    personName: state.userInformation.username,
                  ),
                  const SizedBox(height: 20),
                  widget.otherUserProfileCheck
                      ? const SizedBox()
                      : const Expanded(child: ProfileOptions()),
                  widget.otherUserProfileCheck
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: BlocProvider(
                            create: (context) => AuthBloc(AuthInitialState()),
                            child: const LogOutButton(),
                          ),
                        ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {},
      )),
    );
  }

  Widget informationWidget({
    required BuildContext context,
    required String personName,
    required String personEmailId,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(height: MediaQuery.of(context).size.height / 2.6),
          Text(
            personName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: whiteColor,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            personEmailId,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget profilePictureWidget({
    required BuildContext context,
    required String imageUrl,
  }) {
    return Container(
      width: MediaQuery.of(context).size.height / 6,
      height: MediaQuery.of(context).size.height / 6,
      decoration: const BoxDecoration(
        color: whiteColor,
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(250.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget coverImageWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      child: Image.network(
        "https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget backButtonWithProfileText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Profile",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: whiteColor,
            ),
          ),
          widget.otherUserProfileCheck
              ? const SizedBox()
              : const DarkModeWidget(),
        ],
      ),
    );
  }
}
