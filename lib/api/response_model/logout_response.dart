class LogoutResponse{
  int? _response;
  String? _message;

  int? get response => _response;
  String? get message => _message;

  LogoutResponse({
    int? response,
    String? message}){
    _response = response;
    _message = message;
  }

  LogoutResponse.fromJson(dynamic json) {
    _response = json["response"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["response"] = _response;
    map["message"] = _message;
    return map;
  }

}