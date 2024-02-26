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
    return InkWell(
      onTap: () {
        // context.read<ThemeBloc>().add(ToggleThemeEvent());

        setState(() {
          darkMode = !darkMode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.sunny,
              color: darkMode ? greyColor : primaryFairColor,
            ),
            const SizedBox(width: 15),
            Icon(
              Icons.dark_mode,
              color: !darkMode ? greyColor : primaryFairColor,
            ),
          ],
        ),
      ),
    );
  }
}
