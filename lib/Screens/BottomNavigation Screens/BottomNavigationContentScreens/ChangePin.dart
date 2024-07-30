import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import '../../../network/response_AlterBox.dart';

class ChangePin extends StatefulWidget {
  ChangePin({super.key});

  // Email will get from register page it will be stored in OtpEmail string

  @override
  State<ChangePin> createState() => _ChangePinState();
}

final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);

class _ChangePinState extends State<ChangePin> {
  OtpTimerButtonController OtpController =
      OtpTimerButtonController(); // Otp text field controller

  late String verificationPin = ""; // for storing Verification code

  // Function will call api
  Future<void> VerificationApiCall(final pinCode) async {
    final api = ApiServices(Dio(), "/updatePin");
    dynamic pinData = json.encode({
      "newPin": "${pinCode}",
    });
    Map<String, dynamic> jsonOtpData = jsonDecode(pinData);

    try {
      final response = await api.ApiUser(jsonOtpData, context);
      String decode = response.toString();
      Map<String, dynamic> res = jsonDecode(decode);

      if (response.statusCode == 200) {
        CustomSnackBar(context, 'PIN updated successfully');
        Timer(Duration(milliseconds: 1500), () => Navigator.pop(context));
      } else {
        // Handle API error here
        print('Failed to update PIN: ${res['message']}');
      }
    } catch (error) {
      // Handle other errors, such as network errors
      print('An error occurred: $error');
    }
  }

  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return Scaffold(
      backgroundColor: Color(0xFFECEFFC),
      appBar: AppBar(
        //resizeToAvoidBottomInset: true,

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
          'Change Pin',
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
                      // gradient: LinearGradient(
                      //   colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
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
                  alignment: Alignment.centerLeft,
                  // Align the child (Text) to the left within the Container
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
                      VerificationApiCall(verificationPin);
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
                        "Change Pin",
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
          ],
        ),
      ),
    );
  }
}
