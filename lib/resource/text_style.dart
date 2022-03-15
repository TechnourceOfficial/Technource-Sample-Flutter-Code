import 'package:cutit_new/constant/common_method.dart';
import 'package:flutter/material.dart';

import 'color_styles.dart';

class CommonTextStyle extends TextStyle {
  //Login screen
  static TextStyle TextInputStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: CommonMethod.fromHex(ColorStyles.txtHindColor),
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle TextErrorStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.redSee,
      height: 1.0,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle TextRegisterInputStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: CommonMethod.fromHex(ColorStyles.txtHindColor),
      height: 1.0,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat'); //walk through screen
  static TextStyle BtnTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.white,
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangePhotoTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: CommonMethod.fromHex(ColorStyles.blueLabel),
      height: 1.0,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
  static TextStyle changeChangePhotoTextBlackStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeCenterTextBlackStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeBigTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize:20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeBigSubTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize:22,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeBigCenterTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.checkInDaysTextColor,
      height: 1.0,
      fontSize:20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeSpecialityTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize:18,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeSpecialityNoTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize:18,
      fontWeight: FontWeight.bold,);
  static TextStyle changeChangeHelpNoStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.checkInDaysTextColor,
      height: 1.0,
      fontSize:20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');

  static TextStyle changeChangeSmallTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.checkInDaysTextColor,
      height: 1.0,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeSmallCancelTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.checkInDaysTextColor,
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeExpriesTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.checkInDaysTextColor,
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeSmallBlackTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeSmallCancelBlackTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.engineerBlack,
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeSmallDateTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: ColorStyles.checkInDaysTextColor,
      height: 1.0,
      fontSize: 10,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle changeChangeCommentTextStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: CommonMethod.fromHex(ColorStyles.btnColor),
      height: 1.0,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle TextForgotStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: CommonMethod.fromHex(ColorStyles.txtForgotColor),
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle TextResetStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: CommonMethod.fromHex(ColorStyles.btnColor),
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');
  static TextStyle TextTermsStyle = new TextStyle(
      decoration: TextDecoration.none,
      color: CommonMethod.fromHex(ColorStyles.btnColor),
      height: 1.0,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
  static TextStyle TextStyleUnderline = new TextStyle(
      decoration: TextDecoration.underline,
      color: ColorStyles.white,
      height: 1.0,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');

  static TextStyle TextStyleTitle = new TextStyle(
      color: CommonMethod.fromHex(ColorStyles.btnColor),
      fontSize: 20,
      fontWeight: FontWeight.bold,);
  static TextStyle TextStyleHomeTitle = new TextStyle(
      color: ColorStyles.engineerBlack,
      fontSize: 24,
      fontWeight: FontWeight.bold,
  );
  static TextStyle CircleTextStyle = new TextStyle(
      color: CommonMethod.fromHex(ColorStyles.circularTextbackground),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
  static TextStyle PrivacyPolicyTextStyle = new TextStyle(
      color: ColorStyles.mineShaft,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Akrobat');

  static TextStyle TextStyleDialogTitle = new TextStyle(
      color: ColorStyles.engineerBlack,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
  static TextStyle TextStyleDialogRemoveConfirm = new TextStyle(
      color: CommonMethod.fromHex(ColorStyles.btnColor),
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
  static TextStyle TextStyleDialogRemoveCancle = new TextStyle(
      color: CommonMethod.fromHex(ColorStyles.btnColor),
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Akrobat');
}
