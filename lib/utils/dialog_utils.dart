import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peanut_task/router/route_generator.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'colors.dart';
import 'custom_style.dart';
import 'dimensions.dart';
import 'navigator_key.dart';

class DialogUtils {
  // loading
  static loading() {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.defaultSize),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: CustomColor.primaryColor,
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.defaultSize),
                  child: Text(
                    'PLEASE WAIT',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  // no internet dialog
  static noInternetDialog() {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return singleButtonStyleIsAndroid(
          context,
          'assets/images/no-internet.png',
          'png',
          'NO INTERNET TITLE',
          'CLOSE',
        );
      },
    );
  }

  static Widget singleButtonStyleIsAndroid(BuildContext context, String imgUrl,
      String imgType, String title, String btnTitle,
      [String action = '']) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        vertical: Dimensions.defaultSize,
        horizontal: Dimensions.defaultSize * 1.75,
      ),
      shape: CustomStyle.shapeOutsideStyleDialog,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imgType == 'png') ...[
            Image.asset(
              imgUrl,
              width: Dimensions.dialogImgWidth,
              height: Dimensions.dialogImgHeight,
            ),
          ] else ...[
            SvgPicture.asset(
              imgUrl,
              width: Dimensions.dialogImgWidth,
              height: Dimensions.dialogImgHeight,
            )
          ],
          SizedBox(height: Dimensions.extraSmallSize),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Dimensions.extraSmallSize * 1.5),
          GestureDetector(
            onTap: () async {
              if (action == 'logout') {
                Provider.of<AuthProvider>(context, listen: false)
                    .clearSharedData();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    splashRoute, (Route<dynamic> route) => false);
              } else {
                Navigator.pop(navigatorKey.currentContext!);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.defaultSize),
              decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.extraSmallSize),
              ),
              child: Text(
                btnTitle,
                style: TextStyle(
                  color: CustomColor.whiteColor,
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.extraSmallSize / 2),
        ],
      ),
    );
  }

  // promotional dialog
  // static promotionalDialog(data) {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: navigatorKey.currentContext!,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           titlePadding: EdgeInsets.zero,
  //           actionsPadding: EdgeInsets.zero,
  //           contentPadding: EdgeInsets.zero,
  //           shape: CustomStyle.shapeOutsideStyleDialog,
  //           content: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // title
  //               Container(
  //                 width: double.infinity,
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: Dimensions.defaultSize,
  //                   vertical: Dimensions.extraSmallSize / 2,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                     bottom: BorderSide(
  //                       width: 1,
  //                       color: CustomColor.highLightColor,
  //                     ),
  //                   ),
  //                 ),
  //                 child: ListTile(
  //                   dense: true,
  //                   contentPadding: EdgeInsets.zero,
  //                   minLeadingWidth: Dimensions.defaultSize,
  //                   leading: Icon(Icons.redeem_outlined),
  //                   title: Text(
  //                     data['title'],
  //                     style: TextStyle(
  //                       fontSize: Dimensions.defaultSize,
  //                       fontWeight: FontWeight.w700,
  //                       color: CustomColor.lightDarkerColor,
  //                     ),
  //                   ),
  //                   trailing: GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(navigatorKey.currentContext!);
  //                     },
  //                     child: Icon(Icons.close_outlined),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 alignment: Alignment.center,
  //                 child: Image.network(
  //                   data['image_url'],
  //                   width: Dimensions.dialogImgWidth * 1.5,
  //                   height: Dimensions.dialogImgHeight * 1.5,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: Dimensions.defaultSize,
  //                 ),
  //                 child: Text(
  //                   data['message'],
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               SizedBox(height: Dimensions.extraSmallSize),
  //               ElevatedButton(
  //                 style: ButtonStyle(
  //                   shape: MaterialStateProperty.all(
  //                     RoundedRectangleBorder(
  //                       borderRadius:
  //                           BorderRadius.circular(Dimensions.extraSmallSize),
  //                     ),
  //                   ),
  //                 ),
  //                 onPressed: (() async {
  //                   final Uri callLaunchUri = Uri.parse(data['video_url']);
  //                   print(callLaunchUri);
  //                   if (!await launchUrl(
  //                     callLaunchUri,
  //                     mode: LaunchMode.inAppWebView,
  //                   )) throw 'Could not launch phone app';
  //                 }),
  //                 child: Icon(
  //                   Icons.play_arrow_outlined,
  //                 ),
  //               ),
  //               SizedBox(height: Dimensions.defaultSize),
  //             ],
  //           ),
  //         );
  //       });
  // }


  // app exit/close dialog
  // dialog for close
  static Future<bool> applicationClose() async {
    bool goBack = false;
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.defaultSize),
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'EXIT' + ' ?',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: Dimensions.defaultSize),
              Text('ARE YOU SURE EXIST'),
              SizedBox(height: Dimensions.extraSmallSize * 2),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CustomStyle.shapeInsideStyleDialog,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.defaultSize,
                        ),
                      ),
                      onPressed: () async {
                        goBack = false;
                        Navigator.pop(context);
                      },
                      child: Text(
                        'NO',
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.extraSmallSize),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CustomStyle.shapeInsideStyleDialog,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.defaultSize,
                        ),
                      ),
                      onPressed: () async {
                        goBack = true;
                        SystemNavigator.pop();
                      },
                      child: Text('YES'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return goBack;
  }
}
