import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Assets/CustomPageRoute.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import '../network/EnterPinApi.dart';
import '../network/response_AlterBox.dart';
import 'BottomNavigation Screens/BottomNavigationContentScreens/ChangePassword.dart';
import 'EnterPassword.dart';

class EnterPin extends StatefulWidget {
  EnterPin({super.key});

  // Email will get from register page it will be stored in OtpEmail string

  @override
  State<EnterPin> createState() => _EnterPinState();
}

int? backButton;

storeBackButtonInfo() async {
  SharedPreferences prefs1 = await SharedPreferences.getInstance();
  backButton = prefs1.getInt('validatePinBackButton');
}


class _EnterPinState extends State<EnterPin> {
  @override
  void initState() {
    super.initState();
    storeBackButtonInfo();
  }

  OtpTimerButtonController OtpController =
      OtpTimerButtonController(); // Otp text field controller

  late String _verificationPin = ""; // for storing Verification code
  bool _isButtonPressed = false;
  String? userMail;

  // Function will call api
  PinVerificationApiCall(final pinCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMail = prefs.getString('userMail');
    print(userMail);

    // Call your API here and pass `_verificationCode` as a parameter
    final api = EnterPinApiServices(Dio(), "/validatePin");
    dynamic otpData =
        json.encode({"pin": "${pinCode}", "email": "${userMail}"});
    // verification code will be converted to json body
    Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
    // Api response? will get here
    final response = await api.ApiUser(jsonOtpData, context);
    //Print response? here
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');
    print(
        'response? headers: ${response.headers[HttpHeaders.authorizationHeader]}');
    // New token will be saved here
    String decodeResponse = response.toString();
    Map<String, dynamic> res = jsonDecode(decodeResponse);
    res['token'] = '${response.headers[HttpHeaders.authorizationHeader]}';
    late var token = res['token'];
    token = token.substring(1, token.length - 1);
    print(token);
    // Shared preferences used here so we can store token which will get from api.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);

    //response? decoding from json to Map string
    String decode = response.toString();
    Map<String, dynamic> responseData = jsonDecode(decode);
    print(responseData['message']);
    // If api response? is true for success then will show dialog box
    if (response.statusCode == 200) {
      CustomSnackBar(context, 'PIN validated successfully');
      Navigator.pop(context);
    } else {}
    // Printing json data which is provided to api
    print("Enter Pin request send to api with user info: ");
    print(otpData());
  }

  ChangePinValidationApi(final pinCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMail = prefs.getString('userMail');
    print(userMail);
    final api = EnterPinApiServices(Dio(), "/validatePin");
    dynamic otpData =
        json.encode({"pin": "${pinCode}", "email": "${userMail}"});
    // verification code will be converted to json body
    Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
    // Api response? will get here
    final response = await api.ApiUser(jsonOtpData, context);
    //Print response? here
    print('response? status: ${response.statusCode}');
    print('response? body: ${response.data}');
    String decodeResponse = response.toString();
    Map<String, dynamic> res = jsonDecode(decodeResponse);
    res['token'] = '${response.headers[HttpHeaders.authorizationHeader]}';
    late var token = res['token'];
    token = token.substring(1, token.length - 1);
    print(token);
    // Shared preferences used here so we can store token which will get from api.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);

    // If api response? is true for success then will show dialog box
    if (response.statusCode == 200) {
      CustomSnackBar(context, 'PIN validated successfully');
      Navigator.pushReplacement(
          context, CustomPageRoute(child: ChangePassword()));
    } else {}
  }


  bool canBack = false;

  Future<bool> _onWillPopHome(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? changePin = prefs.getInt('ChangePin');
    print('ChangePin : ${changePin}');

    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    int? unAuth = prefs1.getInt('Unauthorized');
    print('UnAuth : ${unAuth}');
    changePin == 0 ? Navigator.pop(context) : null;
    if (unAuth == 1) {
      bool canBack = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFFB2A0FB),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
          title: new Text('Are you sure?',style: TextStyle(color: Colors.white),),
          content: new Text('Do you want to exit an app', style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No',style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('Yes',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      );
      return canBack;
    }
    return canBack;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return WillPopScope(
      onWillPop: () async {
        final showPop = await _onWillPopHome(context);
        return showPop;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   // automaticallyImplyLeading: false,
        //   // leading: backButton == 1
        //   //     ? BackButton(
        //   //         color: Colors.white,
        //   //         onPressed: () => Navigator.pop(context),
        //   //       )
        //   //     : null,
        //   centerTitle: true,
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //       color: Color(0xFFB2A0FB),
        //       // gradient: LinearGradient(
        //       //   begin: Alignment.bottomLeft,
        //       //   end: Alignment.topRight,
        //       //   colors: [
        //       //     AppBarColor1,
        //       //     AppBarColor2,
        //       //   ],
        //       // ),
        //     ),
        //   ),
        //   title: Text(
        //     'Authentication Required',
        //     style: TextStyle(
        //         fontFamily: 'Roboto-Regular',
        //         fontSize: 32.sp,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white),
        //   ),
        // ),
        // Safe area will keep screen under notification panel
        body: SafeArea(
          // Container used to take whole screen size with media query.
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: Colors.white,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white, width: 7),
              borderRadius: BorderRadius.circular(30),
            ),
            // All widgets will bw in list view.
            child: Stack(
                children: [
            Positioned(
            child: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
            //color: const Color(0xff333366),
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
          //borderRadius: BorderRadius.circular(30)
        ),
        constraints: BoxConstraints(maxWidth: width, maxHeight: 350),
      ),
    ),
              GestureDetector(
              onTap: () {
                Navigator.pop(context);
              //_showAlertDialog(context);
              },
              child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 35,
              ),
              ),
              ),
              Positioned(
              top: 10,
              //right: 0,
              left: 30,
              //bottom: 5,
              height: 260.0.h,
              //height: MediaQuery.of(context).size.height * 0.49,
              child: ClipRRect(
              child: Image.asset("assets/Dio-01 1.png"),
              ),
              ),

