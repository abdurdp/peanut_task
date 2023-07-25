import 'package:flutter/material.dart';
import 'package:peanut_task/errors/user_expired_screen.dart';
import 'package:peanut_task/screens/splash_screen.dart';

import '../errors/no_internet_screen.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/dashboard_screen.dart';
import '../utils/colors.dart';
import '../utils/navigator_key.dart';

// route name conversion
const String splashRoute = '/';
const String noInternetRoute = '/no_internet';
// auth
const String signInRoute = '/sign_in';
const String profileRoute = '/profile';
// auth
const String dashboardRoute = '/dashboard';

// error
const String userExpiredRoute = '/user_expired';
class RouteGenerator {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    return MaterialPageRoute(builder: (_) {
      if (settings.name == splashRoute) {
        return SplashScreen();
      } else {
        switch (settings.name) {
          case noInternetRoute:
            return NoInternetScreen();
          case signInRoute:
            return SignInScreen();
          case userExpiredRoute:
            return UserExpiredScreen();
          case dashboardRoute:
            return DashboardScreen();
          default:
            return _errorRoute();
        }
      }
    });
  }

  static _errorRoute() {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      appBar: AppBar(
        backgroundColor: CustomColor.whiteColor,
        foregroundColor: CustomColor.primaryColor,
        title: Text('Error'),
        leading: BackButton(
          onPressed: () {
            // Route dashboardRoute =
            //     MaterialPageRoute(builder: (context) => DashboardScreen());
            // Navigator.pushReplacement(context, dashboardRoute);
            if (Navigator.canPop(navigatorKey.currentState!.context)) {
              Navigator.pop(navigatorKey.currentState!.context);
            } else {
              Route dashboardRoute =
              MaterialPageRoute(builder: (context) => SignInScreen());
              Navigator.pushReplacement(navigatorKey.currentState!.context, dashboardRoute);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text('404 NOT FOUND!'),
        ),
      ),
    );
  }
}
