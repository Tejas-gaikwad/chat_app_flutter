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
          context: context,
          optionName: "Edit Profile",
          iconWidget: const Icon(
            Icons.edit,
            color: primaryFairColor,
            size: 20,
          ),
        ),
        option(
          context: context,
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
    required BuildContext context,
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
                style: Theme.of(context).textTheme.bodyText2,
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
