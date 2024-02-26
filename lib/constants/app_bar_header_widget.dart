import 'package:flutter/material.dart';
import '../features/personalChats/view/widgets/profile_image_widget.dart';

class AppBarHeaderWidget extends StatelessWidget {
  final String userId;
  final String headerTitle;

  final Function()? onProfileTap;
  const AppBarHeaderWidget({
    super.key,
    required this.userId,
    this.onProfileTap,
    required this.headerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          InkWell(
            onTap: onProfileTap,
            child: ProfileImageWidget(userId: userId),
          ),
        ],
      ),
    );
  }
}
