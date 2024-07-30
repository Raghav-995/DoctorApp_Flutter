import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../network/response_AlterBox.dart';

class ProfilePin extends StatefulWidget {
  ProfilePin({super.key});

  // Email will get from register page it will be stored in OtpEmail string

  @override
  State<ProfilePin> createState() => _ProfilePinState();
}

int? setPinBackButton;

storeBackButtonInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setPinBackButton = prefs.getInt('setPinBackButton');
}

// final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
// final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);

class _ProfilePinState extends State<ProfilePin> {
  OtpTimerButtonController otpController =
      OtpTimerButtonController(); // Otp text field controller

  late String verificationPin = ""; // for storing Verification code

  // Function will call api
  setPinApiCall(final pinCode) async {
    // Call your API here and pass `_verificationCode` as a parameter
    final api = ApiServices(Dio(), "/setPin");
    dynamic pinData = json.encode({"pin": pinCode});
    // verification code will be converted to json body
    Map<String, dynamic> jsonOtpData = jsonDecode(pinData);
    // Api response? will get here
    final response = await api.ApiUser(jsonOtpData, context);
    //Print response? here
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');

    //response? decoding from json to Map string
    String decode = response.toString();
    Map<String, dynamic> responseData = jsonDecode(decode);
    jsonDecode(decode);
    print(responseData['message']);

    int? backButton;
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    backButton = await prefs1.getInt('BackButton');
    print('App prefs BackButton : ${backButton}');

    // If api response? is true for success then will show dialog box
    if (response.statusCode == 200) {
      int pinSwitchOn = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('pinSwitchOn', pinSwitchOn);
      CustomSnackBar(context, 'PIN set successfully');

      backButton == 0 || backButton == null
          ? Timer(Duration(milliseconds: 1500), () => Navigator.pop(context))
          : Timer(Duration(milliseconds: 1500),
              () => Navigator.pop(context, pinSwitchOn));
    } else {}
    // Printing json data which is provided to api
    print("SET PIN request send to api");
    // print(pinData());
  }

  bool canBack = false;
  bool isButtonPressed = false;
  Future<bool> _onWillPopHome(BuildContext context) async {
    int pinSwitchOn = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pinSwitchOn', pinSwitchOn);
    print('PinSwitchOn : ${pinSwitchOn}');

    if (setPinBackButton == 0) {
      Navigator.pop(context);
    } else if (setPinBackButton == 1) {
      bool canBack = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFFB2A0FB),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
          title: new Text(
            'Are you sure?',
            style: TextStyle(color: Colors.white),
          ),
          content: new Text(
            'Do you want to exit an app',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              // onPressed: (){
              //   exit(0); // Exit the app
              // },
              child: new Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
      return canBack;
    } else {}
    return canBack;
  }

  @override
  void initState() {
    super.initState();
    storeBackButtonInfo();
    // SetPin();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return Scaffold(
      backgroundColor: Color(0xFFECEFFC),
      appBar: AppBar(
        //resizeToAvoidBottomInset: true,

        elevation: 0,
        backgroundColor: Colors.white,
        // automaticallyImplyLeading: SetPinBackButton == 1 ? false : true,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Color(0xff02486A),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            //color: Color(0xFFB2A0FB),
          ),
        ),
        title: Text(
          'Set Pin',
          style: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff02486A)),
        ),
      ),
      // Safe area will keep screen under notification panel
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              //overflow: Overflow.clip,
              alignment: AlignmentDirectional.bottomCenter,
              fit: StackFit.loose,
              children: [
                Positioned(
                    child: Container(
                  height: 240.h,
                  decoration: BoxDecoration(
                      color: Color(0xFFB2A0FB),
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                      //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                      ),
                )),
                Positioned(
                  top: 2.h,
                  //height: 280.h,
                  child: Image.asset(
                    "assets/DreamShaper_v7_a_futuristic_baby_vibrant_colour_dinosaur_in_cl_0-removebg-preview.png",
                    //alignment: Alignment.bottomRight,
                    height: 250.h,
                    // width: 300.w,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Set 6 Digit Code Pin Code",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF02486A)),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 33),
                  alignment: Alignment
                      .centerLeft, // Align the child (Text) to the left within the Container
                  child: Text(
                    "Enter Pin Code",
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
                InkWell(
                  onTapDown: (_) {
                    setState(() {
                      isButtonPressed = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      isButtonPressed = false;
                    });
                  },
                  onTap: () {
                    // Checking if all validation is done or not. if not then will show snack bar
                    if (verificationPin.isNotEmpty) {
                      setState(() {
                        setPinApiCall(verificationPin);
                      });
                    } else {
                      CustomSnackBar(context, 'Please enter PIN');
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: 40.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      color: isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                      //border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Set Pin",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Image.asset(
            //   "assets/64-removebg-preview (1) 1.png",
            //   height: 250.h,
            // ),
          ],
        ),
      ),
    );
  }
}

// here Cont
