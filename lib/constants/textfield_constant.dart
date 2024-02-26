import 'package:flutter/material.dart';

class TextfieldConstantWidget extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  const TextfieldConstantWidget({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.textStyle,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: textStyle,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        // contentPadding: EdgeInsets.all(0.0),
        hintText: hintText,
        hintStyle: hintStyle,
        suffixIcon: suffixIcon ?? const SizedBox(),
      ),
    );
  }
}
