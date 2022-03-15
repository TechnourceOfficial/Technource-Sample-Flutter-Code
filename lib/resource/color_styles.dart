import 'package:cutit_new/constant/common_method.dart';
import 'package:flutter/material.dart';

abstract class ColorStyles {
  static const Color white = Color(0xFFFFFFFF);

  static const Color checkInDaysTextColor = Color.fromARGB(153, 61, 61, 61);

  static const Color engineerBlack = Color(0xFF1F1F1F);
  static const Color mineShaft = Color(0xFF333333);

  static const Color redSee = Color(0xFFF04343);
  static Color primaryColor = CommonMethod.fromHex("#b15859");

  static const String btnColor = "#b68559";
  static const String blueLabel = "#45a0e6";
  static const String txtHindColor = "#b7b7b7";
  static const String txtForgotColor = "#b7b7b7";
  static const String horizontalLine = "#6d6d6d";
  static const String facebookColor = "#0f0f8f";
  static const String googleColor = "#ffffff";
  static const String inputBottomUnderline = "#cecece";
  static const String circularImageBorder = "#262626";
  static const String circularImagebackground = "#dbdbdb";
  static const String circularTextbackground = "#9d9d9d";
  static const String privacyTextbackground = "#000000";

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFBB824F),
    100: const Color(0xFFBB824F),
    200: const Color(0xFFBB824F),
    300: const Color(0xFFBB824F),
    400: const Color(0xFFBB824F),
    500: const Color(0xFFBB824F),
    600: const Color(0xFFBB824F),
    700: const Color(0xFFBB824F),
    800: const Color(0xFFBB824F),
    900: const Color(0xFFBB824F)
  };
}
