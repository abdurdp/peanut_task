import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_constant.dart';
import 'colors.dart';
import 'dimensions.dart';
import 'navigator_key.dart';

class ApplicationUtils {
  static showErrorSnackbar(BuildContext context, dynamic text) {
    final snackBar = SnackBar(
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.defaultSize,
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColor.redColor.withOpacity(0.5),
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
          leading: Icon(
            Icons.error_outline,
            color: CustomColor.whiteColor,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: CustomColor.whiteColor,
              fontSize: Dimensions.defaultSize - 2,
              fontFamily:  AppConstant.primaryFont,
            ),
          ),
        ),
      ),
      backgroundColor: CustomColor.redColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.defaultSize),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showSuccessSnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.defaultSize,
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColor.greenColor.withOpacity(0.5),
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
          leading: Icon(
            Icons.check_circle_outline,
            color: CustomColor.whiteColor,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: CustomColor.whiteColor,
              fontSize: Dimensions.defaultSize - 2,
              fontFamily:AppConstant.primaryFont,
            ),
          ),
        ),
      ),
      backgroundColor: CustomColor.greenColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.defaultSize),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  String returnMonth(DateTime date) {
    return new DateFormat.MMMM().format(date);
  }

  String returnDay(DateTime date) {
    return new DateFormat.d().format(date);
  }

  static String returnHour(double minute) {
    DateTime now = DateTime.now();
    Duration difference = Duration(minutes: minute.toInt());
    final today =
        DateTime(now.year).add(difference).subtract(const Duration(days: 1));
    return '${today.hour}';
  }

  dynamic durationToString(double minutes) {
    if (minutes >= 60) {
      var d = Duration(minutes: minutes.toInt());
      List<String> parts = d.toString().split(':');
      if (parts[0] == '0' || parts[0] == 0) {
        return parts[0];
      } else if (parts[1] == '0' || parts[1] == 0) {
        return parts[1];
      } else {
        return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
      }
    }
    return minutes;
  }

  static String mapStyle =
      '[{"featureType":"all","elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#333333"},{"lightness":40}]},{"featureType":"all","elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#ffffff"},{"lightness":16}]},{"featureType":"all","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#fefefe"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#fefefe"},{"lightness":17},{"weight":1.2}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":20}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":21}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#dedede"},{"lightness":21}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffffff"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#ffffff"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":16}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#f2f2f2"},{"lightness":19}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#e9e9e9"},{"lightness":17}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#cfd7e9"}]}]';

  static codeToFlag(String countryCode) {
    countryCode = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return countryCode;
  }


}

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Constants {
  static const double avatarMaxWidth = 400;
  static const double avatarMaxHeight = 400;
}

class TextStyles {
  static const defaultStyle = TextStyle(
    color: RGB.whiteColor,
    fontSize: Dimensions.defaultSize,
  );

  static const smallLightStyle = TextStyle(
    color: RGB.whiteColor,
    fontSize: Dimensions.smSize,
  );

  static const darkStyle = TextStyle(
    color: RGB.lightDarkerColor,
    fontSize: Dimensions.defaultSize,
  );

  static const titleDarkStyle = TextStyle(
    color: RGB.lightDarkerColor,
    fontSize: Dimensions.defaultSize + 2,
    fontWeight: FontWeight.w600,
  );
}



class RGB {
  static const primaryColor = Color(0xFF389471);
  static const lightPrimary = Color(0xFFe9eefb);
  static const primaryLightColor = Color(0xFF7eceaf);
  static const primaryLighterColor = Color(0xFFb5e3d1);
  static const primaryDarkColor = Color(0xFF236b76);
  static const secondaryColor = Color(0xFFE0A553);
  static const darkColor = Color(0xFF343536);
  static const darkLightColor = Color(0xFF646464);
  static const borderColor = Color(0xFFEEEEEE);
  static const whiteColor = Color(0xFFFFFFFF);
  static const lightColor = Color(0xFFE7E7E7);
  static const lighterColor = Color(0xFFF9F9F9);
  static const bgColor = Color(0xFFedf8f4);

  static const successColor = Color(0xFF309397);

