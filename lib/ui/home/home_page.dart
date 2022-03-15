import 'dart:async';
import 'dart:io';
import 'package:cutit_new/api/dio_client.dart';
import 'package:cutit_new/api/dio_error_util.dart';
import 'package:cutit_new/api/service/login_api.dart';
import 'package:cutit_new/constant/common_method.dart';
import 'package:cutit_new/constant/common_variable.dart';
import 'package:cutit_new/constant/device_utils.dart';
import 'package:cutit_new/localization/application_localizations.dart';
import 'package:cutit_new/resource/color_styles.dart';
import 'package:cutit_new/resource/text_style.dart';
import 'package:cutit_new/shared_pref/shared_preference_helper.dart';
import 'package:cutit_new/ui/fragment/camera/camera.dart';
import 'package:cutit_new/ui/fragment/ciser/ciser.dart';
import 'package:cutit_new/ui/fragment/dashboard/dashboard.dart';
import 'package:cutit_new/ui/fragment/notification/notification.dart';
import 'package:cutit_new/ui/fragment/profile/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _position = 0;
  int _count = 0;
  String _userName = "";
  bool _flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
    _controller.addListener(changeListener);
  }

  void changeListener() {
    _position = _controller.index;
    if (this.mounted) {
      setState(() {});
    }
    if (_flag) {
      _flag = false;
    } else {
      _flag = true;
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
        child: new Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_position == 0)
                      ? Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          color: ColorStyles.white,
                          child: Text(
                              ApplicationLocalizations.of(context)!
                                  .translate('title.dashboard')
                                  .toString(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: CommonTextStyle.TextStyleHomeTitle))
                      : (_position == 3)
                          ? Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              color: ColorStyles.white,
                              child: Text(
                                  ApplicationLocalizations.of(context)!
                                      .translate('title.notification')
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: CommonTextStyle.TextStyleTitle))
                          : (_position == 4)
                              ? Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  color: ColorStyles.white,
                                  child: Text(_userName,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: CommonTextStyle.TextStyleTitle))
                              : Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  color: ColorStyles.white,
                                  child: Image.asset(
                                    CommonVariable.APP_LIGHT_LOGO,
                                    height: _height * 0.06,
                                    width: _height * 0.06,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                ],
              ),
              backgroundColor: ColorStyles.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: (_position == 0)
                  ? IconButton(
                      icon: Image.asset(
                        CommonVariable.IC_WORLD_WIDE,
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,
                      ),
                      onPressed: () {},
                    )
                  : (_position == 2)
                      ? IconButton(
                          icon: Image.asset(
                            CommonVariable.IC_MENU,
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        )
                      : null,
              actions: (_position == 0 || _position == 2)
                  ? <Widget>[
                      IconButton(
                        icon: Image.asset(
                          CommonVariable.IC_CHAT_BUBBLE,
                          height: 30,
                          width: 30,
                          fit: BoxFit.fill,
                        ),
                        onPressed: () {
                          ;
                        },
                      ),
                    ]
                  : (_position == 4)
                      ? <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.power_settings_new,
                              size: 30,
                              color: CommonMethod.fromHex(ColorStyles.btnColor),
                            ),
                            onPressed: () {
                              logout();
                            },
                          ),
                        ]
                      : <Widget>[],
            ),
            backgroundColor: ColorStyles.white,
            bottomNavigationBar: SafeArea(
                bottom: true,
                child: Material(
                    elevation: 0,
                    shadowColor: ColorStyles.engineerBlack,
                    color: ColorStyles.white,
                    child: new ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        new Container(
                            color: Colors.white,
                            child: TabBar(
                              controller: _controller,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: Colors.transparent,
                              isScrollable: false,
                              tabs: [
                                Tab(
                                  icon: (_controller.index == 0)
                                      ? new Image.asset(
                                          CommonVariable.IC_HOME_BLACK,
                                          height: _height * 0.05,
                                          width: _height * 0.05,
                                        )
                                      : new Image.asset(
                                          CommonVariable.IC_HOME_WHITE,
                                          height: _height * 0.045,
                                          width: _height * 0.045,
                                        ),
                                ),
                                Tab(
                                  icon: (_controller.index == 1)
                                      ? new Image.asset(
                                          CommonVariable.IC_CAMERA_BLACK,
                                          height: _height * 0.05,
                                          width: _height * 0.05,
                                        )
                                      : new Image.asset(
                                          CommonVariable.IC_CAMERA_WHITE,
                                          height: _height * 0.045,
                                          width: _height * 0.045,
                                        ),
                                ),
                                Tab(
                                  icon: (_controller.index == 2)
                                      ? new Image.asset(
                                          CommonVariable.IC_CISER_BLACK,
                                          height: _height * 0.05,
                                          width: _height * 0.05,
                                        )
                                      : new Image.asset(
                                          CommonVariable.IC_CISER_WHITE,
                                          height: _height * 0.045,
                                          width: _height * 0.045,
                                        ),
                                ),
                                Tab(
                                    icon: new Stack(children: <Widget>[
                                  (_controller.index == 3)
                                      ? new Image.asset(
                                          CommonVariable.IC_NOTIFICATION_BLACK,
                                          height: _height * 0.05,
                                          width: _height * 0.05,
                                        )
                                      : new Image.asset(
                                          CommonVariable.IC_NOTIFICATION_WHITE,
                                          height: _height * 0.045,
                                          width: _height * 0.045,
                                        ),
                                  (_count == 0)
                                      ? new Positioned(
                                          // draw a red marble
                                          top: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            height: 0,
                                          ),
                                        )
                                      : new Positioned(
                                          // draw a red marble
                                          top: 0.0,
                                          right: 0.0,
                                          child: new Icon(Icons.brightness_1,
                                              size: 8.0,
                                              color: CommonMethod.fromHex(
                                                  ColorStyles.btnColor)),
                                        )
                                ])),
                                Tab(
                                  icon: (_controller.index == 4)
                                      ? new Image.asset(
                                          CommonVariable.IC_PROFILE_BLACK,
                                          height: _height * 0.05,
                                          width: _height * 0.05,
                                        )
                                      : new Image.asset(
                                          CommonVariable.IC_PROFILE_WHITE,
                                          height: _height * 0.04,
                                          width: _height * 0.04,
                                        ),
                                ),
                              ],
                            ))
                      ],
                    ))),
            body: Container(
                color: ColorStyles.white,
                child: SafeArea(
                    bottom: true,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _controller,
                      children: [
                        new DashBoard(),
                        new Camera(),
                        new Ciser(),
                        new Notifications(),
                        new Profile()
                      ],
                    )))));
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  Future<bool> _onBackPressed() async {
    int index = _controller.index;
    if (index == 0) {
      showAlertDialog(context);
      return false;
    } else {
      _controller.animateTo(0);
      return false;
    }
  }

  // show alert dialog
  showAlertDialog(BuildContext context) async {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        ApplicationLocalizations.of(context)!
            .translate('common.cancel')
            .toString(),
        style: CommonTextStyle.TextStyleDialogRemoveCancle,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        ApplicationLocalizations.of(context)!.translate('common.ok').toString(),
        style: CommonTextStyle.TextStyleDialogRemoveConfirm,
      ),
      onPressed: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ListView(shrinkWrap: true, children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ListView(shrinkWrap: true, children: [
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          new Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, bottom: 5),
                              child: Text(
                                ApplicationLocalizations.of(context)!
                                    .translate('label.exit_mesage')
                                    .toString(),
                                style: CommonTextStyle.TextStyleDialogTitle,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                cancelButton,
                                continueButton,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    ]))
              ])),
        );
      },
    );
  }
  // calling otp api.
  void logout() async{
    DeviceUtils.hideKeyboard(context);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);

    await _sharedPrefsHelper.getAccessToken().then((token) async {
      if (token != null && token != "") {
        Dio dio = new Dio();
        dio.options.headers = {"Authorization": "Bearer " + token.toString()};
        DioClient dioClient = new DioClient(dio);
        new LoginApi(dioClient).logout(context).then((value) {
          if (value != null) {
            if (value.response == 200) {
              CommonMethod.goToLoginScreen(context);
            } else if (value.response == 201) {
              CommonMethod.commonMessageError(value.message.toString());
            } else if (value.response == 401) {
              CommonMethod.goToLoginScreen(context);
            }
          }
        }).catchError((e) {
          if (DioErrorUtil.handleError(e, context) != "") {
            CommonMethod.commonMessageError(
                DioErrorUtil.handleError(e, context));
          }
        });
      }
    });
  }
}
