import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../utils/app_constant.dart';

class ConnectivityServices {
  Future<bool> connectivityResult() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return isPing();
  }

  // url lookup
  static Future<bool> isPing() async {
    try {
      await Dio().get(AppConstant.pingURL);
      return true;
    } catch (e) {
      return false;
    }
  }
}
