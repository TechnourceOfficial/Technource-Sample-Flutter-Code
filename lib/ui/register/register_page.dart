import 'dart:io';
import 'package:cutit_new/api/dio_error_util_login.dart';
import 'package:cutit_new/api/response_model/registraction_response.dart';
import 'package:cutit_new/api/dio_client.dart';
import 'package:cutit_new/api/service/login_api.dart';
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
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'package:image_cropper/image_cropper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // TextEditionController
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userUserNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userDOBDayController = TextEditingController();
  TextEditingController _userDOBMonthController = TextEditingController();
  TextEditingController _userDOBYearController = TextEditingController();
  TextEditingController _userPassController = TextEditingController();
  TextEditingController _userConPassController = TextEditingController();
  TextEditingController _userReferalCodeController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  late FocusNode _usernameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _dobDayFocusNode;
  late FocusNode _dobMonthFocusNode;
  late FocusNode _dobYearFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _conPasswordFocusNode;
  late FocusNode _referalCodeFocusNode;

  // image file
  File? _imageFile;

  // image picker
  final ImagePicker _picker = ImagePicker();

  // String variable
  String _idSocial = "",
      _nameSocial = "",
      _imageSocial = "",
      _emailSocial = "",
      _accountType = "",
      _nameError = "",
      _usernameError = "",
      _emailError = "",
      _dobDayError = "",
      _dobMonthError = "",
      _dobYearError = "",
      _passwordError = "",
      _confirmPasswordError = "",
      _referalCodeError = "";

  // Boolean variable
  bool _showPassword = true,
      _showConPassword = true,
      _nameValid = false,
      _usernameValid = false,
      _emailValid = false,
      _dobDayValid = false,
      _dobMonthValid = false,
      _dobYearValid = false,
      _passwordValid = false,
      _confrimPasswordValid = false,
      _referalCodeValid = false,
      _enabled = true;

  // terms & privacy toggle
  int toggle = 0;
  var year = DateTime.now();
  var oldyear = DateTime.now();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _dobDayFocusNode = FocusNode();
    _dobMonthFocusNode = FocusNode();
    _dobYearFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _conPasswordFocusNode = FocusNode();
    _referalCodeFocusNode = FocusNode();
    fillData();
  }

  // show dialog image picker with camera and gallery
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: Image.asset(
                        CommonVariable.IC_GALLERY,
                        color: Colors.black,
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                      title: new Text(ApplicationLocalizations.of(context)!
                          .translate('common.gallery')
                          .toString()),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: Image.asset(
                      CommonVariable.IC_CAMERA,
                      color: Colors.black,
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                    title: new Text(ApplicationLocalizations.of(context)!
                        .translate('common.camera')
                        .toString()),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
                  .translate('title.register')
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
                          left: 40, right: 40, bottom: 20),
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        new Center(
                          child: GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: (_imageFile == null && _imageSocial == "")
                                ? Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    width: _height * 0.17,
                                    height: _height * 0.17,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CommonMethod.fromHex(ColorStyles
                                            .circularImagebackground),
                                        border: Border.all(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .circularImageBorder))),
                                    child: new Text(
                                      ApplicationLocalizations.of(context)!
                                          .translate('label.add_photo')
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: CommonTextStyle.CircleTextStyle,
                                    ))
                                : (_imageFile != null)
                                    ? new Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .circularImagebackground),
                                            border: Border.all(
                                                color: CommonMethod.fromHex(
                                                    ColorStyles
                                                        .circularImageBorder))),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(180),
                                          child: Image.file(
                                            _imageFile!,
                                            width: _height * 0.17,
                                            height: _height * 0.17,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        width: _height * 0.17,
                                        height: _height * 0.17,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .circularImagebackground),
                                            border: Border.all(
                                                color: CommonMethod.fromHex(
                                                    ColorStyles
                                                        .circularImageBorder))),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(180),
                                            child: Image.network(
                                              _imageSocial,
                                              width: _height * 0.17,
                                              height: _height * 0.17,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image(
                                                  height: _height * 0.17,
                                                  width: _height * 0.17,
                                                  fit: BoxFit.fitHeight,
                                                  image: AssetImage(
                                                    CommonVariable
                                                        .IC_USER_PROFIE,
                                                  ),
                                                );
                                              },
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: Center(
                                                      child: LoadingIndicator(
                                                    indicatorType: Indicator
                                                        .ballSpinFadeLoader,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.blueAccent
                                                    ],
                                                  )),
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CommonWidget.CommonText(
                            ApplicationLocalizations.of(context)!
                                .translate('label.name')
                                .toString()),
                        Container(
                            child: TextFormField(
                                controller: _userNameController,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_usernameFocusNode);
                                },
                                onChanged: (value) {
                                  onChangeListenerName();
                                },
                                inputFormatters: <TextInputFormatter>[
                                  new WhitelistingTextInputFormatter(
                                      RegExp("[a-zA-Z ']"))
                                ],
                                maxLength: 100,
                                decoration: InputDecoration(
                                    counterText: "",
                                    isDense: true,
                                    // Added this
                                    contentPadding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CommonMethod.fromHex(
                                              ColorStyles
                                                  .inputBottomUnderline)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CommonMethod.fromHex(
                                              ColorStyles
                                                  .inputBottomUnderline)),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CommonMethod.fromHex(
                                              ColorStyles
                                                  .inputBottomUnderline)),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ColorStyles.redSee),
                                    ),
                                    errorMaxLines: 2,
                                    errorText: (_nameValid)
                                        ? ApplicationLocalizations.of(context)!
                                            .translate(_nameError)
                                        : null,
                                    errorStyle: CommonTextStyle.TextErrorStyle,
                                    labelStyle:
                                        CommonTextStyle.TextRegisterInputStyle,
                                    hintStyle:
                                        CommonTextStyle.TextRegisterInputStyle,
                                    hintText: ""))),
                        SizedBox(
                          height: 14,
                        ),
                        CommonWidget.CommonText(
                            ApplicationLocalizations.of(context)!
                                .translate('label.username')
                                .toString()),
                        Container(
                            child: TextFormField(
                          controller: _userUserNameController,
                          focusNode: _usernameFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                          onChanged: (value) {
                            onChangeListenerUsername();
                          },
                          inputFormatters: <TextInputFormatter>[
                            new WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Z0-9']"))
                          ],
                          maxLength: 100,
                          decoration: InputDecoration(
                              counterText: "",
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
                              errorStyle: CommonTextStyle.TextErrorStyle,
                              errorText: (_usernameValid)
                                  ? ApplicationLocalizations.of(context)!
                                      .translate(_usernameError)
                                  : null,
                              labelStyle:
                                  CommonTextStyle.TextRegisterInputStyle,
                              hintStyle: CommonTextStyle.TextRegisterInputStyle,
                              hintText: ""),
                        )),
                        SizedBox(
                          height: 14,
                        ),
                        CommonWidget.CommonText(
                            ApplicationLocalizations.of(context)!
                                .translate('label.email')
                                .toString()),
                        Container(
                            child: TextFormField(
                          enabled: _enabled,
                          controller: _userEmailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_dobDayFocusNode);
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
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: CommonMethod.fromHex(
                                        ColorStyles.inputBottomUnderline)),
                              ),
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
                              errorStyle: CommonTextStyle.TextErrorStyle,
                              errorText: (_emailValid)
                                  ? ApplicationLocalizations.of(context)!
                                      .translate(_emailError)
                                  : null,
                              labelStyle:
                                  CommonTextStyle.TextRegisterInputStyle,
                              hintStyle: CommonTextStyle.TextRegisterInputStyle,
                              hintText: ""),
                        )),
                        SizedBox(
                          height: 14,
                        ),
                        CommonWidget.CommonText(
                            ApplicationLocalizations.of(context)!
                                .translate('label.dob')
                                .toString()),
                        SizedBox(
                          height: 14,
                        ),
                        IntrinsicHeight(
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: _userDOBDayController,
                                  focusNode: _dobDayFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_dobMonthFocusNode);
                                  },
                                  onChanged: (value) {
                                    onChangeListenerDOBDay();
                                    if (value.toString().length == 2) {
                                      FocusScope.of(context)
                                          .requestFocus(_dobMonthFocusNode);
                                    }
                                  },
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      isDense: true,
                                      // Added this
                                      contentPadding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorStyles.redSee),
                                      ),
                                      errorMaxLines: 2,
                                      errorStyle:
                                          CommonTextStyle.TextErrorStyle,
                                      errorText: (_dobDayValid)
                                          ? ApplicationLocalizations.of(
                                                  context)!
                                              .translate(_dobDayError)
                                          : null,
                                      labelStyle: CommonTextStyle
                                          .TextRegisterInputStyle,
                                      hintStyle: CommonTextStyle
                                          .TextRegisterInputStyle,
                                      hintText:
                                          ApplicationLocalizations.of(context)!
                                              .translate('plasceHolder.day')
                                              .toString()),
                                )),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: Container(
                                    child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: _userDOBMonthController,
                                  focusNode: _dobMonthFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_dobYearFocusNode);
                                  },
                                  onChanged: (value) {
                                    onChangeListenerDOBMonth();
                                    if (value.toString().length == 2) {
                                      FocusScope.of(context)
                                          .requestFocus(_dobYearFocusNode);
                                    }
                                  },
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      isDense: true,
                                      // Added this
                                      contentPadding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorStyles.redSee),
                                      ),
                                      errorMaxLines: 2,
                                      errorStyle:
                                          CommonTextStyle.TextErrorStyle,
                                      errorText: (_dobMonthValid)
                                          ? ApplicationLocalizations.of(
                                                  context)!
                                              .translate(_dobMonthError)
                                          : null,
                                      labelStyle: CommonTextStyle
                                          .TextRegisterInputStyle,
                                      hintStyle: CommonTextStyle
                                          .TextRegisterInputStyle,
                                      hintText:
                                          ApplicationLocalizations.of(context)!
                                              .translate('plasceHolder.month')
                                              .toString()),
                                )),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: Container(
                                    child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: _userDOBYearController,
                                  focusNode: _dobYearFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                  onChanged: (value) {
                                    onChangeListenerDOBYear();
                                    if (value.toString().length == 4) {
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocusNode);
                                    }
                                  },
                                  maxLength: 4,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      isDense: true,
                                      // Added this
                                      contentPadding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: CommonMethod.fromHex(
                                                ColorStyles
                                                    .inputBottomUnderline)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorStyles.redSee),
                                      ),
                                      errorMaxLines: 2,
                                      errorStyle:
                                          CommonTextStyle.TextErrorStyle,
                                      errorText: (_dobYearValid)
                                          ? ApplicationLocalizations.of(
                                                  context)!
                                              .translate(_dobYearError)
                                          : null,
                                      labelStyle: CommonTextStyle
                                          .TextRegisterInputStyle,
                                      hintStyle: CommonTextStyle
                                          .TextRegisterInputStyle,
                                      hintText:
                                          ApplicationLocalizations.of(context)!
                                              .translate('plasceHolder.year')
                                              .toString()),
                                )),
                              ),
                            ],
                          ),
                        ),
                        (_accountType != "1" &&
                                _accountType != "2" &&
                                _accountType != "3")
                            ? SizedBox(
                                height: 14,
                              )
                            : Container(
                                height: 0,
                              ),
                        (_accountType != "1" &&
                                _accountType != "2" &&
                                _accountType != "3")
                            ? CommonWidget.CommonText(
                                ApplicationLocalizations.of(context)!
                                    .translate('label.password')
                                    .toString())
                            : new Container(
                                height: 0,
                              ),
                        (_accountType != "1" &&
                                _accountType != "2" &&
                                _accountType != "3")
                            ? Container(
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
                                              ColorStyles
                                                  .inputBottomUnderline)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CommonMethod.fromHex(
                                              ColorStyles
                                                  .inputBottomUnderline)),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CommonMethod.fromHex(
                                              ColorStyles
                                                  .inputBottomUnderline)),
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
                                    errorMaxLines: 2,
                                    errorText: (_passwordValid)
                                        ? ApplicationLocalizations.of(context)!
                                            .translate(_passwordError)
                                        : null,
                                    errorStyle: CommonTextStyle.TextErrorStyle,
                                    labelStyle:
                                        CommonTextStyle.TextRegisterInputStyle,
                                    hintStyle:
                                        CommonTextStyle.TextRegisterInputStyle,
                                    hintText: ""),
                              ))
                            : Container(
                                height: 0,
                              ),
                        (_accountType != "1" &&
                                _accountType != "2" &&
                                _accountType != "3")
                            ? SizedBox(
                                height: 14,
                              )
                            : new Container(
                                height: 0,
                              ),
                        (_accountType != "1" &&
                                _accountType != "2" &&
                                _accountType != "3")
                            ? CommonWidget.CommonText(
                                ApplicationLocalizations.of(context)!
                                    .translate('label.confrim_password')
                                    .toString())
                            : Container(
                                height: 0,
                              ),
                        (_accountType != "1" &&
                                _accountType != "2" &&
                                _accountType != "3")
                            ? Container(
                                child: TextFormField(
                                obscureText: _showConPassword,
                                controller: _userConPassController,
                                focusNode: _conPasswordFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_referalCodeFocusNode);
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
                                              ColorStyles
                                                  .inputBottomUnderline)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CommonMethod.fromHex(
                                              ColorStyles
                                                  .inputBottomUnderline)),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CommonMethod.fromHex(
                                              ColorStyles
                                                  .inputBottomUnderline)),
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
                                    errorStyle: CommonTextStyle.TextErrorStyle,
                                    errorText: (_confrimPasswordValid)
                                        ? ApplicationLocalizations.of(context)!
                                            .translate(_confirmPasswordError)
                                        : null,
                                    labelStyle:
                                        CommonTextStyle.TextRegisterInputStyle,
                                    hintStyle:
                                        CommonTextStyle.TextRegisterInputStyle,
                                    hintText: ""),
                              ))
                            : Container(
                                height: 0,
                              ),
                        SizedBox(
                          height: 14,
                        ),
                        CommonWidget.CommonText(
                            ApplicationLocalizations.of(context)!
                                .translate('label.referal_code')
                                .toString()),
                        Container(
                            child: TextFormField(
                          controller: _userReferalCodeController,
                          focusNode: _referalCodeFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          onChanged: (value) {
                            onChangeListenerReferalCode();
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
                              errorStyle: CommonTextStyle.TextErrorStyle,
                              errorText: (_referalCodeValid)
                                  ? ApplicationLocalizations.of(context)!
                                      .translate(_referalCodeError)
                                  : null,
                              labelStyle:
                                  CommonTextStyle.TextRegisterInputStyle,
                              hintStyle: CommonTextStyle.TextRegisterInputStyle,
                              hintText: ""),
                        )),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: new RichText(
                                    text: new TextSpan(children: <TextSpan>[
                                  new TextSpan(
                                    text: ApplicationLocalizations.of(context)!
                                        .translate('label.accept'),
                                    style:
                                        CommonTextStyle.PrivacyPolicyTextStyle,
                                  ),
                                  new TextSpan(
                                    text: ApplicationLocalizations.of(context)!
                                        .translate('label.the'),
                                    style:
                                        CommonTextStyle.PrivacyPolicyTextStyle,
                                  ),
                                  new TextSpan(
                                    text: ApplicationLocalizations.of(context)!
                                        .translate('label.term_of_use'),
                                    style: CommonTextStyle.TextTermsStyle,
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                      },
                                  ),
                                  new TextSpan(
                                    text: ApplicationLocalizations.of(context)!
                                        .translate('label.and'),
                                    style:
                                        CommonTextStyle.PrivacyPolicyTextStyle,
                                  ),
                                  new TextSpan(
                                    text: ApplicationLocalizations.of(context)!
                                        .translate('label.the'),
                                    style:
                                        CommonTextStyle.PrivacyPolicyTextStyle,
                                  ),
                                  new TextSpan(
                                    text: ApplicationLocalizations.of(context)!
                                        .translate('label.privacy_policy'),
                                    style: CommonTextStyle.TextTermsStyle,
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                      },
                                  ),
                                ])),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: () {
                                    changeToggle();
                                  },
                                  child: Image.asset(
                                    (toggle == 1)
                                        ? CommonVariable.IC_TOGGLE
                                        : CommonVariable.IC_TOGGLE_OFF,
                                    height: _height * 0.05,
                                    width: _height * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 60, right: 60),
                            padding: const EdgeInsets.all(12),
                            child:CommonWidget.CommonButtonMessage(ApplicationLocalizations.of(context)!
                                .translate('common.next')
                                .toString(),register),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
  // hide and show password
  void togglePasswordView() {
    _showPassword = !_showPassword;
    if (this.mounted) {
      setState(() {});
    }
  }
  // hide and show confirm password
  void toggleConPasswordView() {
    _showConPassword = !_showConPassword;
    if (this.mounted) {
      setState(() {});
    }
  }
  // pick image from camera
  void imgFromCamera() async {
    var pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (this.mounted) {
      setState(() {
        if (pickedFile != null) {
          croppedImage(File(pickedFile.path));
        } else {}
      });
    }
  }
  // pick image from gallery
  void imgFromGallery() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (this.mounted) {
      setState(() {
        if (pickedFile != null) {
          croppedImage(File(pickedFile.path));
        } else {}
      });
    }
  }

  // crop selected image file
  void croppedImage(File file) async {
    await ImageCropper.cropImage(
            sourcePath: file.path,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                  ]
                : [
                    CropAspectRatioPreset.square,
                  ],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: ColorStyles.orange[500],
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true),
            iosUiSettings:
                IOSUiSettings(title: 'Cropper', aspectRatioLockEnabled: true))
        .then((value) {
      if (value != null) {
        if (this.mounted) {
          _imageFile = value;
          setState(() {});
        }
      }
    }).catchError((Error) {});
  }

  // naviagte otp screen
  void navigate(BuildContext context, RegistractionResponse value,
      String accountType) async {
    if (this.mounted) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      SharedPreferenceHelper _sharedPrefsHelper =
          SharedPreferenceHelper(_prefs);
      _sharedPrefsHelper.saveEmail(value.data!.emailId.toString());
      _sharedPrefsHelper.saveAccountType(accountType);
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushReplacementNamed(otpRoute,
            arguments: new VerifyModel("0", ""));
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _userUserNameController.dispose();
    _userEmailController.dispose();
    _userDOBDayController.dispose();
    _userDOBMonthController.dispose();
    _userDOBYearController.dispose();
    _userPassController.dispose();
    _userConPassController.dispose();
    _userReferalCodeController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _dobDayFocusNode.dispose();
    _dobMonthFocusNode.dispose();
    _dobYearFocusNode.dispose();
    _passwordFocusNode.dispose();
    _conPasswordFocusNode.dispose();
    _referalCodeFocusNode.dispose();
    super.dispose();
  }

  // fill data from login page
  void fillData() {
    Future.delayed(Duration(milliseconds: 100), () {
      GoogleFacebookModel googleFacebookModel =
          ModalRoute.of(context)!.settings.arguments as GoogleFacebookModel;
      _idSocial = googleFacebookModel.id;
      _nameSocial = googleFacebookModel.name;
      _emailSocial = googleFacebookModel.email;
      _imageSocial = googleFacebookModel.image;
      _accountType = googleFacebookModel.accountType;
      _userNameController.text = _nameSocial;
      _userEmailController.text = _emailSocial;
      if (_emailSocial != null && _emailSocial != "") {
        _enabled = false;
      }
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  // call register api with validation
  void register() async {
    if (isValidate()) {
      if (toggle == 1) {
        DeviceUtils.hideKeyboard(context);
        Dio dio = new Dio();
        DioClient dioClient = new DioClient(dio);
        String date = _userDOBDayController.text +
            "-" +
            _userDOBMonthController.text +
            "-" +
            _userDOBYearController.text;
        new LoginApi(dioClient)
            .register(
                context,
                _accountType,
                _idSocial,
                _userNameController.text,
                _userUserNameController.text,
                _userEmailController.text,
                date,
                _userPassController.text,
                _userReferalCodeController.text,
                (_imageFile != null) ? _imageFile : _imageSocial)
            .then((value) {
          if (value != null) {
            if (value.response == 200) {
              if (_accountType != null &&
                  _accountType != "" &&
                  _accountType != "0") {
                navigateHomePage(context, value, _accountType);
              } else {
                navigate(context, value, _accountType);
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
      } else {
        Future.delayed(Duration(milliseconds: 0), () {
          CommonMethod.commonMessageError(ApplicationLocalizations.of(context)!
              .translate('error.privacy_policy')
              .toString());
        });
      }
    }
  }

  // naviagte to home screen
  void navigateHomePage(BuildContext context, RegistractionResponse value,
      String accountType) async {
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
      _sharedPrefsHelper.saveAccountType(accountType);
      _sharedPrefsHelper.saveImage(value.data!.userImage.toString());
      _sharedPrefsHelper
          .saveEmailVerified(value.data!.isEmailVerified.toString());
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            homeRoute, (Route<dynamic> route) => false);
      });
    }
  }

  // validate forma data on button click
  bool isValidate() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    int year = dateParse.year;
    bool valid = true;
    if (_userNameController.text.isEmpty) {
      _nameValid = true;
      valid = false;
      _nameError = "error.name_empty";
    } else if (_userNameController.text.trim().length < 1) {
      _nameValid = true;
      valid = false;
      _nameError = "error.name_valid";
    } else {
      _nameValid = false;
    }
    if (_userUserNameController.text.isEmpty) {
      _usernameValid = true;
      valid = false;
      _usernameError = "error.username_empty";
    } else if (_userUserNameController.text.trim().length < 1) {
      _usernameValid = true;
      valid = false;
      _usernameError = "error.username_valid";
    } else {
      _usernameValid = false;
    }
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

    if (_userDOBDayController.text.isEmpty) {
      valid = false;
      _dobDayValid = true;
      _dobDayError = "error.empty_day";
    } else if (int.parse(_userDOBDayController.text.toString()) == 0) {
      valid = false;
      _dobDayValid = true;
      _dobDayError = "error.invalid_day";
    } else if (int.parse(_userDOBDayController.text.toString()) > 28) {
      if (_userDOBMonthController.text.isEmpty) {
        if (int.parse(_userDOBDayController.text.toString()) > 31) {
          valid = false;
          _dobDayValid = true;
          _dobDayError = "error.invalid_day";
        }
      } else {
        if (int.parse(_userDOBMonthController.text.toString()) == 2) {
          if (!_userDOBYearController.text.isEmpty &&
              _userDOBYearController.text.length == 4) {
            if (leapYear(int.parse(_userDOBYearController.text.toString()))) {
              if (int.parse(_userDOBDayController.text.toString()) > 29) {
                valid = false;
                _dobDayValid = true;
                _dobDayError = "error.invalid_day";
              }
            } else if (int.parse(_userDOBDayController.text.toString()) > 28) {
              valid = false;
              _dobDayValid = true;
              _dobDayError = "error.invalid_day";
            }
          } else if (int.parse(_userDOBDayController.text.toString()) > 29) {
            valid = false;
            _dobDayValid = true;
            _dobDayError = "error.invalid_day";
          }
        } else if (int.parse(_userDOBDayController.text.toString()) == 31 &&
                int.parse(_userDOBMonthController.text.toString()) == 6 ||
            int.parse(_userDOBMonthController.text.toString()) == 9 ||
            int.parse(_userDOBMonthController.text.toString()) == 4 ||
            int.parse(_userDOBMonthController.text.toString()) == 11) {
          valid = false;
          _dobDayValid = true;
          _dobDayError = "error.invalid_day";
        } else if (int.parse(_userDOBDayController.text.toString()) > 31) {
          valid = false;
          _dobDayValid = true;
          _dobDayError = "error.invalid_day";
        }
      }
    } else {
      _dobDayValid = false;
    }

    if (_userDOBMonthController.text.isEmpty) {
      valid = false;
      _dobMonthValid = true;
      _dobMonthError = "error.empty_month";
    } else if (int.parse(_userDOBMonthController.text.toString()) == 0) {
      valid = false;
      _dobMonthValid = true;
      _dobMonthError = "error.invalid_month";
    } else if (int.parse(_userDOBMonthController.text.toString()) > 12) {
      valid = false;
      _dobMonthValid = true;
      _dobMonthError = "error.invalid_month";
    } else {
      _dobMonthValid = false;
    }
    if (_userDOBYearController.text.isEmpty) {
      valid = false;
      _dobYearValid = true;
      _dobYearError = "error.empty_year";
    } else if (int.parse(_userDOBYearController.text.toString()) == 0) {
      valid = false;
      _dobYearValid = true;
      _dobYearError = "error.invalid_year";
    } else if (int.parse(_userDOBYearController.text.toString()) >=
        (year - 3)) {
      valid = false;
      _dobYearValid = true;
      _dobYearError = "error.invalid_year";
    } else {
      _dobYearValid = false;
    }
    if (_userDOBDayController.text.toString() != "" &&
        _userDOBMonthController.text.toString() != "" &&
        _userDOBYearController.text.toString() != "" &&
        _userDOBYearController.text.toString().length == 4) {
      String day = "";
      String month = "";
      if (_userDOBDayController.text.length < 2) {
        day = "0" + _userDOBDayController.text;
      } else {
        day = _userDOBDayController.text;
      }
      if (_userDOBMonthController.text.length < 2) {
        month = "0" + _userDOBMonthController.text;
      } else {
        month = _userDOBMonthController.text;
      }
      String date = _userDOBYearController.text + "-" + month + "-" + day;
      DateTime dob = DateTime.parse(date);
      Duration dur = DateTime.now().difference(dob);
      String differenceInYears = (dur.inDays / 365).floor().toString();
      if (int.parse(differenceInYears) < 4) {
        valid = false;
        _dobYearValid = true;
        _dobYearError = "error.invalid_year";
      }
    }

    if (_accountType != "1" && _accountType != "2" && _accountType != "3") {
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
    }
    if (this.mounted) {
      setState(() {});
    }

    return valid;
  }

  // name validation when text change
  void onChangeListenerName() {
    _nameValid = false;
    if (_userNameController.text.isEmpty) {
      _nameValid = true;
      _nameError = "error.name_empty";
    } else if (_userNameController.text.trim().length < 1) {
      _nameValid = true;
      _nameError = "error.name_valid";
    } else {
      _nameValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  // username validation when text change
  void onChangeListenerUsername() {
    _usernameValid = false;
    if (_userUserNameController.text.isEmpty) {
      _usernameValid = true;
      _usernameError = "error.username_empty";
    } else if (_userUserNameController.text.trim().length < 1) {
      _usernameValid = true;
      _usernameError = "error.username_valid";
    } else {
      _usernameValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  // email validation when text change
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

  // check yeae is leep or not
  bool leapYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  // day validation when text change
  void onChangeListenerDOBDay() {
    _dobDayValid = false;
    if (_userDOBDayController.text.isEmpty) {
      _dobDayValid = true;
      _dobDayError = "error.empty_day";
    } else if (int.parse(_userDOBDayController.text.toString()) == 0) {
      _dobDayValid = true;
      _dobDayError = "error.invalid_day";
    } else if (int.parse(_userDOBDayController.text.toString()) > 28) {
      if (_userDOBMonthController.text.isEmpty) {
        if (int.parse(_userDOBDayController.text.toString()) > 31) {
          _dobDayValid = true;
          _dobDayError = "error.invalid_day";
        }
      } else {
        if (int.parse(_userDOBMonthController.text.toString()) == 2) {
          if (!_userDOBYearController.text.isEmpty &&
              _userDOBYearController.text.length == 4) {
            if (leapYear(int.parse(_userDOBYearController.text.toString()))) {
              if (int.parse(_userDOBDayController.text.toString()) > 29) {
                _dobDayValid = true;
                _dobDayError = "error.invalid_day";
              }
            } else if (int.parse(_userDOBDayController.text.toString()) > 28) {
              _dobDayValid = true;
              _dobDayError = "error.invalid_day";
            }
          } else if (int.parse(_userDOBDayController.text.toString()) > 29) {
            _dobDayValid = true;
            _dobDayError = "error.invalid_day";
          }
        } else if (int.parse(_userDOBDayController.text.toString()) == 31 &&
                int.parse(_userDOBMonthController.text.toString()) == 6 ||
            int.parse(_userDOBMonthController.text.toString()) == 9 ||
            int.parse(_userDOBMonthController.text.toString()) == 4 ||
            int.parse(_userDOBMonthController.text.toString()) == 11) {
          _dobDayValid = true;
          _dobDayError = "error.invalid_day";
        } else if (int.parse(_userDOBDayController.text.toString()) > 31) {
          _dobDayValid = true;
          _dobDayError = "error.invalid_day";
        }
      }
    } else {
      _dobDayValid = false;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  // month validation when text change
  void onChangeListenerDOBMonth() {
    _dobMonthValid = false;
    if (_userDOBMonthController.text.isEmpty) {
      _dobMonthValid = true;
      _dobMonthError = "error.empty_month";
    } else if (int.parse(_userDOBMonthController.text.toString()) == 0) {
      _dobMonthValid = true;
      _dobMonthError = "error.invalid_month";
    } else if (int.parse(_userDOBMonthController.text.toString()) > 12) {
      _dobMonthValid = true;
      _dobMonthError = "error.invalid_month";
    } else {
      _dobMonthValid = false;
    }
    onChangeListenerDOBDay();
    if (this.mounted) {
      setState(() {});
    }
  }

  // year validation when text change
  void onChangeListenerDOBYear() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    int year = dateParse.year;
    _dobYearValid = false;
    if (_userDOBYearController.text.isEmpty) {
      _dobYearValid = true;
      _dobYearError = "error.empty_year";
    } else if (int.parse(_userDOBYearController.text.toString()) == 0) {
      _dobYearValid = true;
      _dobYearError = "error.invalid_year";
    } else if (int.parse(_userDOBYearController.text.toString()) >=
        (year - 3)) {
      _dobYearValid = true;
      _dobYearError = "error.invalid_year";
    } else {
      _dobYearValid = false;
    }
    onChangeListenerDOBMonth();
    if (this.mounted) {
      setState(() {});
    }
  }

  // password validation when text change
  void onChangeListenerPassword() {
    if (_accountType != "1" && _accountType != "2" && _accountType != "3") {
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
  }

  // confirm password validation when text change
  void onChangeListenerConfirm() {
    if (_accountType != "1" && _accountType != "2" && _accountType != "3") {
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
  }

  // referal code validation when text change
  void onChangeListenerReferalCode() {}

  // terms and condtion toggle
  void changeToggle() {
    if (this.mounted) {
      if (toggle == 1) {
        toggle = 0;
      } else {
        toggle = 1;
      }
      setState(() {});
    }
  }

}
