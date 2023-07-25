import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/base/api_response.dart';
import '../model/body/login.dart';
import '../model/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});


  Future login(LoginModel loginBody, Function callback) async {
    ApiResponse apiResponse = await authRepo.login(loginBody);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      final json = apiResponse.response!.data;
      authRepo.saveUserTokenObj(loginBody.login, json['token']);
      callback(true, json);
      notifyListeners();
    } else {
      callback(false, {});
    }
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }
}
