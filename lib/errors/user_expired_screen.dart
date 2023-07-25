import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peanut_task/router/route_generator.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class UserExpiredScreen extends StatelessWidget {
  const UserExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<AuthProvider>(context, listen: false).clearSharedData();
        Navigator.pushReplacementNamed(context, splashRoute);
        return true;
      },
      child: Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: CustomColor.whiteColor,
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: Platform.isAndroid
              ? SystemUiOverlayStyle(
                  statusBarColor: CustomColor.primaryColor,
                  statusBarBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarColor: CustomColor.backgroundColor,
                  systemNavigationBarIconBrightness: Brightness.dark,
                )
              : null,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Dimensions.defaultSize * 1.5),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/sad.png',
                      width: Dimensions.extraLargerSize * 3,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'EXPIRED',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'TOKEN EXPIRE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 28.0),
                    GestureDetector(
                      onTap: () async {
                        Provider.of<AuthProvider>(context, listen: false)
                            .clearSharedData();
                        Navigator.pushReplacementNamed(context, splashRoute);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(Dimensions.defaultSize),
                        decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.extraSmallSize),
                        ),
                        child: Text('CLOSE',
                          style: TextStyle(
                            color: CustomColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
