// import 'dart:convert';
// import 'dart:io';
// import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/ChangePin.dart';
// import 'package:Seerecs/Screens/BottomNavigation.dart';
// import 'package:Seerecs/Screens/LoginScreen.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../Assets/CustomPageRoute.dart';
// import 'package:otp_timer_button/otp_timer_button.dart';
// import '../../network/EnterPinApi.dart';
// import '../../network/response?_AlterBox.dart';
// import '../network/DioExceptions.dart';
// import 'EnterPassword.dart';
// //import 'Screens/BottomNavigation Screens/BottomNavigationContentScreens/ChangePassword.dart';
// //import 'Screens/EnterPassword.dart';
// //import 'EnterPassword.dart';
//
// class PinAuth extends StatefulWidget {
//   PinAuth({super.key});
//
//   // Email will get from register page it will be stored in OtpEmail string
//
//   @override
//   State<PinAuth> createState() => _PinAuthState();
// }
//
// int? backButton;
//
// StoreBackButtonInfo() async {
//   SharedPreferences prefs1 = await SharedPreferences.getInstance();
//   backButton = prefs1.getInt('ValidatePinBackButton');
// }
//
// final EnterPinColor1 = Color.fromRGBO(136, 190, 192, 90); // Color
// final EnterPinColor2 = Color.fromRGBO(58, 119, 132, 60); //Color
//
// class _PinAuthState extends State<PinAuth> with TickerProviderStateMixin{
//   int incorrectAttempts = 0;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   StoreBackButtonInfo();
//   // }
//   late AnimationController _controller;
//   @override
//   void initState() {
//     super.initState();
//     StoreBackButtonInfo();
//
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 50),
//       vsync: this,
//     );
//   }
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   OtpTimerButtonController OtpController =
//   OtpTimerButtonController(); // Otp text field controller
//
//   late String _verificationPin = ""; // for storing Verification code
//
//   String? userMail;
//
//   // Function will call api
//   PinVerificationApiCall(final pinCode) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userMail = prefs.getString('userMail');
//     print(userMail);
//
//     // Call your API here and pass `_verificationCode` as a parameter
//     final api = EnterPinApiServices(Dio(), "/validatePin");
//     dynamic otpData =
//     json.encode({"pin": "${pinCode}", "email": "${userMail}"});
//     // verification code will be converted to json body
//     Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
//     // Api response? will get here
//     final response? = await api.ApiUser(jsonOtpData, context);
//     //Print response? here
//     print('response? status: ${response?.statusCode}');
//     print('response? body: ${response?}');
//     print(
//         'response? headers: ${response?.headers[HttpHeaders.authorizationHeader]}');
//     // New token will be saved here
//     String decoderesponse? = response?.toString();
//     Map<String, dynamic> res = jsonDecode(decoderesponse?);
//     res['token'] = '${response?.headers[HttpHeaders.authorizationHeader]}';
//     late var token = res['token'];
//     token = token.substring(1, token.length - 1);
//     print(token);
//     // Shared preferences used here so we can store token which will get from api.
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setString('token', token);
//
//     //response? decoding from json to Map string
//     String decode = response?.toString();
//     Map<String, dynamic> response?Data = jsonDecode(decode);
//     print(response?Data['message']);
//     // If api response? is true for success then will show dialog box
//     if (response?.statusCode == 200) {
//       CustomSnackBar(context, 'PIN validated successfully');
//       //Navigator.pop(context);
//       //Navigator.pushReplacement(
//           //context, CustomPageRoute(child: BottomNavigation()));
//     } else {}
//     // Printing json data which is provided to api
//     print("Enter Pin request send to api with user info: ");
//     print(otpData());
//   }
//
//   ChangePinValidationApi(final pinCode) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userMail = prefs.getString('userMail');
//     print(userMail);
//     final api = EnterPinApiServices(Dio(), "/validatePin");
//     dynamic otpData =
//     json.encode({"pin": "${pinCode}", "email": "${userMail}"});
//     // verification code will be converted to json body
//     Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
//     // Api response? will get here
//     final response? = await api.ApiUser(jsonOtpData, context);
//     //Print response? here
//     print('response? status: ${response?.statusCode}');
//     print('response? body: ${response?.data}');
//     String decoderesponse? = response?.toString();
//     Map<String, dynamic> res = jsonDecode(decoderesponse?);
//     res['token'] = '${response?.headers[HttpHeaders.authorizationHeader]}';
//     late var token = res['token'];
//     token = token.substring(1, token.length - 1);
//     print(token);
//     // Shared preferences used here so we can store token which will get from api.
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setString('token', token);
//
//     // If api response? is true for success then will show dialog box
//     if (response?.statusCode == 200) {
//       CustomSnackBar(context, 'PIN validated successfully');
//       Navigator.pushReplacement(
//           context, CustomPageRoute(child: BottomNavigation()));
//     } else {}
//   }
//
//   final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
//   final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);
//   bool _isButtonPressed = false;
//   bool canBack = false;
//
//   Future<bool> _onWillPopHome(BuildContext context) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? changePin = prefs.getInt('ChangePin');
//     print('ChangePin : ${changePin}');
//
//     final SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     int? unAuth = prefs1.getInt('Unauthorized');
//     print('UnAuth : ${unAuth}');
//     changePin == 0 ? Navigator.pop(context) : null;
//     // if (changePin != null && changePin == 0) {
//     //   Navigator.pop(context);
//     // }
//
//       bool canBack = await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
//           title: new Text('Are you sure?'),
//           content: new Text('Do you want to exit an app'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: new Text('No'),
//             ),
//             TextButton(
//               //onPressed: () => Navigator.of(context).pop(true),
//               onPressed: () => Navigator.of(context).dispose(),
//               child: new Text('Yes'),
//             ),
//           ],
//         ),
//       );
//       return canBack;
//
//     //return canBack;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         //title: Text("Authentication"),
//         automaticallyImplyLeading: false,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               color: Color(0xFFB2A0FB),
//               // gradient: LinearGradient(
//               //   begin: Alignment.bottomLeft,
//               //   end: Alignment.topRight,
//               //   colors: [
//               //     AppBarColor1,
//               //     AppBarColor2,
//               //   ],
//               // ),
//             ),
//           ),
//           title: Text(
//             'Authentication Required',
//             style: TextStyle(
//                 fontFamily: 'Roboto-Regular',
//                 fontSize: 30.sp,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white),
//           ),
//       ),
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   backgroundColor: Colors.white,
//       //   // automaticallyImplyLeading: false,
//       //   // leading: backButton == 1
//       //   //     ? BackButton(
//       //   //   color: Colors.white,
//       //   //   //onPressed: () => Navigator.pop(context),
//       //   //   onPressed: () => Navigator.of(context).pop(true),
//       //   //
//       //   // )
//       //   //     : null,
//       //   centerTitle: true,
//       //   flexibleSpace: Container(
//       //     decoration: BoxDecoration(
//       //       color: Color(0xFFB2A0FB),
//       //       // gradient: LinearGradient(
//       //       //   begin: Alignment.bottomLeft,
//       //       //   end: Alignment.topRight,
//       //       //   colors: [
//       //       //     AppBarColor1,
//       //       //     AppBarColor2,
//       //       //   ],
//       //       // ),
//       //     ),
//       //   ),
//       //   title: Text(
//       //     'Authentication Required',
//       //     style: TextStyle(
//       //         fontFamily: 'Roboto-Regular',
//       //         fontSize: 30.sp,
//       //         fontWeight: FontWeight.bold,
//       //         color: Colors.white),
//       //   ),
//       // ),
//       // Safe area will keep screen under notification panel
//       body: SafeArea(
//         // Container used to take whole screen size with media query.
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           //color: Colors.white,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           // All widgets will bw in list view.
//           child: ListView(
//             children: [
//               // Padding provided to all widgets
//               Padding(
//                 padding: EdgeInsets.fromLTRB(15.0.w, 10.0.h, 15.0.w, 10.0.h),
//                 // Colunm used to align all widgets in vertical format
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     // SizedBox(
//                     //   height: 30.h,
//                     // ),
//                     // // Image will appear in circle by using this widget with editable background color
//                     // CircleAvatar(
//                     //   backgroundColor: Color.fromRGBO(136, 190, 192, 150),
//                     //   radius: 130.0.r,
//                     //   child: Image.asset(
//                     //     "assets/EnterPin.png",
//                     //     // height: 450.h,
//                     //   ),
//                     //),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     // Text widget used to display any text on screen
//                     Text(
//                       //textAlign: TextAlign.center,
//                       "Enter your pin",
//                       style: TextStyle(
//                           fontFamily: 'Roboto-Regular',
//                           fontSize: 30.sp,
//                           color: Colors.black),
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     //OTP text field
//                     OtpTextField(
//                       // handleControllers: TextEditingController,
//                       //enabledBorderColor: EnterPinColor1,
//                       // Otp field color
//                       //focusedBorderColor: EnterPinColor2,
//                       // when focus on otp field
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       //crossAxisAlignment: CrossAxisAlignment.center,
//                       numberOfFields: 6,
//                       margin: EdgeInsets.all(4.0),
//                       fieldWidth: 55.0.w,
//
//                       filled: true,
//                       fillColor: Colors.white,
//                       borderRadius:
//                       BorderRadius.all(Radius.circular(8.0)),
//                       // borderColor: Colors.grey.shade700,
//                       showFieldAsBox: true,
//                       borderWidth: 1.8.w,
//                       //runs when a code is typed in
//                       onCodeChanged: (String code) {
//                         BorderSide(
//                           color: Color(0xFF37304A),
//                         );
//                       },
//                       //runs when every textfield is filled
//                       onSubmit: (String verificationCode) {
//                         //_verificationPin = verificationCode;
//                         setState(() {
//                           _verificationPin = verificationCode;
//                         });
//                         print(_verificationPin);
//
//
//                       },
//                     ),
//                     SizedBox(
//                       height: 50.h,
//                     ),
//                     // InkWell widget used to make any widget clickable so we can perform task on them
//                     InkWell(
//                       onTapDown: (_) {
//                         setState(() {
//                           _isButtonPressed = true;
//                         });
//                       },
//                       onTapUp: (_) {
//                         setState(() {
//                           _isButtonPressed = false;
//                         });
//                       },
//
//                       onTap: () async {
//                         // dynamic err;
//                         // final errorMessage = DioExceptions.fromDioError(err).toString();
//                         final SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                         int? unAuth = prefs.getInt('Unauthorized');
//                         print(unAuth);
//                         int? changePin = prefs.getInt('ChangePin');
//                         print(changePin);
//                         if(_verificationPin.isNotEmpty){
//                           ChangePinValidationApi(_verificationPin);
//                         }
//                         // Checking if all validation is done or not. if not then will show snack bar
//                         // if (changePin == 0 && _verificationPin.isNotEmpty) {
//                         //   final SharedPreferences prefs =
//                         //   await SharedPreferences.getInstance();
//                         //   prefs.setInt('ChangePin', 1);
//                         //   ChangePinValidationApi(_verificationPin);
//                         // }
//                         // else if ( _verificationPin.isNotEmpty) {
//                         //   //Navigator.pop(context); // Assuming you want to close the current screen when changePin is 1
//                         //   // Optionally, you can also handle other actions related to changePin == 1 here
//                         //   final SharedPreferences prefs =
//                         //   await SharedPreferences.getInstance();
//                         //   prefs.setInt('ChangePin', 1);
//                         //   ChangePinValidationApi(_verificationPin);
//                         // }
//                         else if (unAuth == 1 &&
//                             _verificationPin.isNotEmpty) {
//                           final SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                           prefs.setInt('Unauthorized', 0);
//                           PinVerificationApiCall(_verificationPin);
//                         }
//                         else if (_verificationPin.isEmpty) {
//                           CustomSnackBar(context, 'Please enter PIN');
//                         }
//
//                         // else if( changePin== 1 && _verificationPin.isNotEmpty){
//                         //   final SharedPreferences prefs =
//                         //   await SharedPreferences.getInstance();
//                         //   prefs.setInt('ChangePin', 0);
//                         //   ChangePinValidationApi(_verificationPin);
//
//                         //}
//                         else
//                          {
//                           // Increment incorrectAttempts
//                           incorrectAttempts++;
//                           print("incre: ${incorrectAttempts}");
//
//                           if (incorrectAttempts > 2) {
//                             // If incorrect attempts exceed 3, redirect to login page
//                             Navigator.pushReplacement(
//                               context,
//                               CustomPageRoute(child: LoginScreen()),
//                             );
//                           } else {
//                             // Show error message or handle incorrect PIN
//                             CustomSnackBar(context, 'Incorrect PIN. Attempts left: ${3 - incorrectAttempts}');
//                           }
//                         }
//                         // Future.delayed(Duration(milliseconds: 160), () {
//                         //   _controller.reverse();
//                         // });
//                         // print('Shrink');
//
//                       },
//                       // here Container is used to make a button.
//                       // child: ScaleTransition(
//                       //   scale: Tween<double>(
//                       //     begin: 1.0,
//                       //     end: 0.3,
//                       //   ).animate(_controller),
//
//                         child: AnimatedContainer(
//                           duration: Duration(milliseconds: 200),
//                           height: 45.h,
//                           //width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: _isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
//                             border: Border.all(color: Colors.white, width: 3),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Center(
//                             // Text widget used to display any text on screen
//                             child: Text(
//                               "Continue",
//                               style: TextStyle(
//                                   //height: 2.5.h,
//                                   fontFamily: 'Roboto-Regular',
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                 color: _isButtonPressed ? Color(0xFFB2A0FB) : Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         textStyle: TextStyle(fontSize: 20.sp),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context, CustomPageRoute(child: ChangePin()));
//                       },
//                       child: Text(
//                         'Forgot Pin',
//                         style: TextStyle(
//                             fontSize: 20.sp,
//                             fontFamily: 'Roboto-Regular',
//                             color: EnterPinColor2,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ])
//
//         )
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:Seerecs/Screens/EnterPassword.dart';
import 'package:Seerecs/Screens/LoginScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Assets/CustomPageRoute.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import '../../network/EnterPinApi.dart';
import '../../network/response_AlterBox.dart';

