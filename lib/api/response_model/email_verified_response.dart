/// message : "OTP has been sent to your registered email. please enter the corresponding OTP code"
/// response : 200
/// data : {"email":"sourabh456@mailinator.com","is_email_verified":0}

class EmailVerifiedResponse {
  String? _message;
  int? _response;
  Data? _data;

  String? get message => _message;
  int? get response => _response;
  Data? get data => _data;

  EmailVerifiedResponse({
      String? message, 
      int? response, 
      Data? data}){
    _message = message;
    _response = response;
    _data = data;
}

  EmailVerifiedResponse.fromJson(dynamic json) {
    _message = json["message"];
    _response = json["response"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["response"] = _response;
    if (_data != null) {
      map["data"] = _data?.toJson();
    }
    return map;
  }

}

/// email : "sourabh456@mailinator.com"
/// is_email_verified : 0

class Data {
  String? _email;
  dynamic? _isEmailVerified;

  String? get email => _email;
  dynamic? get isEmailVerified => _isEmailVerified;

  Data({
      String? email,
    dynamic? isEmailVerified}){
    _email = email;
    _isEmailVerified = isEmailVerified;
}

  Data.fromJson(dynamic json) {
    _email = json["email"];
    _isEmailVerified = json["is_email_verified"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    map["is_email_verified"] = _isEmailVerified;
    return map;
  }

}