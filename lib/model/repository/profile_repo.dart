import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/session.dart';
import '../../config/url.dart';
import '../base/api_response.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';

class ProfileRepo {
  final DioClient dioClient;

  ProfileRepo({required this.dioClient});

  Future<ApiResponse> getUserProfileInfo() async {
    try {
      final login = await Session().loginNumber();
      final token = await Session().token();
      var  json =  {
        "login": login,
        "token": token,
      };
      Response response =
          await dioClient.post(URL.getAccountInfoApiURL, data: json);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getLastFourNumber() async {
    try {
      final login = await Session().loginNumber();
      final token = await Session().token();
      var  json =  {
        "login": login,
        "token": token,
      };
      Response response =
          await dioClient.post(URL.getLastFourNumbersPhoneApiURL, data: json);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getOpenTrades() async {
    try {
      final login = await Session().loginNumber();
      final token = await Session().token();
      var  json =  {
        "login": login,
        "token": token,
      };
      Response response =
          await dioClient.post(URL.getOpenTradesApiURL, data: json);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
