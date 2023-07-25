import 'package:flutter/material.dart';

import '../model/base/api_response.dart';
import '../model/repository/profile_repo.dart';
import '../router/route_generator.dart';
import '../utils/navigator_key.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({required this.profileRepo});

  Future getUserProfileInfo() async {
    ApiResponse apiResponse = await profileRepo.getUserProfileInfo();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      final json = apiResponse.response!.data;
      return json;
    } else {
     return false;
    }
  }
  Future getOpenTrades() async {
    ApiResponse apiResponse = await profileRepo.getOpenTrades();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      final json = apiResponse.response!.data;
      return json;
    } else {
     return false;
    }
  }
  Future getLastFourNumber() async {
    ApiResponse apiResponse = await profileRepo.getLastFourNumber();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      final json = apiResponse.response!.data.toString();
      return json;
    } else {
     return false;
    }
  }
}