  static const lightYellowColor = Color(0xFFFFF9EC);
  static const lightYellow2Color = Color(0xFFFFE4C7);
  static const darkYellowColor = Color(0xFFF9BE7C);
  static const palePinkColor = Color(0xFFFED4D6);
  static const redColor = Color(0xFFE46472);
  static const lavenderColor = Color(0xFFD5E4FE);
  static const blueColor = Color(0xFF6488E4);
  static const lightGreenColor = Color(0xFFD9E6DC);
  static const greenColor = Color(0xFF309397);
  static const darkBlueColor = Color(0xFF0D253F);

  static const emeraldColor = Color(0xff2b9b70);
  static const purpleColor = Color(0xff482771);
  static const greyColor = Color(0xffe0deea);
  static const sageGreenColor = Color(0xffB2AC88);
  static const naviBlueColor = Color(0xff000080);

  static const darkYellow2Color = Color(0xfffebc20);
  static const lightPurpleColor = Color(0xffc8bdd5);

  static const pinkColor = Color(0xffEE0263);
  static const tealBlueColor = Color(0xff1EA1A1);
  static const tealGreenColor = Color(0xff006D5B);
  static const turquoiseColor = Color(0xff30D5C8);
  static const brightWhiteColor = Color(0xffFDFEFF);
  static const biegeColor = Color(0xffF5F5DC);
  static const rubyRedColor = Color(0xff9b111e);
  static const mintGreenColor = Color(0xff3EB489);

  // light color theme
  static const lightDarkerColor = Color(0xFF808080);
  static const dangerLightColor = Color(0xFFFA8585);
  static const dangerLighterColor = Color(0xFFFEE7E7);
  static const blueLightColor = Color(0xFF809BFF);
  static const blueLighterColor = Color(0xFFe6ebff);
  static const succeeLightColor = Color(0xFF10B981);
  static const succeeLighterColor = Color(0xFFECFDF5);
  static const purpleLightColor = Color(0xFFde6fff);
  static const purpleLighterColor = Color(0xFFFAF5FF);
  static const cyanLightColor = Color(0xFF06B6D4);
  static const cyanLighterColor = Color(0xFFECFEFF);
  static const orangeLightColor = Color(0xFFF97316);
  static const orangeLighterColor = Color(0xFFFFF7ED);
  static const mutedColor = Color(0xFFdee2e6);
  // other color
  static const coffeeColor = Color(0xFF553939);
  static const sageColor = Color(0xFF94B49F);
}

class Forms {
  static final primaryBtn = ElevatedButton.styleFrom(
    backgroundColor: RGB.primaryColor,
  );
  static final secondaryBtn = ElevatedButton.styleFrom(
    backgroundColor: RGB.primaryColor,
  );
  static final primaryBtnRounded = ElevatedButton.styleFrom(
    backgroundColor: RGB.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.defaultSize * 100),
    ),
  );
  static final secondaryBtnRounded = ElevatedButton.styleFrom(
    backgroundColor: RGB.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.defaultSize * 100),
    ),
  );

  static inputStyle({
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? suffixOnPressed,
    bool? passwordVisibility,
    required String hintText,
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon != null
          ? Icon(
        prefixIcon,
        size: Dimensions.lgSize,
      )
          : null,
      suffixIcon: suffixOnPressed != null
          ? IconButton(
        onPressed: () {
          suffixOnPressed.call();
        },
        icon: passwordVisibility!
            ? const Icon(
          Icons.visibility_outlined,
          color: RGB.lightDarkerColor,
        )
            : const Icon(
          Icons.visibility_off_outlined,
          color: RGB.lightDarkerColor,
        ),
      )
          : suffixIcon != null
          ? Icon(suffixIcon)
          : null,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: RGB.lightDarkerColor,
        ),
      ),
      hintText: hintText,
      fillColor: RGB.whiteColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.borderColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.borderColor,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.lightDarkerColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.lightDarkerColor,
          width: 1,
        ),
      ),
      contentPadding: const EdgeInsets.all(
        Dimensions.defaultSize / 1.25,
      ),
      counterText: '',
    );
  }
}

class Toast {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
      {required String title, required bool isError}) {
    return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(title),
        backgroundColor: isError ? RGB.dangerLightColor : RGB.succeeLightColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}