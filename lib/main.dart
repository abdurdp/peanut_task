import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peanut_task/providers/auth_provider.dart';
import 'package:peanut_task/providers/profile_provider.dart';
import 'package:peanut_task/router/route_generator.dart';
import 'package:peanut_task/utils/app_constant.dart';
import 'package:peanut_task/utils/colors.dart';
import 'package:peanut_task/utils/navigator_key.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;
import 'exceptions/handler.dart';

Future<void> main() async {

  HttpOverrides.global = new _HttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await runZonedGuarded(
  () async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
  runApp(
    MultiProvider(
      // provider scope
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<ProfileProvider>(),
        ),
      ],
      // provider scope
      // app scope
      child: MyApp(),
      // app scope
    ),
  );
  });
  },
    (error, stack) => ExceptionsHandler.firebaseCrashlytics.recordError(
      error,
      stack,
      fatal: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      builder: (context, navigator) {
        return Theme(
          data: ThemeData(
            primaryColor: CustomColor.primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily:  AppConstant.primaryFont,
            buttonTheme: ButtonThemeData(
              buttonColor: CustomColor.primaryColor,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: CustomColor.primaryColor,
            ),
          ).copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: CustomColor.whiteColor,
                backgroundColor: CustomColor.primaryColor,
              ),
            ),
          ),
          child: navigator!,
        );
      },
      initialRoute: splashRoute,
      onGenerateRoute: RouteGenerator.allRoutes,
    );
  }

}


class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
