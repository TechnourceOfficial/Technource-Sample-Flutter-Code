import 'package:cutit_new/constant/common_method.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoader {
  // in api calling loading loader.
  static Future<dynamic> showLoader(BuildContext context) async{
    CommonMethod.setHeightWidth(context);
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future.value(false),child: SizedBox(
            height: 50,
            width: 50,
            child: new Container(
              height: 50,
              width: 50,
              child: Padding(
                padding: EdgeInsets.only(
                    left: CommonMethod.WIDTH * 0.4,
                    right: CommonMethod.WIDTH * 0.4,
                    top: 100,
                    bottom: 100),
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [Colors.white, Colors.blueAccent],
                ),
              ),
            ),
          ));
        });
  }
}
