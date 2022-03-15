import 'package:cutit_new/api/dio_error_util_login.dart';
import 'package:cutit_new/api/response_model/registraction_response.dart';
import 'package:cutit_new/api/dio_client.dart';
import 'package:cutit_new/api/service/login_api.dart';
import 'package:cutit_new/constant/common_method.dart';
import 'package:cutit_new/constant/common_variable.dart';
import 'package:cutit_new/constant/device_utils.dart';
import 'package:cutit_new/localization/application_localizations.dart';
import 'package:cutit_new/model/verify_model.dart';
import 'package:cutit_new/resource/color_styles.dart';
import 'package:cutit_new/resource/text_style.dart';
import 'package:cutit_new/route/constant_route.dart';
import 'package:cutit_new/shared_pref/shared_preference_helper.dart';
import 'package:cutit_new/widget/common_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // TextEditionController
  TextEditingController _otpController = TextEditingController();
  //  _type
  //  0 for registration
  //  1 for forget password
  String _type = "",_email = "",_otpError="";
  // bool variable
  bool _flagTimer = true;
  bool _resendOtpEnable = false;
  bool _otpValid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillData();
    resendEnable();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _otpController.dispose();
    super.dispose();
  }

  // ui method
  @override
  Widget build(BuildContext context) {
    CommonMethod.setHeightWidth(context);
    CommonMethod.setStatusColor();
    double _height = CommonMethod.HEIGHT;
    double _width = CommonMethod.WIDTH;
    if (_flagTimer) {
      _flagTimer = false;
    }
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: ColorStyles.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
              ApplicationLocalizations.of(context)!
                  .translate('title.otp')
                  .toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: CommonTextStyle.TextStyleTitle),
          leading: IconButton(
            icon: Image.asset(
              CommonVariable.IC_BACK_BROWN,
              height: CommonVariable.BACK_ARROW_SIZE,
              width: CommonVariable.BACK_ARROW_SIZE,
              fit: BoxFit.contain,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: new GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Stack(
                children: [
                  Container(
                    height: _height,
                    width: _width,
                    child: new ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: Image.asset(
                            CommonVariable.APP_LIGHT_LOGO,
                            height: _height * 0.2,
                            width: _width * 0.2,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          child: CommonWidget.CommonTextMessage(
                              ApplicationLocalizations.of(context)!
                                  .translate('des.otp')
                                  .toString()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 50,
                              right: 50,
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _otpController,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                DeviceUtils.hideKeyboard(context);
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                              onChanged: (value) {
                                changeOTP();
                              },
                              maxLength: 6,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  isDense: true,
                                  counterText: "",
                                  // Added this
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CommonMethod.fromHex(
                                            ColorStyles.inputBottomUnderline)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CommonMethod.fromHex(
                                            ColorStyles.inputBottomUnderline)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CommonMethod.fromHex(
                                            ColorStyles.inputBottomUnderline)),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorStyles.redSee),
                                  ),
                                  errorMaxLines: 2,
                                  errorText: (_otpValid)
                                      ? ApplicationLocalizations.of(context)!
                                          .translate(_otpError)
                                          .toString()
                                      : null,
                                  errorStyle: CommonTextStyle.TextErrorStyle,
                                  labelStyle:
                                      CommonTextStyle.TextRegisterInputStyle,
                                  hintStyle:
                                      CommonTextStyle.TextRegisterInputStyle,
                                  hintText: "Enter OTP"),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 80, right: 80),
                            padding: const EdgeInsets.all(12),
                            child: CommonWidget.CommonButtonMessage(ApplicationLocalizations.of(context)!
                                .translate('common.submit')
                                .toString(),verifyOtp)),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                            ),
                            alignment: Alignment.center,
                            child: new RichText(
                              text: new TextSpan(children: <TextSpan>[
                                new TextSpan(
                                  text: ApplicationLocalizations.of(context)!
                                      .translate('label.get_code')
                                      .toString(),
                                  style: CommonTextStyle.TextForgotStyle,
                                ),
                                new TextSpan(
                                  text: ApplicationLocalizations.of(context)!
                                      .translate('label.resend_code')
                                      .toString(),
                                  style: (_resendOtpEnable)
                                      ? CommonTextStyle.TextResetStyle
                                      : CommonTextStyle.TextForgotStyle,
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (_resendOtpEnable) {
                                        resendEnable();
                                        resendOtp();
                                      }
                                    },
                                ),
                              ]),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
  // navigate to screen.
  Widget navigate(BuildContext context) {
    if (this.mounted) {
      if (_type == CommonVariable.REGISTER_TYPE) {
        Future.delayed(Duration(milliseconds: 0), () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              homeRoute, (Route<dynamic> route) => false);
        });
      } else if (_type == CommonVariable.FORGOT_TYPE) {
        Future.delayed(Duration(milliseconds: 0), () {
          Navigator.of(context).pushReplacementNamed(resetPasswordRoute);
        });
      }
    }

    return Container();
  }
  // validate form
  bool isValidate() {
    bool valid = true;
    if (_otpController.text.isEmpty) {
      valid = false;
      _otpValid = true;
      _otpError = "error.otp";
    } else if (_otpController.text.length != 6) {
      valid = false;
      _otpValid = true;
      _otpError = "error.otp_length";
    } else {
      _otpValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
    return valid;
  }
  // otp validation during changes
  void changeOTP() {
    if (_otpController.text.isEmpty) {
      _otpValid = true;
      _otpError = "error.otp";
    } else if (_otpController.text.length != 6) {
      _otpValid = true;
      _otpError = "error.otp_length";
    } else {
      _otpValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }
  // get data other screen
  void fillData() {
    Future.delayed(Duration(milliseconds: 100), () {
      VerifyModel verifyModel =
          ModalRoute.of(context)!.settings.arguments as VerifyModel;
      _type = verifyModel.type;
      _email = verifyModel.email;
    });
  }
  // verifing otp
  void verifyOtp() async {
    if (isValidate()) {
      DeviceUtils.hideKeyboard(context);
        Dio dio = new Dio();
        DioClient dioClient = new DioClient(dio);
        new LoginApi(dioClient)
            .otp(context, _otpController.text, _type)
            .then((value) {
          if (value != null) {
            if (value.response == 200) {
              if (_type == "0") {
                CommonMethod.commonMessageError(value.message.toString());
                navigateHomePage(context, value);
              } else if (_type == "1") {
                CommonMethod.commonMessageError(value.message.toString());
                navigateResetPage(context);
              }
            } else if (value.response == 201) {
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
  // navigate Home screen
  void navigateHomePage(
      BuildContext context, RegistractionResponse value) async {
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
      _sharedPrefsHelper.saveReferalCode(value.data!.referralCode.toString());
      _sharedPrefsHelper.saveImage(value.data!.userImage.toString());
      _sharedPrefsHelper
          .saveEmailVerified(value.data!.isEmailVerified.toString());
      CommonVariable.isLogin=true;
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            homeRoute, (Route<dynamic> route) => false);
      });
    }
  }
  // resend text enable after 30 seconds
  void resendEnable() {
    _resendOtpEnable = false;
    Future.delayed(Duration(seconds: 30), () {
      if (this.mounted) {
        _resendOtpEnable = true;
        setState(() {});
      }
    });
  }
  // resend OTP
  void resendOtp() async {
    DeviceUtils.hideKeyboard(context);
      Dio dio = new Dio();
      DioClient dioClient = new DioClient(dio);
      new LoginApi(dioClient).resendOtp(context).then((value) {
        if (value != null) {
          if (value.response == 200) {
            CommonMethod.commonMessageError(value.message.toString());
          } else if (value.response == 201) {
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
  // navigate reset page
  void navigateResetPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushReplacementNamed(resetPasswordRoute);
    });
  }
}
