import 'package:cutit_new/resource/color_styles.dart';
import 'package:cutit_new/route/constant_route.dart';
import 'package:cutit_new/shared_pref/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common_variable.dart';

class CommonMethod {
  static double HEIGHT = 0.0;
  static double WIDTH = 0.0;

  static DateFormat format = DateFormat("dd-MM-yyyy");
  static GlobalKey<NavigatorState> NAVIGATOR_KEY = GlobalKey<NavigatorState>();
  static String regexPrice1 = '^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)';

  static RegExp patterPrice = new RegExp(regexPrice1);
  // Hex to Color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // set device height and width
  static setHeightWidth(BuildContext context) {
    HEIGHT = MediaQuery.of(context).size.height;
    WIDTH = MediaQuery.of(context).size.width;
  }
  // get gloable context
  static BuildContext? getContext() {
    return NAVIGATOR_KEY.currentContext;
  }
  // set gloable context
  static setContext() {
    NAVIGATOR_KEY = GlobalKey<NavigatorState>();
  }
  // Move login after
  static goToLoginScreen(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);
    _sharedPrefsHelper.saveIsLoggedIn(false);
    _sharedPrefsHelper.saveAccessToken("");
    _sharedPrefsHelper.saveEmail("");
    _sharedPrefsHelper.saveProfileCompleted("");
    _sharedPrefsHelper.saveAbout("");
    _sharedPrefsHelper.saveDOB("");
    _sharedPrefsHelper.saveIsActive("");
    _sharedPrefsHelper.saveUserName("");
    _sharedPrefsHelper.saveName("");
    _sharedPrefsHelper.saveUserID("");
    _sharedPrefsHelper.saveMobileNumber("");
    _sharedPrefsHelper.saveImage("");
    CommonVariable.isLogin = false;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(loginRoute, (Route<dynamic> route) => false);
  }
  // Show Toast Message
  static commonMessageError(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  // Show status bar.
  static void setStatusColor() async {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
      //This line is used for showing the bottom bar
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorStyles.orange[500],
    ));
  }


}
