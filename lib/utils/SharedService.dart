import 'dart:convert';

import 'package:crossbank/model/login/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService
{
  late final SharedPreferences prefs;
  Future<void> setFcmToken(String auth_token) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setString('fcm_token', auth_token);
  }
  Future<String?> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? auth_token = prefs.getString('fcm_token');
    return auth_token;
  }

  Future<void>setLoginDetails(LoginResponseModel loginResponseModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login_details',jsonEncode(loginResponseModel));
  }
  Future<LoginResponseModel> getLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_details = prefs.getString('login_details');
    LoginResponseModel responseModel=LoginResponseModel.fromJson(jsonDecode(login_details!));
    return responseModel;
    // return login_details!;
  }
}