import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';

class CustomStyle {


  static var textStyle =
      TextStyle(color: CustomColor.greyColor, fontSize: Dimensions.defaultSize);

  static var hintTextStyle = TextStyle(
      color: Colors.grey.withOpacity(0.5), fontSize: Dimensions.defaultSize);

  static var listStyle = TextStyle(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.defaultSize,
    fontWeight: FontWeight.normal,
  );

  static var defaultStyle = TextStyle(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.largeTextSize,
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: CustomColor.primaryColor.withOpacity(0.1),
      width: 0,
    ),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: CustomColor.primaryColor.withOpacity(0.1),
      width: 0,
    ),
  );

  static var searchBox = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: CustomColor.primaryColor.withOpacity(0.1),
      width: 0,
    ),
  );

  static RoundedRectangleBorder shapeOutsideStyleDialog =
      RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      Dimensions.defaultSize + Dimensions.veryTinySize / 2,
    ),
  );

  static RoundedRectangleBorder shapeOutsideStyleImgPickerDialog =
      RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        Dimensions.defaultSize + Dimensions.veryTinySize / 2,
      ),
      topRight: Radius.circular(
        Dimensions.defaultSize + Dimensions.veryTinySize / 2,
      ),
    ),
  );

  static RoundedRectangleBorder shapeInsideStyleDialog = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      Dimensions.extraSmallSize,
    ),
  );

  static RoundedRectangleBorder shapeStyleModal = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        Dimensions.defaultSize + Dimensions.veryTinySize / 2,
      ),
      topRight: Radius.circular(
        Dimensions.defaultSize + Dimensions.veryTinySize / 2,
      ),
    ),
  );



  static var textStyleSmall = TextStyle(
      color: CustomColor.greyColor, fontSize: 14);

  static var textStyleSmallSelected = TextStyle(
      color: CustomColor.primaryColor, fontSize: 14);

  static var appBarTextStyle = TextStyle(
      color: Colors.white, fontSize: Dimensions.defaultTextSize);

}