class PinAuth extends StatefulWidget {
  PinAuth({super.key});
  // Email will get from register page it will be stored in OtpEmail string
  @override
  State<PinAuth> createState() => _PinAuthState();
}

int? backButton;

storeBackButtonInfo() async {
  SharedPreferences prefs1 = await SharedPreferences.getInstance();
  backButton = prefs1.getInt('validatePinBackButton');
}

final EnterPinColor1 = Color.fromRGBO(136, 190, 192, 90); // Color
final EnterPinColor2 = Color.fromRGBO(58, 119, 132, 60); //Color

class _PinAuthState extends State<PinAuth> {
  int incorrectAttempts = 0;

  @override
  void initState() {
    super.initState();
    storeBackButtonInfo();
  }

  OtpTimerButtonController OtpController =
  OtpTimerButtonController(); // Otp text field controller

  late String _verificationPin = ""; // for storing Verification code

  String? userMail;
  // Define a variable to track the entered OTP
  String enteredOtp = '';

// Define a variable to track whether the entered PIN is correct or not
  bool isCorrectPin = true;
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
      //Navigator.pop(context);
      Navigator.pushReplacement(
      context, CustomPageRoute(child: BottomNavigation()));
    }
    //else {}
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
          context, CustomPageRoute(child: BottomNavigation()));
    }
    //else {}
  }

  // final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
  // final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);

  bool canBack = false;

  Future<bool> _onWillPopHome(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? changePin = prefs.getInt('ChangePin');
    print('ChangePin : ${changePin}');

    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    int? unAuth = prefs1.getInt('Unauthorized');
    print('UnAuth : ${unAuth}');
    //changePin == 0 ? Navigator.pop(context) : null;
    // if (changePin != null && changePin == 0) {
    //   Navigator.pop(context);
    // }
    //if (unAuth == 1) {
    bool canBack = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFB2A0FB),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
        title: new Text('Are you sure?',style: TextStyle(color: Colors.white),),
        content: new Text('Do you want to exit an app',style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            //onPressed: () => Navigator.of(context).pop(true),
            onPressed: (){
              exit(0); // Exit the app
            },
            child: new Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    //   return canBack;
    // }
    return canBack;
  }

  @override
  Widget build(BuildContext context) {
    bool _isButtonPressed = false;
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return WillPopScope(
      onWillPop: () => _onWillPopHome(context),
      // onWillPop: () async {
      //   final showPop = await _onWillPopHome(context);
      //   return showPop;
      // },
      child: Scaffold(
          backgroundColor: Color(0xFFECEFFC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFECF0FD),
          automaticallyImplyLeading: false,
          centerTitle: true,
          // leading: BackButton(
          //   //color: Color(0xFF02486A),
          //   onPressed: () => Navigator.pop(context),
          // ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xFFB2A0FB),
            ),
          ),
          title: Text(
            'Authentication',
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
                      top: 15.h,
                      //height: 280.h,
                      child: Image.asset(
                        "assets/8-removebg-preview 1.png",
                        //alignment: Alignment.bottomRight,
                        height: 250.h,
                        // width: 300.w,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Text("Enter 6 Digit Code Pin Code", style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF02486A)),),
                    SizedBox(height: 20.h,),
                    Container(
                      padding: EdgeInsets.only(left: 33),
                      alignment: Alignment.centerLeft, // Align the child (Text) to the left within the Container
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
                        setState(() {
                          enteredOtp = code;
                        });
                        BorderSide(
                          color: Color(0xff37304A),
                        );
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        _verificationPin = verificationCode;
                        print(_verificationPin);
                        // Check if the entered OTP is correct
                        if (_verificationPin != enteredOtp) {
                          setState(() {
                            isCorrectPin = false;
                          });
                        } else {
                          setState(() {
                            isCorrectPin = true;
                          });
                        }
                      },

                    ),

                    SizedBox(height: 30.h,),
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
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          int? unAuth = prefs.getInt('Unauthorized');
                          print(unAuth);
                          int? changePin = prefs.getInt('ChangePin');
                          print(changePin);

                          // Checking if all validation is done or not. if not then will show snack bar
                          if (changePin == 0 &&_verificationPin.isNotEmpty || changePin == 1 &&_verificationPin.isNotEmpty) {
                            prefs.setInt('ChangePin', 1);
                            ChangePinValidationApi(_verificationPin);
                          }
                          else if (unAuth == 1 && _verificationPin.isNotEmpty) {
                            prefs.setInt('Unauthorized', 0);
                            PinVerificationApiCall(_verificationPin);
                          }
                          else if (_verificationPin.isEmpty) {
                            CustomSnackBar(context, 'Please enter PIN');
                          } else {
                            // Incorrect PIN entered, increment the counter
                            incorrectAttempts++;

                            if (incorrectAttempts >= 3) {
                              // Redirect to login screen after 3 unsuccessful attempts
                              Navigator.pushReplacement(
                                context,
                                CustomPageRoute(child: LoginScreen()),
                              );
                            } else {
                              // Show a snackbar for incorrect PIN
                              CustomSnackBar(context, 'Incorrect PIN. Attempt $incorrectAttempts of 3');
                            }
                          }
                        },


                      child: AnimatedContainer(duration: Duration(milliseconds: 200),
                        height: 40.h,
                        width: 220.w,
                        decoration: BoxDecoration(
                          // ignore: dead_code
                          color: _isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                          //border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text("Continue",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),),
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
                            color: Color(0xff02486A),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () async {
                    //       // SharedPreferences prefs = await SharedPreferences.getInstance();
                    //       // await prefs.clear();
                    //       Navigator.pushReplacement(
                    //           context, CustomPageRoute(child: LoginScreen()));},
                    //     icon: Icon(
                    //       Icons.power_settings_new,
                    //       color: Colors.black,
                    //     )),
                  ],
                ),


              ],
            ),
          )
      ),
    );
  }
}

