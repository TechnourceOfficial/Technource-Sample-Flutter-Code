import 'package:cutit_new/api/dio_client.dart';
import 'package:cutit_new/api/dio_error_util_login.dart';
import 'package:cutit_new/api/response_model/registraction_response.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  // TextEditionController
  TextEditingController _userEmailController = TextEditingController();
  // focus node
  late FocusNode _emailFocusNode;
  bool _emailValid = false;
  String _emailError = "";

  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userEmailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommonMethod.setStatusColor();
    CommonMethod.setHeightWidth(context);
    double _height = CommonMethod.HEIGHT;
    double _width = CommonMethod.WIDTH;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: ColorStyles.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
              ApplicationLocalizations.of(context)!
                  .translate('title.forget')
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        new Container(
                          padding:
                              const EdgeInsets.only(left: 50, right: 50, top: 20),
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
                            left: 40,
                            right: 40,
                          ),
                          child: CommonWidget.CommonTextMessage(
                              ApplicationLocalizations.of(context)!
                                  .translate('des.forget')
                                  .toString()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: CommonWidget.CommonText(
                              ApplicationLocalizations.of(context)!
                                  .translate('label.email')
                                  .toString()),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: TextFormField(
                            controller: _userEmailController,
                            focusNode: _emailFocusNode,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              DeviceUtils.hideKeyboard(context);
                            },
                            onChanged: (value) {
                              onChangeListenerEmail();
                            },
                            decoration: InputDecoration(
                                isDense: true,
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
                                errorText: (_emailValid)
                                    ? ApplicationLocalizations.of(context)!
                                        .translate(_emailError.toString())
                                    : null,
                                errorStyle: CommonTextStyle.TextErrorStyle,
                                labelStyle:
                                    CommonTextStyle.TextRegisterInputStyle,
                                hintStyle: CommonTextStyle.TextRegisterInputStyle,
                                hintText: ""),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 80, right: 80),
                            padding: const EdgeInsets.all(12),
                            child:CommonWidget.CommonButtonMessage(ApplicationLocalizations.of(context)!
                                .translate('common.submit')
                                .toString(),forgotPassword)),
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
                                      .translate('label.remember_password'),
                                  style: CommonTextStyle.TextForgotStyle,
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.of(context).pop();
                                    },
                                ),
                                new TextSpan(
                                  text: ApplicationLocalizations.of(context)!
                                      .translate('label.click_here'),
                                  style: CommonTextStyle.TextResetStyle,
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.of(context).pop();
                                    },
                                ),
                              ]),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
  // navigate to otp page
  void navigate(BuildContext context, RegistractionResponse response) async {
    if (this.mounted) {
      Future.delayed(Duration(milliseconds: 0), () async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        SharedPreferenceHelper _sharedPrefsHelper =
            SharedPreferenceHelper(_prefs);
        _sharedPrefsHelper.saveEmail(_userEmailController.text.trim());
        Navigator.of(context)
            .pushNamed(otpRoute, arguments: new VerifyModel("1",""));
      });
    }
  }
  // forget password with validation
  void forgotPassword() async {
    DeviceUtils.hideKeyboard(context);
    if (isValidate()) {
      Dio dio = new Dio();
      DioClient dioClient = new DioClient(dio);
      new LoginApi(dioClient)
          .forgorPassword(context, _userEmailController.text)
          .then((value) {
        if (value != null) {
          if (value.response == 200) {
            CommonMethod.commonMessageError(value.message.toString());
            navigate(context, value);
          } else if (value.response == 201) {
            CommonMethod.commonMessageError(value.message.toString());
          }
        }
      }).catchError((e) {
        if (DioErrorUtilLogin.handleError(e, context) != "") {
          CommonMethod.commonMessageError(DioErrorUtilLogin.handleError(e, context));
        }
      });
    }
  }
  // email validation during changes
  void onChangeListenerEmail() {
    _emailValid = false;
    if (_userEmailController.text.isEmpty) {
      _emailValid = true;
      _emailError = "error.email_empty";
    } else if (!isEmail(_userEmailController.text)) {
      _emailValid = true;
      _emailError = "error.email_valid";
    } else {
      _emailValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }
  // validate form
  bool isValidate() {
    bool valid = true;
    if (_userEmailController.text.isEmpty) {
      _emailValid = true;
      valid = false;
      _emailError = "error.email_empty";
    } else if (!isEmail(_userEmailController.text)) {
      _emailValid = true;
      valid = false;
      _emailError = "error.email_valid";
    } else {
      _emailValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
    return valid;
  }
}
