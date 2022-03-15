/// response : "200"
/// message : "Registration completed successfully"
/// data : {"access_token":"","user_id":"","device_token":"","name":"","username":"","email_id":"","date_of_birth":"","mobile_number":"","is_active":"","about":"","referral_code":"","profile_completed":""}

class RegistractionResponse {
  int? _response;
  String? _message;
  Data? _data;

  int? get response => _response;
  String? get message => _message;
  Data? get data => _data;

  RegistractionResponse({
      int? response,
      String? message, 
      Data? data}){
    _response = response;
    _message = message;
    _data = data;
}

  RegistractionResponse.fromJson(dynamic json) {
    _response = json["response"];
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["response"] = _response;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data?.toJson();
    }
    return map;
  }

}

/// access_token : ""
/// user_id : ""
/// device_token : ""
/// name : ""
/// username : ""
/// email_id : ""
/// date_of_birth : ""
/// mobile_number : ""
/// is_active : ""
/// about : ""
/// referral_code : ""
/// profile_completed : ""

class Data {
  String? _accessToken;
  String? _isEmailVerified;
  int? _userId;
  String? _deviceToken;
  String? _name;
  String? _username;
  String? _emailId;
  String? _dateOfBirth;
  String? _mobileNumber;
  String? _isActive;
  dynamic? _deactivateBy;
  String? _about;
  String? _userImage;
  String? _referralCode;
  String? _profileCompleted;

  String? get isEmailVerified => _isEmailVerified;
  String? get accessToken => _accessToken;
  int? get userId => _userId;
  dynamic? get deactivateBy => _deactivateBy;
  String? get deviceToken => _deviceToken;
  String? get name => _name;
  String? get username => _username;
  String? get emailId => _emailId;
  String? get dateOfBirth => _dateOfBirth;
  String? get mobileNumber => _mobileNumber;
  String? get isActive => _isActive;
  String? get about => _about;
  String? get userImage => _userImage;
  String? get referralCode => _referralCode;
  String? get profileCompleted => _profileCompleted;

  Data({
      int? isEmailVerified,
      String? accessToken,
      int? userId,
      dynamic? deactivateBy,
      String? deviceToken,
      String? name, 
      String? username, 
      String? emailId, 
      String? dateOfBirth, 
      String? mobileNumber, 
      String? isActive, 
      String? about, 
      String? userImage,
      String? referralCode,
      String? profileCompleted}){
    _accessToken = accessToken;
    _userId = userId;
    _deviceToken = deviceToken;
    _name = name;
    _username = username;
    _emailId = emailId;
    _dateOfBirth = dateOfBirth;
    _mobileNumber = mobileNumber;
    _isActive = isActive;
    _userImage = userImage;
    _about = about;
    _referralCode = referralCode;
    _isEmailVerified = isEmailVerified.toString();
}

  Data.fromJson(dynamic json) {
    _accessToken = json["access_token"];
    _userId = json["user_id"];
    _deviceToken = json["device_token"];
    _name = json["name"];
    _username = json["username"];
    _emailId = json["email"];
    _dateOfBirth = json["date_of_birth"];
    _mobileNumber = json["mobile_number"];
    _isActive = json["is_active"];
    _deactivateBy = json["deactivated_by"];
    _about = json["about"];
    _referralCode = json["referral_code"];
    _profileCompleted = json["profile_completed"];
    _userImage = json["user_image"];
    _isEmailVerified = json["is_email_verified"].toString();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["access_token"] = _accessToken;
    map["user_id"] = _userId;
    map["device_token"] = _deviceToken;
    map["name"] = _name;
    map["username"] = _username;
    map["email_id"] = _emailId;
    map["date_of_birth"] = _dateOfBirth;
    map["mobile_number"] = _mobileNumber;
    map["is_active"] = _isActive;
    map["deactivated_by"] = _deactivateBy;
    map["about"] = _about;
    map["user_image"] = _userImage;
    map["referral_code"] = _referralCode;
    map["is_email_verified"] = _isEmailVerified;
    return map;
  }

}