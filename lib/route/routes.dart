import 'package:cutit_new/route/constant_route.dart';
import 'package:cutit_new/ui/forgot_password/forget_page.dart';
import 'package:cutit_new/ui/home/home_page.dart';
import 'package:cutit_new/ui/login/login_page.dart';
import 'package:cutit_new/ui/otp/otp_page.dart';
import 'package:cutit_new/ui/register/register_page.dart';
import 'package:cutit_new/ui/reset_password/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return PageTransition(
          child: HomePage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 500),
          reverseDuration: Duration(milliseconds: 500),
        );
      case loginRoute:
        return PageTransition(
          child: LoginPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 500),
          reverseDuration: Duration(milliseconds: 500),
        );
      case registerRoute:
        return PageTransition(
          child: RegisterPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        );
      case forgetPasswordRoute:
        return PageTransition(
          child: ForgetPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        );
      case otpRoute:
        return PageTransition(
          child: OtpPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        );
      case resetPasswordRoute:
        return PageTransition(
          child: ResetPasswordPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        );
      default:
        return PageTransition(
          child: LoginPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        );
    }
  }
}
