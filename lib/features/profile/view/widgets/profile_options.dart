import 'package:flutter/material.dart';

import '../../../../constants/utils/colors.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        option(
          optionName: "Edit Profile",
          iconWidget: const Icon(
            Icons.edit,
            color: primaryFairColor,
            size: 20,
          ),
        ),
        option(
          optionName: "Notifications",
          iconWidget: const Icon(
            Icons.notifications,
            color: primaryFairColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget option({
    required String optionName,
    required Widget iconWidget,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconWidget,
              const SizedBox(width: 15),
              Text(
                optionName,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const RotatedBox(
              quarterTurns: 2,
              child: Icon(
                Icons.arrow_back_ios,
                color: greyColor,
                size: 20,
              ))
        ],
      ),
    );
  }
}
