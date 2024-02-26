import 'package:flutter/material.dart';

import '../../../../constants/utils/colors.dart';

class DarkModeWidget extends StatefulWidget {
  const DarkModeWidget({super.key});

  @override
  State<DarkModeWidget> createState() => _DarkModeWidgetState();
}

class _DarkModeWidgetState extends State<DarkModeWidget> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                darkMode = false;
              });
            },
            child: Icon(
              Icons.sunny,
              color: darkMode ? greyColor : primaryFairColor,
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: () {
              setState(() {
                darkMode = true;
              });
            },
            child: Icon(
              Icons.dark_mode,
              color: !darkMode ? greyColor : primaryFairColor,
            ),
          ),
        ],
      ),
    );
  }
}
