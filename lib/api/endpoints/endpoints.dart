class Endpoints {

  // base url
  static const String baseUrl = "http://192.168.1.14:8000/api/v1";
  // receiveTimeout
  static const int receiveTimeout = 18000;
  // connectTimeout
  static const int connectionTimeout = 30000;
  // baseUrl+method
  static const String register = baseUrl + "/register";
  static const String login = baseUrl + "/login";
  static const String verifyOtp = baseUrl + "/verify-otp";
  static const String resendOtp = baseUrl + "/resend-otp";
  static const String forgetPassword= baseUrl + "/forget-password";
  static const String resetPassword= baseUrl + "/reset-password";
  static const String getPageData= baseUrl + "/get-page-data";
  static const String logout= baseUrl + "/logout";
}