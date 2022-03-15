/// message : "Page not Found"
/// response : 201
/// data : {"link":""}

class StaticPagesResponse {
  String? _message;
  int? _response;
  String? _data;

  String? get message => _message;
  int? get response => _response;
  dynamic? get data => _data;

  StaticPagesResponse({
      String? message, 
      int? response,
    dynamic? data}){
    _message = message;
    _response = response;
    _data = data;
}

  StaticPagesResponse.fromJson(dynamic json) {
    _message = json["message"];
    _response = json["response"];
    _data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["response"] = _response;
      map["data"] = _data;
    return map;
  }

}
