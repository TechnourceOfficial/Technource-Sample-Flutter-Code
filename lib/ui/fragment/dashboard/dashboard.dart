import 'package:cutit_new/constant/common_method.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    CommonMethod.setHeightWidth(context);
    return Scaffold(
      body: SafeArea(child: Container()),
    );
  }
}
