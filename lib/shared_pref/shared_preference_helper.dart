import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  Future<String?> getAccessToken() async {
    return _sharedPreference.getString(Preferences.access_token);
  }

  Future<String?> getEmail() async {
    return _sharedPreference.getString(Preferences.email_id);
  }

  Future<String?> getMobileNumber() async {
    return _sharedPreference.getString(Preferences.mobile_number);
  }

  Future<String?> getName() async {
    return _sharedPreference.getString(Preferences.name);
  }

  Future<String?> getUsername() async {
    return _sharedPreference.getString(Preferences.username);
  }

  Future<String?> getUserId() async {
    return _sharedPreference.getString(Preferences.user_id);
  }

  Future<String?> getEmailVerified() async {
    return _sharedPreference.getString(Preferences.user_id);
  }

  Future<bool> saveAccessToken(String value) async {
    return _sharedPreference.setString(Preferences.access_token, value);
  }

  Future<bool> saveEmailVerified(String value) async {
    return _sharedPreference.setString(Preferences.email_verified, value);
  }

  Future<bool> saveAccountType(String value) async {
    return _sharedPreference.setString(Preferences.account_type, value);
  }

  Future<bool> saveUserID(String value) async {
    return _sharedPreference.setString(Preferences.user_id, value);
  }

  Future<bool> saveMobileNumber(String value) async {
    return _sharedPreference.setString(Preferences.mobile_number, value);
  }

  Future<bool> saveImage(String value) async {
    return _sharedPreference.setString(Preferences.user_image, value);
  }

  Future<bool> saveuserType(String value) async {
    return _sharedPreference.setString(Preferences.user_type, value);
  }

  Future<bool> saveName(String value) async {
    return _sharedPreference.setString(Preferences.name, value);
  }

  Future<bool> saveUserName(String value) async {
    return _sharedPreference.setString(Preferences.username, value);
  }

  Future<bool> saveEmail(String value) async {
    return _sharedPreference.setString(Preferences.email_id, value);
  }

  Future<bool> saveDOB(String value) async {
    return _sharedPreference.setString(Preferences.date_of_birth, value);
  }

  Future<String?> getDOB() async {
    return _sharedPreference.getString(Preferences.date_of_birth);
  }

  Future<String?> getUserType() async {
    return _sharedPreference.getString(Preferences.user_type);
  }

  Future<String?> getAccountType() async {
    return _sharedPreference.getString(Preferences.account_type);
  }

  Future<bool> saveAbout(String value) async {
    return _sharedPreference.setString(Preferences.about, value);
  }

  Future<String?> getAbout() async {
    return _sharedPreference.getString(Preferences.about);
  }

  Future<bool> saveIsActive(String value) async {
    return _sharedPreference.setString(Preferences.is_active, value);
  }

  Future<String?> getIsActive() async {
    return _sharedPreference.getString(Preferences.is_active);
  }

  Future<bool> saveReferalCode(String value) async {
    return _sharedPreference.setString(Preferences.referral_code, value);
  }

  Future<String?> getReferalCode() async {
    return _sharedPreference.getString(Preferences.referral_code);
  }

  Future<String?> getUserImage() async {
    return _sharedPreference.getString(Preferences.user_image);
  }

  Future<bool> saveProfileCompleted(String value) async {
    return _sharedPreference.setString(Preferences.profile_completed, value);
  }

  Future<bool> getProfileCompleted() async {
    return _sharedPreference.getBool(Preferences.profile_completed) ?? false;
  }
}
