import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/ChangePassword.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Assets/CustomPageRoute.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import '../network/API_Services.dart';
import '../network/response_AlterBox.dart';


class VerificationChangePassword extends StatefulWidget {
  VerificationChangePassword({super.key});

  // Email will get from register page it will be stored in OtpEmail string

  @override
  State<VerificationChangePassword> createState() =>
      _VerificationChangePasswordState();
}

int? backButton;

storeBackButtonInfo() async {
  SharedPreferences prefs1 = await SharedPreferences.getInstance();
  backButton = prefs1.getInt('validatePinBackButton');
}

// final EnterPinColor1 = Color.fromRGBO(136, 190, 192, 90); // Color
// final EnterPinColor2 = Color.fromRGBO(58, 119, 132, 60); //Color

class _VerificationChangePasswordState
    extends State<VerificationChangePassword> {
  @override
  void initState() {
    super.initState();
    storeBackButtonInfo();
  }

  OtpTimerButtonController OtpController =
      OtpTimerButtonController(); // Otp text field controller

  late String verificationPin = ""; // for storing Verification code
  String? userMail;

  // Function will call api
  PinVerificationApiCall(final pinCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMail = prefs.getString('userMail');
    print(userMail);

    // Call your API here and pass `_verificationCode` as a parameter
    final api = ApiServices(Dio(), "/verifyOTP");
    dynamic otpData = json.encode({"otp": "${pinCode}"});
    // verification code will be converted to json body
    Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
    // Api response? will get here
    final response = await api.ApiUser(jsonOtpData, context);
    //Print response? here
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');
    print(
        'response? headers: ${response.headers[HttpHeaders.authorizationHeader]}');
    // response?Data['token'] =
    //     '${response?.headers[HttpHeaders.authorizationHeader]}';
    // late var token = response?Data['token'];
    // token = token.substring(1, token.length - 1);
    // //token = token.substring(token.length);
    // token = token;
    // print(token);
    // // Shared preferences used here so we can store token which will get from api.
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString('token', token);
    // New token will be saved here
    // String decoderesponse? = response?.toString();
    // Map<String, dynamic> res = jsonDecode(decoderesponse?);

    // If api response? is true for success then will show dialog box
    if (response.statusCode == 200) {
      CustomSnackBar(context, 'PIN validated successfully');
      Navigator.pushReplacement(
          context, CustomPageRoute(child: ChangePassword()));
    } else {}
    // Printing json data which is provided to api
    print(
        "Change password OTP verification request send to api with user info: ");
    print(otpData());
  }

  // final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
  // final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);

  bool canBack = false;

  Future<bool> _onWillPopHome(BuildContext context) async {
    Navigator.pop(context);
    return canBack;
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return WillPopScope(
      onWillPop: () async {
        final showPop = await _onWillPopHome(context);
        return showPop;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFECEFFC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFECF0FD),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: BackButton(
            //color: Color(0xFF02486A),
            onPressed: () => Navigator.pop(context),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xFFB2A0FB),
            ),
          ),
          title: Text(
            'OTP Verification',
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.view_compact_alt,
          //         color: Colors.black,
          //       )),
          // ],
        ),
        // Safe area will keep screen under notification panel
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                // alignment: AlignmentDirectional.bottomCenter,
                // fit: StackFit.loose,
                children: [
                  Positioned(child: Container(
                    height: 240.h,
                    decoration: BoxDecoration(
                        color: Color(0xFFB2A0FB),
                        // gradient: LinearGradient(
                        //   colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                        border: Border.all(color: Colors.white,width: 4),
                        borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                        //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                    ),
                  )),
                  Positioned(
                    top: 12,
                    left: 80.w,
                    //height: 280.h,
                    child: Image.asset(
                      "assets/3-removebg-preview.png",
                      //alignment: Alignment.bottomRight,
                      height: 250.h,
                      // width: 300.w,
                    ),
                  ),
                ],
              ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.h,),
                      Text("Enter 6 Digit Code Sent To Your Email", style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF02486A)),),
                      SizedBox(height: 20.h,),
                      Container(
                        padding: EdgeInsets.only(left: 33),
                        alignment: Alignment.centerLeft, // Align the child (Text) to the left within the Container
                        child: Text(
                          "Enter OTP Code",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF02486A),
                          ),
                        ),
                      ),
                      //SizedBox(height: 10.h,),
                      //OTP text field
                      OtpTextField(
                        // handleControllers: TextEditingController,
                        // enabledBorderColor: EnterPinColor1,
                        // // Otp field color
                        // focusedBorderColor: EnterPinColor2,
                        // when focus on otp field
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        numberOfFields: 6,
                        margin: EdgeInsets.all(3.0),
                        fieldWidth: 60.0.w,
                        filled: true,
                        fillColor: Colors.white,
                      // fillColor: Color.fromRGBO(204, 249, 244,100),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      // borderColor: Colors.grey.shade700,
                      showFieldAsBox: true,
                      borderWidth: 1.8.w,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        BorderSide(
                          color: Color(0xff37304A),
                        );
                      },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          verificationPin = verificationCode;
                          print(verificationPin);
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // InkWell widget used to make any widget clickable so we can perform task on them
                      InkWell(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          int? unAuth = prefs.getInt('Unauthorized');
                          print(unAuth);
                          int? changePin = prefs.getInt('ChangePin');
                          print(changePin);
                          // Checking if all validation is done or not. if not then will show snack bar
                          if (verificationPin.isNotEmpty) {
                            PinVerificationApiCall(verificationPin);
                          } else if (verificationPin.isEmpty) {
                            CustomSnackBar(context, 'Please enter PIN');
                          }
                        },
                        // here Container is used to make a button.
                        child: Container(
                          height: 35.h,
                          width: 140.h,
                          //width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFB2A0FB),
                            // gradient: LinearGradient(
                            //   begin: Alignment.bottomLeft,
                            //   end: Alignment.topRight,
                            //   colors: [
                            //     EnterPinColor1, // Color
                            //     EnterPinColor2, // Color
                            //   ],
                            // ),
                            // color: PrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0.r)),
                          ),
                          child: Center(
                            // Text widget used to display any text on screen
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
          
                    ],
                  ),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
