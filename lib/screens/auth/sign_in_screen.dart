import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:provider/provider.dart';

import '../../config/session.dart';
import '../../model/body/login.dart';
import '../../providers/auth_provider.dart';
import '../../router/route_generator.dart';
import '../../utils/application_utils.dart';
import '../../utils/colors.dart';
import '../../utils/custom_style.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/dimensions.dart';
import '../../utils/form_utils.dart';
import '../../utils/navigator_key.dart';


//ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  String? from;

  SignInScreen({Key? key, this.from}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController loginNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _toggleVisibility = true;

  late LoginModel loginModel;

  String mobileNum = "";

  String? fcmToken;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _asyncMethod();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void dispose() {
    loginNumberController.clear();
    passwordController.clear();
    super.dispose();
  }

  _asyncMethod() async {
    mobileNum = await Session().username().toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        return true;
      },
      child: Scaffold(

        backgroundColor: CustomColor.whiteColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: signInWidget(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInWidget(BuildContext context) {
    final loginNumberValidator = FormUtils.loginNumberValidator;
    final passwordValidator = RequiredValidator(
      errorText: 'PASSWORD_FIELD_REQUIRED',
    );
    return Container(
      padding: EdgeInsets.all(
        Dimensions.defaultSize,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: Navigator.canPop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: CustomColor.primaryColor,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.extraLargerSize * 2),
          Text(
           'SIGN IN' ',',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.extraLargeSize * 1.75,
            ),
          ),
          SizedBox(
            height: Dimensions.extraSmallSize,
          ),
          Text(
            'TO YOUR ACCOUNT',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.extraLargeSize,
            ),
          ),
          SizedBox(
            height: Dimensions.extraSmallSize * 5,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: loginNumberController,
                  keyboardType: TextInputType.text,
                  validator: loginNumberValidator,
                  onSaved: (input) => loginModel.login = input,
                  cursorColor: CustomColor.primaryColor,
                  decoration: InputDecoration(
                    labelText:
                        'ENTER LOGIN NUMBER' + ' *',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    filled: true,
                    fillColor: CustomColor.whiteColor,
                    hintStyle: CustomStyle.textStyle,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: CustomColor.redColor.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    counterText: '',
                  ),
                ),
                SizedBox(
                  height: Dimensions.extraSmallSize,
                ),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: passwordController,
                  validator: passwordValidator,
                  onSaved: (input) => loginModel.password = input,
                  cursorColor: CustomColor.primaryColor,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD' + ' *',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: CustomColor.redColor.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: CustomColor.whiteColor,
                    hintStyle: CustomStyle.textStyle,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _toggleVisibility = !_toggleVisibility;
                        });
                      },
                      icon: _toggleVisibility
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                    ),
                  ),
                  obscureText: _toggleVisibility,
                ),
                SizedBox(height: Dimensions.extraSmallSize - 4),
                SizedBox(height: Dimensions.extraSmallSize * 2),
                GestureDetector(
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.extraSmallSize))),
                    child: Center(
                      child: Text('SIGN IN',
                        style: TextStyle(
                            color: CustomColor.whiteColor,
                            fontSize: Dimensions.largeTextSize),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (loginNumberController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      required();
                      return;
                    } else {
                      loginModel = LoginModel(
                        login: loginNumberController.value.text,
                        password: passwordController.value.text
                    );
                        FocusScope.of(context).unfocus();
                        DialogUtils.loading();
                        await Provider.of<AuthProvider>(context, listen: false)
                            .login(loginModel, route);
                    }
                  },
                ),
                SizedBox(
                  height: Dimensions.extraSmallSize * 2,
                ),
                SizedBox(
                  height: Dimensions.extraSmallSize * 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // form save validation
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // after form submit response
  route(bool isRoute, Map response) async {
    Navigator.pop(context);
    if (isRoute) {
      if (response['result'] != true) {
        ApplicationUtils.showErrorSnackbar(
          context,
          'Login Failed',
        );
      } else if (response['result'] == true) {
        ApplicationUtils.showSuccessSnackbar(
          context,
          'Login Success',
        );
        Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
            dashboardRoute, (Route<dynamic> route) => false);
      } else {
        ApplicationUtils.showErrorSnackbar(
          context,
          'Something went wrong',
        );
      }
    } else {
      ApplicationUtils.showErrorSnackbar(
          context, 'ERROR');
    }
  }

  // empty validation message
  required() {
    ApplicationUtils.showErrorSnackbar(
        context,'ERROR ALL FIELD REQUIRED');
  }
}
