import 'dart:convert';

import 'package:cutit_new/localization/application_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioErrorUtilLogin {
  // general methods:------------------------------------------------------------
  static String handleError(DioError error, BuildContext context) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = ApplicationLocalizations.of(context)!
              .translate('something_went_wrong')
              .toString();
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection lost\nPlease check your Internet Connection and try again";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          print("data  "+  error.response.toString());
          if (error.response?.statusCode == 401) {
            errorDescription =
                "Your account is inactive/deleted. Kindly contact Admin.";
            break;
          } else if (error.response?.statusCode == 422) {
            try {
              final json = jsonDecode(error.response.toString());
              errorDescription = json["message"].toString();
              break;
            } on FormatException catch (e) {
              errorDescription = ApplicationLocalizations.of(context)!
                  .translate('something_went_wrong')
                  .toString();
              break;
            }
          } else {
            errorDescription = ApplicationLocalizations.of(context)!
                .translate('something_went_wrong')
                .toString();
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = ApplicationLocalizations.of(context)!
              .translate('something_went_wrong')
              .toString();
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  static late String message;

  static String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        print("object" + error.toString());
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
