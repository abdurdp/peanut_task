import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

import '../classes/shimmer.dart';
import '../config/session.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'auth/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  final Map? supportUserInfo;

  ProfileScreen({this.supportUserInfo});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  AnimationController? modalAnimateController;

  bool isLoaded = false;

  bool isChange = false;



  bool _hasData = false;
  bool _loadingData = true;


  String fullname = "";

  String empId= "";

  String? clientId= "";

  String? clientType= "";

  String? mobile= "";

  String? email= "";

  String? user_type="";

 var  user;

  var lastFourDigits;
  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    // user info model data assign edit profile model
    // modal animation
    modalAnimateController = BottomSheet.createAnimationController(this);
    modalAnimateController?.duration = Duration(milliseconds: 500);
    modalAnimateController?.reverseDuration = const Duration(milliseconds: 500);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
   try {
     // _getLastFourNumber();

   }catch(err){
     print(err);
   }
  }
 @override
  void didChangeDependencies() {
   _getAccountInfo();
   _getLastFourNumber();
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    modalAnimateController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !_loadingData
          ? isLoaded? ListView(
              children: [
                // profile picture
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 100.0,
                      padding: EdgeInsets.all(Dimensions.extraLargerSize),
                      decoration: BoxDecoration(
                        color: CustomColor.whiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            Dimensions.extraLargerSize,
                          ),
                          bottomRight: Radius.circular(
                            Dimensions.extraLargerSize,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -Dimensions.defaultSize * 2.75,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4.0,
                            color: CustomColor.whiteColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.circleSize,
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Dimensions.circleSize,
                              ),
                              child: SvgPicture.asset(
                                      'assets/icons/avatar.svg',
                                      width: 90.0,
                                      height: 90.0,
                                    ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 6,
                              child: Container(
                                width: Dimensions.defaultSize,
                                height: Dimensions.defaultSize,
                                decoration: BoxDecoration(
                                  color: CustomColor.greenColor,
                                  border: Border.all(
                                    width: 2,
                                    color: CustomColor.whiteColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.circleSize,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),

                Visibility(
                  visible: lastFourDigits.toString().isNotEmpty,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.defaultSize,
                      right: Dimensions.defaultSize,
                      bottom: Dimensions.extraSmallSize,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColor.secondaryColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.extraSmallSize),
                    ),
                    child: ListTile(
                      dense: true,
                      minLeadingWidth: Dimensions.extraSmallSize,
                      leading: Icon(Icons.phone),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.extraSmallSize / 2,
                        horizontal: Dimensions.extraSmallSize,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Last Four Digits',
                            style: TextStyle(
                              fontSize: Dimensions.extraSmallSize,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            lastFourDigits.toString(),
                            style: TextStyle(
                              fontSize: Dimensions.defaultSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.phone),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'address',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['address'],
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Balance',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['balance'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'city',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['city'],
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'country',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['country'],
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'currency',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['currency'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'currentTradesCount',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['currentTradesCount'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'currentTradesVolume',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['currentTradesVolume'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'equity',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['equity'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'freeMargin',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['freeMargin'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'isAnyOpenTrades',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['isAnyOpenTrades'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.defaultSize,
                    right: Dimensions.defaultSize,
                    bottom: Dimensions.extraSmallSize,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.extraSmallSize),
                  ),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: Dimensions.extraSmallSize,
                    leading: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.extraSmallSize / 2,
                      horizontal: Dimensions.extraSmallSize,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'isSwapFree',
                          style: TextStyle(
                            fontSize: Dimensions.extraSmallSize,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          user['isSwapFree'].toString(),
                          style: TextStyle(
                            fontSize: Dimensions.defaultSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.extraSmallSize),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.extraSmallSize))),
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              color: CustomColor.whiteColor,
                              fontSize: Dimensions.largeTextSize),
                        ),
                      ),
                    ),
                    onTap: () async {
                      Provider.of<AuthProvider>(context, listen: false).clearSharedData();
                      Navigator.popUntil(context,(Route<dynamic> route) => false);
                      Route signInRoute =
                      MaterialPageRoute(builder: (context) => SignInScreen());
                      Navigator.push(context, signInRoute);
                    },
                  ),
                ),
              ],
            ): ListView(
              children: [
                Center(child: Text('No Data Found')),
                SizedBox(height: Dimensions.extraSmallSize),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.extraSmallSize))),
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              color: CustomColor.whiteColor,
                              fontSize: Dimensions.largeTextSize),
                        ),
                      ),
                    ),
                    onTap: () async {
                      Provider.of<AuthProvider>(context, listen: false).clearSharedData();
                      Navigator.popUntil(context,(Route<dynamic> route) => false);
                      Route signInRoute =
                      MaterialPageRoute(builder: (context) => SignInScreen());
                      Navigator.push(context, signInRoute);
                    },
                  ),
                ),
              ],
            )
          : ProfileDataShimmer(),
    );
  }

  void _getAccountInfo() async {
    var dataResponse;
    try {
      dataResponse = await Provider.of<ProfileProvider>(context, listen: false)
          .getUserProfileInfo();
      if (dataResponse == false) {
        _loadingData = false;
      } else {
        _loadingData = false;
        user = dataResponse;
        isLoaded = true;
      }
      if (mounted) setState(() {});
    } catch (err) {
      print(err);
      if (mounted) {
        setState(() {});
      }
    }
  }
  void _getLastFourNumber() async {
    var dataResponse;
    try {
      dataResponse = await Provider.of<ProfileProvider>(context, listen: false)
          .getLastFourNumber();
      if (dataResponse == false) {
        _loadingData = false;
      } else {
       lastFourDigits =dataResponse.toString();
      }
      if (mounted) setState(() {});
    } catch (err) {
      print(err);
      if (mounted) {
        setState(() {});
      }
    }
  }
}
