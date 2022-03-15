import 'dart:collection';
import 'dart:io';

import 'package:cutit_new/api/endpoints/endpoints.dart';
import 'package:cutit_new/api/response_model/logout_response.dart';
import 'package:cutit_new/api/response_model/registraction_response.dart';
import 'package:cutit_new/constant/common_variable.dart';
import 'package:cutit_new/shared_pref/shared_preference_helper.dart';
import 'package:cutit_new/widget/custom_loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio_client.dart';

class LoginApi {
  final DioClient _dioClient;

  LoginApi(this._dioClient);
  // register user
  Future<RegistractionResponse> register(
      BuildContext context,
      String accountType,
      String id,
      String name,
      String userName,
      String email,
      String dob,
      String password,
      String referalCode,
      dynamic file) async {
    try {
      HashMap<String, dynamic> body = new HashMap();
      if (Platform.isAndroid) {
        body["device_type"] = 0;
      } else {
        body["device_type"] = 1;
      }
      body["device_token"] = CommonVariable.FirebaseToken;
      if (file is String) {
        body["profile"] = file;
      }
      body["account_type"] = accountType;
      body["account_type_id"] = id;
      body["name"] = name;
      body["username"] = userName;
      body["email"] = email;
      body["date_of_birth"] = dob;
      body["mobile_number"] = "";
      body["password"] = password;
      body["referal_code"] = referalCode;
      if (file != null && file is File) {
        final mimeTypeData =
            lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');
        return await MultipartFile.fromFile(file.path,
                contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
            .then((value) async {
          body["profile"] = value;
          FormData data = FormData.fromMap(body);
          CustomLoader.showLoader(context);
          final res = await _dioClient.post(Endpoints.register, data: data);
          Navigator.pop(context);
          return RegistractionResponse.fromJson(res);
        });
      } else {
        FormData data = FormData.fromMap(body);
        CustomLoader.showLoader(context);
        final res = await _dioClient.post(Endpoints.register, data: data);
        Navigator.pop(context);
        return RegistractionResponse.fromJson(res);
      }
    } catch (e) {
      Navigator.pop(context);
      throw e;
    }
  }
  // login user
  Future<RegistractionResponse> login(BuildContext context, String accountType,
      String userName, String password, String id) async {
    try {
      HashMap<String, dynamic> body = new HashMap();
      if (Platform.isAndroid) {
        body["device_type"] = 0;
      } else {
        body["device_type"] = 1;
      }
      body["device_token"] = CommonVariable.FirebaseToken;
      body["account_type"] = accountType;
      body["account_type_id"] = id;
      body["username"] = userName;
      body["password"] = password;
      FormData data = FormData.fromMap(body);
      CustomLoader.showLoader(context);
      final res = await _dioClient.post(Endpoints.login, data: data);
      Navigator.pop(context);
      return RegistractionResponse.fromJson(res);
    } catch (e) {
      Navigator.pop(context);
      throw e;
    }
  }
  // verifing OTP
  Future<RegistractionResponse> otp(
      BuildContext context, dynamic otp, String type) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);
    try {
      return await _sharedPrefsHelper.getAccessToken().then((token) async {
        return await _sharedPrefsHelper.getEmail().then((email) async {
          HashMap<String, dynamic> body = new HashMap();
          body["otp"] = otp;
          body["email"] = email;
          FormData data = FormData.fromMap(body);
          CustomLoader.showLoader(context);
          final res = await _dioClient.post(Endpoints.verifyOtp, data: data);
          Navigator.pop(context);
          return RegistractionResponse.fromJson(res);
        });
      });
    } catch (e) {
      Navigator.pop(context);
      throw e;
    }
  }
  //reset pasword
  Future<RegistractionResponse> resetPasssword(
      BuildContext context, String password, String conPassword) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);
    try {
      return await _sharedPrefsHelper.getEmail().then((email) async {
        HashMap<String, dynamic> body = new HashMap();
        body["password"] = password;
        body["confirm_password"] = conPassword;
        body["email"] = email;
        FormData data = FormData.fromMap(body);
        CustomLoader.showLoader(context);
        final res = await _dioClient.post(Endpoints.resetPassword, data: data);
        Navigator.pop(context);
        return RegistractionResponse.fromJson(res);
      });
    } catch (e) {
      Navigator.pop(context);
      throw e;
    }
  }
  // resend otp
  Future<RegistractionResponse> resendOtp(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper(_prefs);
    try {
      return await _sharedPrefsHelper.getEmail().then((email) async {
        HashMap<String, dynamic> body = new HashMap();
        body["email"] = email;
        FormData data = FormData.fromMap(body);
        CustomLoader.showLoader(context);
        final res = await _dioClient.post(Endpoints.resendOtp, data: data);
        Navigator.pop(context);
        return RegistractionResponse.fromJson(res);
      });
    } catch (e) {
      Navigator.pop(context);
      throw e;
    }
  }
  // forgetPassword
  Future<RegistractionResponse> forgorPassword(
      BuildContext context, String email) async {
    try {
      HashMap<String, dynamic> body = new HashMap();
      body["email"] = email;
      FormData data = FormData.fromMap(body);
      CustomLoader.showLoader(context);
      final res = await _dioClient.post(Endpoints.forgetPassword, data: data);
      Navigator.pop(context);
      return RegistractionResponse.fromJson(res);
    } catch (e) {
      Navigator.pop(context);
      throw e;
    }
  }
  // logout
  Future<LogoutResponse> logout(BuildContext context)async{
    try {
      CustomLoader.showLoader(context);
      HashMap<String, dynamic> body = new HashMap();
      FormData data = FormData.fromMap(body);
      final res = await _dioClient.post(Endpoints.logout,data:data);
      print("chnage Response" + res.toString());
      Navigator.pop(context);
      return LogoutResponse.fromJson(res);
    } catch (e) {

      Navigator.pop(context);
      throw e;
    }
  }
}
