import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/url.dart';
import '../base/api_response.dart';
import '../body/login.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';

class AuthRepo {
  final DioClient dioClient;

  AuthRepo({required this.dioClient});

  Future<ApiResponse> login(LoginModel loginBody) async {
    var  json =  {
      "login": loginBody.login,
      "password": loginBody.password,
    };

    try {
      Response response = await dioClient.post(
        URL.loginURL,
        data: json,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  //login provider

  //save user login data
  saveUserTokenObj( login, token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("login", login);
    preferences.setString("token", token.toString());
    return true;
  }
  //save user login data

// clear user session data
  Future<bool> clearSharedData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove("login");
      preferences.remove("token");
    } catch (e) {
     print(e.toString()) ;
    }
    return true;
  }
}
