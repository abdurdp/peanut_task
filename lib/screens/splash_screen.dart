import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/session.dart';
import '../router/route_generator.dart';
import '../services/connectivity_services.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isChecking = false;
  // declare a timer
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initApp();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: CustomColor.backgroundColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TextLiquidFill(
                      text: 'Peanut Task',
                      textAlign: TextAlign.center,
                      waveColor: Color(0xffD62D2D),
                      boxBackgroundColor: CustomColor.backgroundColor,
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Righteous',
                        color: CustomColor.primaryColor,
                      ),
                      boxHeight: 300.0,
                      loadDuration: const Duration(seconds: 1),
                      waveDuration: const Duration(seconds: 1),
                    ),
                  ],
                ),
              ),
            ),
            if (isChecking) ...[
              Positioned(
                left: Dimensions.defaultSize,
                right: Dimensions.defaultSize,
                bottom: Dimensions.defaultSize,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.whiteColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.defaultSize,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.redColor.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.defaultSize / 2,
                      horizontal: 0,
                    ),
                    minLeadingWidth: Dimensions.defaultSize,
                    leading: Icon(Icons.wifi_off_outlined),
                    title: Text(
                      'NO INTERNET',
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> initApp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // other task
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        bool isOnline = await ConnectivityServices().connectivityResult();
        if (isOnline) {
          timer.cancel();
          if (mounted) {
            if (await Session().loginNumber() == null) {
              // second time user
              Navigator.of(context).pushNamedAndRemoveUntil(
                  signInRoute, (Route<dynamic> route) => false);
            }
            else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  dashboardRoute, (Route<dynamic> route) => false);
            }
          }
        } else {
          // no internet user
          if (isChecking == false) {
            if (mounted) {
              setState(() {
                isChecking = true;
              });
            }
          }
        }
      });
    });
  }

  Future userFirstTimeCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await Session().userFirstTime() == null) {
      prefs.setString('first_time', 'welcome, buddy');
    }
    return true;
  }

}
