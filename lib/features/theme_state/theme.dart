import 'package:chat_app_flutter/constants/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  colorScheme: const ColorScheme.light(
    background: whiteColor,
    primary: primaryColor,
    secondary: blackColor,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: const ColorScheme.dark(
    background: primaryColor,
    primary: primaryFairColor,
    secondary: whiteColor,
  ),
);
