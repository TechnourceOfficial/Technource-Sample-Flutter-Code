import 'package:cutit_new/constant/common_method.dart';
import 'package:cutit_new/resource/color_styles.dart';
import 'package:cutit_new/resource/text_style.dart';
import 'package:flutter/material.dart';

class CommonWidget{
  // Container for use in golable.
  static Widget CommonText(String name){
    return Container(child: new Text(name,style: new TextStyle(
        color: CommonMethod.fromHex(ColorStyles.privacyTextbackground),
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Akrobat'
    )));
  }
  // Container for Terms and Privacy
  static Widget CommonTextMessage(String name){
    return Container(
        alignment: Alignment.center,
        child: new Text(name,
            textAlign: TextAlign.center,
            style: new TextStyle(
        color: CommonMethod.fromHex(ColorStyles.privacyTextbackground),
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: 'Akrobat'
    )));
  }
  static Widget CommonButtonMessage(String btnTxt,dynamic callingFunction){
    return Container(
      width: 100,
      child: GestureDetector(
        onTap: () async {
          callingFunction();
        },
        child: Container(
          width: 100,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CommonMethod.fromHex(
                  ColorStyles.btnColor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(btnTxt,
              textAlign: TextAlign.center,
              style: CommonTextStyle.BtnTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}