import 'dart:io';
import 'package:cutit_new/api/dio_error_util_login.dart';
import 'package:cutit_new/api/response_model/registraction_response.dart';
import 'package:cutit_new/api/service/login_api.dart';
import 'package:cutit_new/api/dio_client.dart';
import 'package:cutit_new/constant/common_method.dart';
import 'package:cutit_new/constant/common_variable.dart';
import 'package:cutit_new/constant/device_utils.dart';
import 'package:cutit_new/localization/application_localizations.dart';
import 'package:cutit_new/model/google_facebook_model.dart';
import 'package:cutit_new/model/verify_model.dart';
import 'package:cutit_new/resource/color_styles.dart';
import 'package:cutit_new/resource/text_style.dart';
import 'package:cutit_new/route/constant_route.dart';
import 'package:cutit_new/shared_pref/shared_preference_helper.dart';
import 'package:cutit_new/widget/common_widget.dart';
import 'package:cutit_new/widget/empty_app_bar_widget.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditionController
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // focus node
  late FocusNode _passwordFocusNode;
  // String variable
  String _usernameError = "";
  String _passwordError = "";
  // boolean variable
  bool _showPassword = true;
  bool _usernameValid = false;
  bool _passwordValid = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    getToken();
  }

  void _togglePasswordView() {
    _showPassword = !_showPassword;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonMethod.setHeightWidth(context);
    CommonMethod.setStatusColor();
    double _height = CommonMethod.HEIGHT;
    double _width = CommonMethod.WIDTH;
    return new WillPopScope(
        onWillPop: _onBackPressed,
        child: Stack(children: [
          Container(
            height: _height,
            width: _width,
            decoration:
            BoxDecoration(
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.black.withOpacity(0.6),
                    BlendMode.hardLight),
                image: AssetImage(
                  CommonVariable.LOGIN_BACKGROUND,
                ),
              ),
            ),
          ),

          Scaffold(
              primary: true,
              backgroundColor: Colors.transparent,
              appBar: EmptyAppBar(),
              body: SafeArea(
                child: new GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: new ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(40),
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                          CommonVariable.LOGIN_LOGO,
                          height: _height * 0.2,
                          width: _width * 0.2,
                          fit: BoxFit.contain,
                        ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: new RichText(
                            text: new TextSpan(children: <TextSpan>[
                              new TextSpan(
                                text: ApplicationLocalizations.of(context)!
                                    .translate('label.login'),
                                style: CommonTextStyle.TextStyleUnderline,
                              )
                            ]),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                              child: TextFormField(
                            controller: _userEmailController,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            onChanged: (value) {
                              onChangeListenerUsername();
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                // Added this
                                contentPadding: EdgeInsets.only(
                                    left: 14, right: 14, top: 14, bottom: 14),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorStyles.redSee),
                                ),
                                errorMaxLines: 2,
                                errorText: (_usernameValid)
                                    ? ApplicationLocalizations.of(context)!
                                        .translate(_usernameError.toString())
                                    : null,
                                errorStyle: CommonTextStyle.TextErrorStyle,
                                labelStyle: CommonTextStyle.TextInputStyle,
                                hintStyle: CommonTextStyle.TextInputStyle,
                                hintText: ApplicationLocalizations.of(context)!
                                    .translate('plasceHolder.username_hint')
                                    .toString()),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                          child: TextFormField(
                        obscureText: _showPassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        onChanged: (value) {
                          onChangeListenerPassword();
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                          isDense: true,
                          // Added this
                          contentPadding: EdgeInsets.only(
                              left: 14, right: 14, top: 14, bottom: 14),

                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorStyles.redSee),
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                _togglePasswordView();
                              },
                              child: Icon(
                                (_showPassword)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 24,
                                color:
                                    CommonMethod.fromHex(ColorStyles.btnColor),
                              )),
                          errorMaxLines: 2,
                          errorText: (_passwordValid)
                              ? ApplicationLocalizations.of(context)!
                                  .translate(_passwordError.toString())
                              : null,
                          errorStyle: CommonTextStyle.TextErrorStyle,
                          labelStyle: CommonTextStyle.TextInputStyle,
                          hintStyle: CommonTextStyle.TextInputStyle,
                          hintText: ApplicationLocalizations.of(context)!
                              .translate('plasceHolder.password_hint'),
                        ),
                      )),
                      Container(
                          margin: EdgeInsets.only(left: 50, right: 50),
                          padding:  EdgeInsets.all(_width*0.05),
                          child: CommonWidget.CommonButtonMessage(ApplicationLocalizations.of(context)!
                              .translate('button.login')
                              .toString(),login)),
                      Container(
                          alignment: Alignment.center,
                          child: new RichText(
                            text: new TextSpan(children: <TextSpan>[
                              new TextSpan(
                                text: ApplicationLocalizations.of(context)!
                                    .translate('label.forgot_password'),
                                style: CommonTextStyle.TextForgotStyle,
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    navigateForgotPasseword(context);
                                  },
                              ),
                            ]),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: _width*0.05,
                      ),
                      Container(
                        height: 1,
                        color: CommonMethod.fromHex(ColorStyles.horizontalLine),
                      ),
                      SizedBox(
                        height: _width*0.05,
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: new RichText(
                            text: new TextSpan(children: <TextSpan>[
                              new TextSpan(
                                text: ApplicationLocalizations.of(context)!
                                    .translate('label.create_account'),
                                style: CommonTextStyle.TextStyleUnderline,
                              )
                            ]),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: _width*0.05,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: _width * 0.11,
                              height: _width * 0.11,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(CommonVariable.IC_MAIL),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            onTap: () {
                              navigateRegisterNormalPage();
                            },
                          ),
                          SizedBox(
                            width: _height * 0.015,
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              width: _width * 0.11,
                              height: _width * 0.11,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CommonMethod.fromHex(
                                    ColorStyles.googleColor),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage(CommonVariable.IC_GOOGLE),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                          SizedBox(
                            width: _height * 0.015,
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              width: _width * 0.11,
                              height: _width * 0.11,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CommonMethod.fromHex(
                                    ColorStyles.facebookColor),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(CommonVariable.IC_FB),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                          (Platform.isIOS)
                              ? SizedBox(
                                  width: _height * 0.015,
                                )
                              : new Container(
                                  height: 0,
                                ),
                          (Platform.isIOS)
                              ? GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(10),
                                    width: _width * 0.11,
                                    height: _width * 0.11,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorStyles.white),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                CommonVariable.IC_APPLE_ICON),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  onTap: () {

                                  },
                                )
                              : new Container(
                                  height: 0,
                                ),
                        ],
                      ),

                    ],
                  ),
                ),
              ))
        ]));
  }
  // handle back press in hardware in device
  Future<bool> _onBackPressed() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return true;
  }
  // call login api with validation
  void login() async {
    if (isValidate()) {
      DeviceUtils.hideKeyboard(context);
      Dio dio = new Dio();
      DioClient dioClient = new DioClient(dio);
      new LoginApi(dioClient)
          .login(context, "0", _userEmailController.text,
              _passwordController.text, "")
          .then((value) {
        if (value != null) {
          if (value.response == 200) {
            if (value.data!.isEmailVerified == "1") {
              if (value.data!.deactivateBy != "1") {
                navigateHomePage(context, value, "0");
              } else {
                CommonMethod.commonMessageError(value.message.toString());
              }
            } else {
              CommonMethod.commonMessageError(value.message.toString());
              navigateOtpPage(context, value);
            }
          } else if (value.response == 201) {
            CommonMethod.commonMessageError(value.message.toString());
          } else {
            CommonMethod.commonMessageError(value.message.toString());
          }
        }
      }).catchError((e) {
        if (DioErrorUtilLogin.handleError(e, context) != "") {
          CommonMethod.commonMessageError(
              DioErrorUtilLogin.handleError(e, context));
        }
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  // move to register screen
  void navigateRegisterNormalPage() {
    DeviceUtils.hideKeyboard(context);
    GoogleFacebookModel googleFacebookModel =
        new GoogleFacebookModel("", "", "", "", "0");
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context)
          .pushNamed(registerRoute, arguments: googleFacebookModel);
    });
  }
  // navigate otp page
  void navigateOtpPage(
      BuildContext context, RegistractionResponse value) async {
    DeviceUtils.hideKeyboard(context);
    if (this.mounted) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      SharedPreferenceHelper _sharedPrefsHelper =
          SharedPreferenceHelper(_prefs);
      _sharedPrefsHelper.saveEmail(value.data!.emailId.toString());
      _sharedPrefsHelper.saveAccountType("0");
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context)
            .pushNamed(otpRoute, arguments: new VerifyModel("0", ""));
      });
    }
  }
  // navigate home page
  void navigateHomePage(BuildContext context, RegistractionResponse value,
      String accountType) async {
    DeviceUtils.hideKeyboard(context);
    if (this.mounted) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      SharedPreferenceHelper _sharedPrefsHelper =
          SharedPreferenceHelper(_prefs);
      _sharedPrefsHelper.saveIsLoggedIn(true);
      _sharedPrefsHelper.saveAccessToken(value.data!.accessToken.toString());
      _sharedPrefsHelper.saveEmail(value.data!.emailId.toString());
      _sharedPrefsHelper
          .saveProfileCompleted(value.data!.profileCompleted.toString());
      _sharedPrefsHelper.saveAbout(value.data!.about.toString());
      _sharedPrefsHelper.saveDOB(value.data!.dateOfBirth.toString());
      _sharedPrefsHelper.saveIsActive(value.data!.isActive.toString());
      _sharedPrefsHelper.saveUserName(value.data!.username.toString());
      _sharedPrefsHelper.saveName(value.data!.name.toString());
      _sharedPrefsHelper.saveUserID(value.data!.userId.toString());
      _sharedPrefsHelper.saveMobileNumber(value.data!.mobileNumber.toString());
      _sharedPrefsHelper.saveImage(value.data!.userImage.toString());
      _sharedPrefsHelper.saveAccountType(accountType.toString());
      _sharedPrefsHelper
          .saveEmailVerified(value.data!.isEmailVerified.toString());
      CommonVariable.isLogin=true;
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            homeRoute, (Route<dynamic> route) => false);
      });
    }
  }
  // navigate Forget password page
  void navigateForgotPasseword(BuildContext context) {
    DeviceUtils.hideKeyboard(context);
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamed(forgetPasswordRoute);
    });
  }
  // isValidate after click btn
  bool isValidate() {
    bool valid = true;
    if (_userEmailController.text.isEmpty) {
      _usernameValid = true;
      _usernameError = "error.username_email_empty";
      valid = false;
    } else {
      _usernameValid = false;
    }
    if (_passwordController.text.isEmpty) {
      _passwordValid = true;
      _passwordError = "error.password_empty";
      valid = false;
    } else {
      _passwordValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
    return valid;
  }
  // password validation when text change
  void onChangeListenerPassword() {
    _passwordValid = false;
    if (_passwordController.text.isEmpty) {
      _passwordValid = true;
      _passwordError = "error.password_empty";
    } else {
      _passwordValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }
  // username validation when text change
  void onChangeListenerUsername() {
    _usernameValid = false;
    if (_userEmailController.text.isEmpty) {
      _usernameValid = true;
      _usernameError = "error.username_email_empty";
    } else {
      _usernameValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }
  // get token from firebase
  void getToken() {
    FirebaseMessaging.instance
        .getToken(
        vapidKey:
        CommonVariable.VapidKey)
        .then((value) => {
      if (value != null)
        {
          CommonVariable.FirebaseToken = value.toString()
        }
    })
        .catchError((onError) {});
  }
}
