import 'package:cutit_new/api/dio_client.dart';
import 'package:cutit_new/api/dio_error_util_login.dart';
import 'package:cutit_new/api/service/login_api.dart';
import 'package:cutit_new/constant/common_method.dart';
import 'package:cutit_new/constant/common_variable.dart';
import 'package:cutit_new/constant/device_utils.dart';
import 'package:cutit_new/localization/application_localizations.dart';
import 'package:cutit_new/resource/color_styles.dart';
import 'package:cutit_new/resource/text_style.dart';
import 'package:cutit_new/route/constant_route.dart';
import 'package:cutit_new/widget/common_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPasswordPage> {
  // TextEditionController
  TextEditingController _userPassController = TextEditingController();
  TextEditingController _userConPassController = TextEditingController();
  // focus node
  late FocusNode _passwordFocusNode;
  late FocusNode _conPasswordFocusNode;
  // String variable
  String _passwordError = "";
  String _confirmPasswordError = "";
  // boolean variable
  bool _passwordValid = false;
  bool _confrimPasswordValid = false;
  bool _showPassword = true;
  bool _showConPassword = true;

  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _conPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userPassController.dispose();
    _userConPassController.dispose();
    _passwordFocusNode.dispose();
    _conPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommonMethod.setHeightWidth(context);
    CommonMethod.setStatusColor();
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
                  .translate('title.reset')
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
                          padding: const EdgeInsets.only(
                            left: 50,
                            right: 50,
                            top: 20
                          ),
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
                                  .translate('des.reset')
                                  .toString()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: CommonWidget.CommonText(
                              ApplicationLocalizations.of(context)!
                                  .translate('label.password')
                                  .toString()),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: TextFormField(
                              obscureText: _showPassword,
                              controller: _userPassController,
                              focusNode: _passwordFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_conPasswordFocusNode);
                              },
                              onChanged: (value) {
                                onChangeListenerPassword();
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  // Added this
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 0),
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
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        togglePasswordView();
                                      },
                                      child: Icon(
                                        (_showPassword)
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 20,
                                        color: CommonMethod.fromHex(
                                            ColorStyles.btnColor),
                                      )),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorStyles.redSee),
                                  ),
                                  errorStyle: CommonTextStyle.TextErrorStyle,
                                  errorMaxLines: 2,
                                  errorText: (_passwordValid)
                                      ? ApplicationLocalizations.of(context)!
                                          .translate(_passwordError)
                                      : null,
                                  labelStyle:
                                      CommonTextStyle.TextRegisterInputStyle,
                                  hintStyle:
                                      CommonTextStyle.TextRegisterInputStyle,
                                  hintText: ""),
                            )),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: CommonWidget.CommonText(
                              ApplicationLocalizations.of(context)!
                                  .translate('label.confrim_password')
                                  .toString()),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: TextFormField(
                              obscureText: _showConPassword,
                              controller: _userConPassController,
                              focusNode: _conPasswordFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                DeviceUtils.hideKeyboard(context);
                              },
                              onChanged: (value) {
                                onChangeListenerConfirm();
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  // Added this
                                  contentPadding:
                                      EdgeInsets.only(top: 10, bottom: 0),
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
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        toggleConPasswordView();
                                      },
                                      child: Icon(
                                        (_showConPassword)
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 20,
                                        color: CommonMethod.fromHex(
                                            ColorStyles.btnColor),
                                      )),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorStyles.redSee),
                                  ),
                                  errorMaxLines: 2,
                                  errorText: (_confrimPasswordValid)
                                      ? ApplicationLocalizations.of(context)!
                                          .translate(_confirmPasswordError)
                                      : null,
                                  errorStyle: CommonTextStyle.TextErrorStyle,
                                  labelStyle:
                                      CommonTextStyle.TextRegisterInputStyle,
                                  hintStyle:
                                      CommonTextStyle.TextRegisterInputStyle,
                                  hintText: ""),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 80, right: 80),
                            padding: const EdgeInsets.all(12),
                            child: CommonWidget.CommonButtonMessage(ApplicationLocalizations.of(context)!
                                .translate('common.submit')
                                .toString(),resetPassword))
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
  // password hide and show
  void togglePasswordView() {
    _showPassword = !_showPassword;
    if (this.mounted) {
      setState(() {});
    }
  }
  // confirm password hide and show
  void toggleConPasswordView() {
    _showConPassword = !_showConPassword;
    if (this.mounted) {
      setState(() {});
    }
  }
  // password validation when text change
  void onChangeListenerPassword() {
    _passwordValid = false;
    if (_userPassController.text.isEmpty) {
      _passwordValid = true;
      _passwordError = "error.password_empty";
    } else if (_userPassController.text.length < 6) {
      _passwordValid = true;
      _passwordError = "error.password_valid";
    } else {
      _passwordValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }
  // Confirm password validation when text change
  void onChangeListenerConfirm() {
    _confrimPasswordValid = false;
    if (_userConPassController.text.isEmpty) {
      _confrimPasswordValid = true;
      _confirmPasswordError = "error.confirm_password_empty";
    } else if (_userConPassController.text != _userPassController.text) {
      _confrimPasswordValid = true;
      _confirmPasswordError = "error.confirm_password_valid";
    } else {
      _confrimPasswordValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }
  // isValidate after click btn
  bool isValidate(){
    bool valid =true;
    if (_userPassController.text.isEmpty) {
      _passwordValid = true;
      valid = false;
      _passwordError = "error.password_empty";
    } else if (_userPassController.text.length < 6) {
      _passwordValid = true;
      valid = false;
      _passwordError = "error.password_valid";
    } else {
      _passwordValid = false;
    }
    if (_userConPassController.text.isEmpty) {
      _confrimPasswordValid = true;
      valid = false;
      _confirmPasswordError = "error.confirm_password_empty";
    } else if (_userConPassController.text != _userPassController.text) {
      _confrimPasswordValid = true;
      valid = false;
      _confirmPasswordError = "error.confirm_password_valid";
    } else {
      _confrimPasswordValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
    return valid;
  }
  // call reset Password api.
  void resetPassword() async{
    if (isValidate()) {
      DeviceUtils.hideKeyboard(context);
      Dio dio = new Dio();
          DioClient dioClient = new DioClient(dio);
          new LoginApi(dioClient)
              .resetPasssword(context, _userPassController.text,_userConPassController.text)
              .then((value) {
            if (value != null) {
              if (value.response == 200) {
                CommonMethod.commonMessageError(value.message.toString());
                  navigateLoginPage(context);
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
  // navigate to login screen
  void navigateLoginPage(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        loginRoute, (Route<dynamic> route) => false);
  }
}
