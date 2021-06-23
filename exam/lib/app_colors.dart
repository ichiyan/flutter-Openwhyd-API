import 'package:flutter/material.dart';

class AppColors {
  static const mainColor = Color(0XF1c1c1c); //black
  static const mainAccentColor = Colors.tealAccent;
  static const styleColor = Colors.white38;
  static const lightShadow = Color(0xF404040); //lighter shade of black

  //login/register/welcome
  static const Color kBgColor = Color(0xFFFEDCE0);
  static const Color kTextColor = Color(0xFF3D0007);
  // static const Color kBtnColorStart = Color(0xFF20bf55);
  // static const Color kBtnColorEnd = Color(0xFF01baef);
  static const Color kBtnColorStart = Color(0xFF96e4df);
  static const Color kBtnColorEnd = Color(0xFF4dccc6);
  static const Color kBtnShadowColor = Color(0x77eed8);

  static const Color kInputBorderColor = Color(0xFFECECEC);

  static const LinearGradient kBtnLinearGradient = LinearGradient(colors: [
    kBtnColorStart,
    kBtnColorEnd,
  ]);
}
