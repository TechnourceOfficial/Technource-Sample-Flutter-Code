import 'package:cutit_new/constant/common_method.dart';
import 'package:cutit_new/localization/application_localizations.dart';
import 'package:cutit_new/resource/color_styles.dart';
import 'package:cutit_new/resource/text_style.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile();
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.all(12),
            ),
      )),
    );
  }


}
