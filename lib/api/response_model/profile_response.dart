/// response : 200
/// message : "Registration completed successfully"
/// data : {"access_token":"","user_id":"","is_email_varified":"","name":"","username":"","email_id":"","date_of_birth":"","mobile_number":"","is_active":"","about":"","referral_code":"","profile_completed":""}

class ProfileResponse {
  int? _response;
  String? _message;
  Data? _data;

  int? get response => _response;

  String? get message => _message;

  Data? get data => _data;

  ProfileResponse({int? response, String? message, Data? data}) {
    _response = response;
    _message = message;
    _data = data;
  }

  ProfileResponse.fromJson(dynamic json) {
    _response = json["response"];
    _message = json["message"];
    _data = json["data"] != null && json["data"]!="" ? Data.fromJson(json["data"]) : null;
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
/// is_email_varified : ""
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
  String? _userId;
  String? _isEmailVarified;
  String? _name;
  String? _username;
  String? _userImage;
  String? _emailId;
  String? _dateOfBirth;
  String? _mobileNumber;
  String? _isActive;
  String? _about;
  String? _referralCode;
  String? _profileCompleted;


  String? get userId => _userId;

  String? get isEmailVarified => _isEmailVarified;

  String? get name => _name;

  String? get username => _username;

  String? get userImage => _userImage;

  String? get emailId => _emailId;

  String? get dateOfBirth => _dateOfBirth;

  String? get mobileNumber => _mobileNumber;

  String? get isActive => _isActive;

  String? get about => _about;

  String? get referralCode => _referralCode;

  String? get profileCompleted => _profileCompleted;

  Data(
      {int? userId,
      int? isEmailVarified,
      String? name,
      String? username,
      String? userImage,
      String? emailId,
      String? dateOfBirth,
      String? mobileNumber,
      int? isActive,
      String? about,
      String? referralCode,
      String? profileCompleted}) {
    _userId = userId.toString();
    _isEmailVarified = isEmailVarified.toString();
    _name = name;
    _username = username;
    _userImage = userImage;
    _emailId = emailId;
    _dateOfBirth = dateOfBirth;
    _mobileNumber = mobileNumber;
    _isActive = isActive.toString();
    _about = about;
    _referralCode = referralCode;
    _profileCompleted = profileCompleted;
  }

  Data.fromJson(dynamic json) {
    _userId = json["user_id"].toString();
    _isEmailVarified = json["is_email_varified"].toString();
    _name = json["name"];
    _username = json["username"];
    _userImage = json["user_image"];
    _emailId = json["email"];
    _dateOfBirth = json["date_of_birth"];
    _mobileNumber = json["mobile_number"];
    _isActive = json["is_active"].toString();
    _about = json["about"];
    _referralCode = json["referral_code"];
    _profileCompleted = json["profile_completed"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = _userId;
    map["is_email_varified"] = _isEmailVarified;
    map["name"] = _name;
    map["username"] = _username;
    map["user_image"] = _userImage;
    map["email_id"] = _emailId;
    map["date_of_birth"] = _dateOfBirth;
    map["mobile_number"] = _mobileNumber;
    map["is_active"] = _isActive;
    map["about"] = _about;
    map["referral_code"] = _referralCode;
    map["profile_completed"] = _profileCompleted;
    return map;
  }
}
