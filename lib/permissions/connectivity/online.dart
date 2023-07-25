import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/scheduler.dart';

import '../../services/connectivity_services.dart';
import '../../utils/colors.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

class Online extends StatefulWidget {
  final Widget child;
  Online({required this.child});

  @override
  _OnlineState createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  bool isChecking = false;
  bool isConnectivityDialogShowing = false;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void didChangeDependencies() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // for connectivity
      connectivitySubscription = connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) async {
        await Future.delayed(Duration(seconds: 1), () async {
          if (ConnectivityResult.none == result) {
            if (!isConnectivityDialogShowing) {
              if (mounted) {
                noInternetDialog(context);
              }
            }
          } else {
            try {
              bool isPing = await ConnectivityServices.isPing();
              if (isPing) {
                if (isConnectivityDialogShowing) {
                  if (mounted) {
                    Navigator.pop(context);
                  }
                  isConnectivityDialogShowing = false;
                }
              }
            } on SocketException catch (e) {
              debugPrint(e.toString());
            }
          }
        });
      });
    });
    super.didChangeDependencies();
  }

  @override
  dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // no internet dialog
  void noInternetDialog(BuildContext context) {
    isConnectivityDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: CustomColor.primaryColor.withOpacity(0.1),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Dimensions.defaultSize,
                  horizontal: Dimensions.defaultSize * 1.75,
                ),
                actionsPadding: EdgeInsets.zero,
                shape: CustomStyle.shapeOutsideStyleDialog,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/no-internet.png',
                      width: Dimensions.dialogImgWidth,
                      height: Dimensions.dialogImgHeight,
                    ),
                    SizedBox(height: Dimensions.defaultSize / 2),
                    Text(
                      'NO INTERNET',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColor.primaryColor.withOpacity(0.8),
                        fontSize: Dimensions.extraSmallSize + 2,
                      ),
                    ),
                    SizedBox(height: Dimensions.defaultSize),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isChecking = true;
                        });
                        Future.delayed(Duration(seconds: 2), () async {
                          if (mounted) {
                            bool isPing = await ConnectivityServices.isPing();
                            if (isPing) {
                              if (isConnectivityDialogShowing) {
                                isConnectivityDialogShowing = false;
                                Navigator.pop(context);
                              }
                            } else {
                              setState(() {
                                isChecking = false;
                              });
                            }
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
              );
            },
          ),
        );
      },
    );
  }
}