              Positioned(
              top: MediaQuery.of(context).size.height * 0.46,

              child: Container(
              width: 430.0.w,

              child: Padding(
              //padding: const EdgeInsets.all(8.0),
              padding: EdgeInsets.fromLTRB(20.0.w, 0.0.h, 0.0.w, 0.0.h),

              child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // Image.asset(
              //   "assets/ChangePasswordDyno.png",
              //   height: 250.0.h,
              // ),
              SizedBox(
              height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                //textAlign: TextAlign.left,
                "Enter your pin",
                style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                color: Color(0xff37304A)),
                ),
              ),
              const SizedBox(
              height: 20,
              ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // SizedBox(
          //   height: 30.h,
          // ),
          // // Image will appear in circle by using this widget with editable background color
          // CircleAvatar(
          //   backgroundColor: Color.fromRGBO(136, 190, 192, 150),
          //   radius: 130.0.r,
          //   child: Image.asset(
          //     "assets/EnterPin.png",
          //     // height: 450.h,
          //   ),
          //),


          //OTP text field
          OtpTextField(
            //handleControllers: OtpFieldController,
            //enabledBorderColor: EnterPinColor1,
            // Otp field color
            //focusedBorderColor: EnterPinColor2,
            // when focus on otp field
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            numberOfFields: 6,
            margin: EdgeInsets.all(4.0),
            fieldWidth: 57.0.w,

            filled: true,
            fillColor: Colors.white,
            borderRadius:
            BorderRadius.all(Radius.circular(8.0)),
            // borderColor: Colors.grey.shade700,
            showFieldAsBox: true,
            borderWidth: 1.8.w,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              BorderSide(
                color: Color(0xFF37304A),
              );
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              //_verificationPin = verificationCode;
              setState(() {
                _verificationPin = verificationCode;
              });
              print(_verificationPin);
            },
          ),
          SizedBox(
            height: 50.h,
          ),
          // InkWell widget used to make any widget clickable so we can perform task on them
          InkWell(
            onTapDown: (_) {
              setState(() {
                _isButtonPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isButtonPressed = false;
              });
            },
            onTap: () async {
              final SharedPreferences prefs =
              await SharedPreferences.getInstance();
              int? unAuth = prefs.getInt('Unauthorized');
              print(unAuth);
              int? changePin = prefs.getInt('ChangePin');
              print(changePin);
              // Checking if all validation is done or not. if not then will show snack bar
              if (changePin == 0 && _verificationPin.isNotEmpty) {
                final SharedPreferences prefs =
                await SharedPreferences.getInstance();
                prefs.setInt('ChangePin', 1);
                ChangePinValidationApi(_verificationPin);
              }
              else if (changePin == 1 && _verificationPin.isNotEmpty) {
                final SharedPreferences prefs =
                await SharedPreferences.getInstance();
                prefs.setInt('ChangePin', 1);
                ChangePinValidationApi(_verificationPin);
              }else if (unAuth == 1 &&
                  _verificationPin.isNotEmpty) {
                final SharedPreferences prefs =
                await SharedPreferences.getInstance();
                prefs.setInt('Unauthorized', 0);
                PinVerificationApiCall(_verificationPin);
              } else if (_verificationPin.isEmpty) {
                CustomSnackBar(context, 'Please enter PIN');
              }
            },
            // here Container is used to make a button.
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 45.h,
              //width: double.infinity,
              decoration: BoxDecoration(
                color: _isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                // Text widget used to display any text on screen
                child: Text(
                  "Continue",
                  style: TextStyle(
                    //height: 2.5.h,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: _isButtonPressed ? Color(0xFFB2A0FB) : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: 20.sp),
            ),
            onPressed: () {
              Navigator.push(
                  context, CustomPageRoute(child: EnterPassword()));
            },
            child: Text(
              'Forgot Pin',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Roboto-Regular',
                  color: Color(0xFF02486A),
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ]
    ),
    ),
    ),
    ),

    ]
          ),
        ),
      ),
    ),

    );
  }
}

