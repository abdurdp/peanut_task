import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  SharedPreferences? prefs;
  String? fullname;
  String? password;
  String? user_name;
  String? login;
  String? emp_id;
  String? user_id;
  String? client_id;
  String? client_type;
  String? user_type;
  String? vehicleNo;
  String? avatar;
  String? reservationData;
  String? sensorInfoData;
  String? parkingDateTime;
  String? firstTime;
  String? tokenData;
  String? mobile;

  String? email;

  Session({this.fullname, this.user_name, this.avatar});

  Future<Session> user() async {
    prefs = await SharedPreferences.getInstance();
    fullname = prefs!.getString('fullname');
    password = prefs!.getString('Pass');
    user_name = prefs!.getString('user_name');
    vehicleNo = prefs!.getString('vehicle_no');
    avatar = prefs!.getString('image');
    return Session(fullname: fullname, user_name: user_name, avatar: avatar);
  }


  Future<String?> token() async {
    prefs = await SharedPreferences.getInstance();
    tokenData = prefs!.getString('token');
    return tokenData;
  }

  Future<String?> userPassword() async {
    prefs = await SharedPreferences.getInstance();
    password = prefs!.getString('Pass');
    return password;
  }

  Future<String?> userFirstTime() async {
    prefs = await SharedPreferences.getInstance();
    firstTime = prefs!.getString('first_time');
    return firstTime;
  }

  Future<String?> username() async {
    prefs = await SharedPreferences.getInstance();
    user_name = prefs!.getString('user_name');
    return user_name;
  }
  Future<String?> loginNumber() async {
    prefs = await SharedPreferences.getInstance();
    login = prefs!.getString('login');
    return login;
  }
  Future<String?> empId() async {
    prefs = await SharedPreferences.getInstance();
    emp_id = prefs!.getString('EmpId');
    return emp_id ?? "";
  }
  Future<String?> userId() async {
    prefs = await SharedPreferences.getInstance();
    user_id = prefs!.getString('user_id');
    return user_id ?? "";
  }
  Future<String?> clientId() async {
    prefs = await SharedPreferences.getInstance();
    client_id = prefs!.getString('client_id');
    return client_id ?? "";
  }
  Future<String?> clientType() async {
    prefs = await SharedPreferences.getInstance();
    client_type = prefs!.getString('client_type');
    return client_type ?? "";
  }
  Future<String?> userType() async {
    prefs = await SharedPreferences.getInstance();
    user_type = prefs!.getString('user_type');
    return user_type ?? "";
  }

  Future<String?> fullName() async {
    prefs = await SharedPreferences.getInstance();
    fullname = prefs!.getString('fullname');
    return fullname;
  }
  Future<String?> mobileNo() async {
    prefs = await SharedPreferences.getInstance();
    mobile = prefs!.getString('mobile');
    return mobile ?? "";
  }

}
