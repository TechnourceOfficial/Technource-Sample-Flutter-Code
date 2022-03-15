import 'package:cutit_new/constant/common_method.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  Widget build(BuildContext context) {
    CommonMethod.setStatusColor();
    CommonMethod.setHeightWidth(context);
    double _height = CommonMethod.HEIGHT;
    double _width = CommonMethod.WIDTH;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: new GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                    width: _width,
                    padding: EdgeInsets.only(
                        left: _width * 0.03, right: _width * 0.03, bottom: 0),

                ))));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
