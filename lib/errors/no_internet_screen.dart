import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../router/route_generator.dart';
import '../services/connectivity_services.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool isChecking = false;
  // declare a timer
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        bool isOnline = await ConnectivityServices().connectivityResult();
        if (isOnline) {
          timer.cancel();
          if (mounted) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  splashRoute, (Route<dynamic> route) => false);
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/no-internet.svg',
                color: Colors.grey.shade400,
                width: 150,
              ),
              SizedBox(height: 20.0),
              Text(
                'NO CONNECTION_TITLE',
                style: TextStyle(
                  color: CustomColor.primaryColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'PLEASE CONNECT To INTERNET',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isChecking = true;
                  });
                  Future.delayed(Duration(seconds: 1), () async {
                    bool isOnline =
                        await ConnectivityServices().connectivityResult();
                    if (isOnline) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          dashboardRoute, (Route<dynamic> route) => false);
                    } else {
                      setState(() {
                        isChecking = false;
                      });
                    }
                  });
                },
                child: isChecking
                    ? SizedBox(
                        width: Dimensions.defaultSize,
                        height: Dimensions.defaultSize,
                        child: CircularProgressIndicator(
                          color: CustomColor.whiteColor,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        'TRY AGAIN',
                      ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(160, 46)),
                  backgroundColor: MaterialStateProperty.all(
                    CustomColor.primaryColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.circleSize,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
