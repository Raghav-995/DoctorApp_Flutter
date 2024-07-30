// import 'dart:convert';
// import 'package:Seerecs/Screens/RegisterPage.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:Seerecs/network/API_Services.dart';
// import '../Assets/CustomPageRoute.dart';
// import '../Assets/UserModel.dart' as user;
// import '../network/response_AlterBox.dart';
// import 'LoginScreen.dart';
// import 'package:otp_timer_button/otp_timer_button.dart';
// import 'package:keyboard_attachable/keyboard_attachable.dart';
//
// class EmailOtpVerification extends StatefulWidget {
//   EmailOtpVerification({super.key, required this.email});
//   final String
//       email; // Email will get from register page it will be stored in OtpEmail string
//   @override
//   State<EmailOtpVerification> createState() => _EmailOtpVerificationState();
// }
//
// class _EmailOtpVerificationState extends State<EmailOtpVerification> {
//   OtpTimerButtonController OtpController =
//       OtpTimerButtonController(); // Otp text field controller
//   int duration = 30; // int duration will be given to resend button
//   // int counter = 0;
//   late String _verificationCode = ""; // for storing Verification code
//   // Making Json to be send to API
//   Map<String, dynamic> emailOtpData() {
//     return {
//       (user.email): (widget.email.toLowerCase()),
//       (user.verificationCode): (_verificationCode)
//     };
//   }
//
//   bool isButtonPressed = false;
//   // Function will call api
//   VerificationApiCall(final OtpCode) async {
//     // Call your API here and pass `_verificationCode` as a parameter
//     final api = ApiServices(Dio(), "/verify");
//     dynamic otpData = json.encode({
//       "email": "${widget.email}",
//       "otp": "${OtpCode}",
//     });
//     // verification code will be converted to json body
//     Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
//     // Api response? will get here
//     final response = await api.ApiUser(jsonOtpData, context);
//     //Print response? here
//     print('response status: ${response.statusCode}');
//     print('response body: ${response}');
//     //response? decoding from json to Map string
//     String decode = response.toString();
//     Map<String, dynamic> res = jsonDecode(decode);
//     print(res['success']);
//     var check = res['success'];
//     // If api response? is true for success then will show dialog box
//     if (check == true) {
//       return showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             backgroundColor: Colors
//                 .transparent, // Set transparent background color for the dialog
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white, // Set desired background color here
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Color(0xFFB1A0FB), width: 3)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(height: 30),
//                         Text(
//                           "Congratulations!",
//                           style: TextStyle(
//                             fontFamily: 'Roboto-Regular',
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff02486A),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         Text(
//                           "Account has been created.\nTo rule your health records kindly Sign in.",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontFamily: 'Roboto-Regular',
//                             fontSize: 16.sp,
//                             color: Color(0xff02486A),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(context,
//                                               CustomPageRoute(child: LoginScreen()));
//                             // Navigator.of(context)
//                             //     .popUntil((route) => route.isFirst);
//                           },
//                           child: Container(
//                             height: 40.h,
//                             width: 120.w,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFB1A0FB),
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(color: Colors.white, width: 2),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(
//                                       0.2), // Set shadow color here
//                                   spreadRadius: 2, // Set spread radius here
//                                   blurRadius: 4, // Set blur radius here
//                                   offset: Offset(0, 2), // Set offset here
//                                 ),
//                               ],
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Sign in",
//                                 style: TextStyle(
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   top: 0,
//                   child: Image.asset(
//                     "assets/Group 4.png",
//                     height: 50,
//                     width: 50,
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   bottom: 0,
//                   child: Image.asset(
//                     "assets/Group 5.png",
//                     height: 50,
//                     width: 50,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     } else {}
//     // Printing json data which is provided to api
//     print("OTP request send to api with user info: ");
//     print(emailOtpData());
//   }
//
//   // Making Json to be send to API
//   Map<String, dynamic> ResendOtpToJson() {
//     return {
//       (user.email): (widget.email),
//     };
//   }
//
//   // final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
//   // final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);
//   //final ScrollController _scrollController = ScrollController();
//   //final FocusNode _focusableWidgetNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       // Safe area will keep screen under notification panel
//       body: SafeArea(
//         //maintainBottomViewPadding: true,
//         // Container used to take whole screen size with media query.
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             border: Border.all(color: Colors.white, width: 7),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           // All widgets will bw in list view.
//           // child: ListView(
//           //   children: [
//           // Padding provided to all widgets
//           child: Stack(
//             children: [
//               Positioned(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       //color: const Color(0xff333366),
//                       borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                       //borderRadius: BorderRadius.circular(30)
//                       ),
//                   constraints: BoxConstraints(maxWidth: width, maxHeight: 350),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _showAlertDialog(context);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 //right: 0,
//                 left: 30,
//                 //bottom: 5,
//                 height: 290.0.h,
//                 //height: MediaQuery.of(context).size.height * 0.49,
//                 child: ClipRRect(
//                   child: Image.asset("assets/dio-03 1.png"),
//                 ),
//               ),
//               Positioned(
//                 top: MediaQuery.of(context).size.height * 0.46,
//                 child: Container(
//                   width: 440.0.w,
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(10.0.w, 0.0.h, 0.0.w, 0.0.h),
//                     // Colunm used to align all widgets in vertical format
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         // SizedBox(
//                         //   height: 20.h,
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: const Text(
//                             "Verification Code",
//                             //textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF37304A)),
//                           ),
//                         ),
//                         // Image will appear in circle by using this widget with editable background color
//                         // CircleAvatar(
//                         //   backgroundColor: Color.fromRGBO(52, 145, 184, 200),
//                         //   radius: 130.0.r,
//                         //   child: Image.asset(
//                         //     "assets/OTPmail.png",
//                         //     // height: 250.h,
//                         //   ),
//                         // ),
//                         // SizedBox(
//                         //   height: 30.h,
//                         // ),
//                         // // Text widget used to display any text on screen
//                         // Text(
//                         //   textAlign: TextAlign.center,
//                         //   "Enter 6 digit verification code sent to your email",
//                         //   style: TextStyle(
//                         //       fontFamily: 'Roboto-Regular',
//                         //       fontSize: 22.sp,
//                         //       color: AppBarColor2),
//                         // ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         // Text widget used to display any text on screen
//                         // Text(
//                         //   textAlign: TextAlign.center,
//                         //   widget.Email,
//                         //   style: TextStyle(
//                         //       fontFamily: 'Roboto-Regular',
//                         //       fontWeight: FontWeight.w500,
//                         //       fontSize: 25.sp,
//                         //       color: AppBarColor2),
//                         // ),
//                         // SizedBox(
//                         //   height: 30.h,
//                         // ),
//                         //OTP text field
//                         OtpTextField(
//                           // when focus on otp field
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           numberOfFields: 6,
//                           margin: EdgeInsets.all(4.0),
//                           fieldWidth: 57.0.w,
//
//                           filled: true,
//                           fillColor: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                           // borderColor: Colors.grey.shade700,
//                           showFieldAsBox: true,
//                           borderWidth: 1.8.w,
//                           //runs when a code is typed in
//                           onCodeChanged: (String code) {
//                             BorderSide(
//                               color: Color(0xFF37304A),
//                             );
//                           },
//                           //runs when every textfield is filled
//                           onSubmit: (String verificationCode) {
//                             verificationCode = verificationCode;
//                             print(verificationCode);
//                             print(widget.email);
//                           },
//                         ),
//
//                         SizedBox(
//                           height: 15.h,
//                         ),
//
//                         // Otp Timer button used for calling resend otp api
//
//                         // InkWell widget used to make any widget clickable so we can perform task on them
//                         InkWell(
//                           onTapDown: (_) {
//                             setState(() {
//                               isButtonPressed = true;
//                             });
//                           },
//                           onTapUp: (_) {
//                             setState(() {
//                               isButtonPressed = false;
//                             });
//                           },
//                           onTap: () {
//                             // Checking if all validation is done or not. if not then will show snack bar
//                             if (_verificationCode.isNotEmpty) {
//                               VerificationApiCall(_verificationCode);
//                             } else {
//                               CustomSnackBar(
//                                   context, 'Please enter verification code');
//                             }
//                           },
//                           // here Container is used to make a button.
//                           child: AnimatedContainer(
//                             duration: Duration(milliseconds: 200),
//                             height: 45.h,
//                             //width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: isButtonPressed
//                                   ? Colors.white
//                                   : Color(0xFFB2A0FB),
//                               border: Border.all(color: Colors.white, width: 3),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Center(
//                               // Text widget used to display any text on screen
//                               child: Text(
//                                 "Verify",
//                                 style: TextStyle(
//                                   //height: 2.5.h,
//                                   fontFamily: 'Roboto-Regular',
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: isButtonPressed
//                                       ? Color(0xFFB2A0FB)
//                                       : Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         // SizedBox(
//                         //   height: 10.h,
//                         // ),
//                         Center(
//                           child: OtpTimerButton(
//                             controller: OtpController,
//                             height: 30.h,
//
//                             text: Text(
//                               'Not Received? RESEND',
//                               style: TextStyle(
//                                   fontFamily: 'Roboto-Regular',
//                                   fontSize: 17.sp,
//                                   color: Colors.black),
//                             ),
//                             buttonType: ButtonType.text_button,
//                             duration: duration,
//                             // Duration given for button to be disabled
//                             onPressed: () async {
//                               print('Resend button pressed');
//                               ResendOtpApiCall(); // Resend otp api call here
//                               print('OTP sent to following mail');
//                               print(widget.email);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Function for Resend api calling
//   ResendOtpApiCall() async {
//     // Api call here
//     final api = ApiServices(Dio(), "/resendOTP");
//     //Will get api response? here
//     final response = await api.ApiUser(ResendOtpToJson(), context);
//     // response? and status code will be print
//     print('response? status: ${response.statusCode}');
//     print('response? body: ${response}');
//     //Decoding response? from json to mao string
//     String decode = response.toString();
//     Map<String, dynamic> res = jsonDecode(decode);
//     print(res['success']);
//     // if success message is true then dialog box will pop
//     // Dialog box with message "OTP sent to your mail".
//     var check = res['success'];
//     if (check == true) {
//       showCustomDialog(context, 'Message', res['message']);
//     }
//   }
//
//   Future<void> _showAlertDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               "Are you sure?",
//               style: TextStyle(color: Colors.white),
//             ),
//             backgroundColor: Color(0xFFB2A0FB),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                       context, CustomPageRoute(child: RegisterPage()));
//                 },
//                 child: Text(
//                   'Continue',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               )
//             ],
//           );
//         });
//   }
// }
import 'dart:convert';
import 'package:Seerecs/Screens/RegisterPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/network/API_Services.dart';
import '../Assets/CustomPageRoute.dart';
import '../Assets/UserModel.dart' as user;
import '../network/Response_AlterBox.dart';
import 'LoginScreen.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class EmailOtpVerification extends StatefulWidget {
  EmailOtpVerification({super.key, required this.email});
  final String email; // Email will get from register page it will be stored in OtpEmail string
  @override
  State<EmailOtpVerification> createState() => _EmailOtpVerificationState();
}

class _EmailOtpVerificationState extends State<EmailOtpVerification> {
  OtpTimerButtonController OtpController =
  OtpTimerButtonController(); // Otp text field controller
  int duration = 30; // int duration will be given to resend button
  // int counter = 0;
  late String _verificationCode = ""; // for storing Verification code
  // Making Json to be send to API
  Map<String, dynamic> emailOtpData() {
    return {
      (user.email): (widget.email.toLowerCase()),
      (user.verificationCode): (_verificationCode)
    };
  }
  bool _isButtonPressed = false;
  // Function will call api
  VerificationApiCall(final OtpCode) async {
    // Call your API here and pass `_verificationCode` as a parameter
    final api = ApiServices(Dio(), "/verify");
    dynamic otpData = json.encode({
      "email": "${widget.email}",
      "otp": "${OtpCode}",
    });
    // verification code will be converted to json body
    Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
    // Api response will get here
    final response = await api.ApiUser(jsonOtpData, context);
    //Print response here
    print('Response status: ${response.statusCode}');
    print('Response body: ${response}');
    //Response decoding from json to Map string
    String decode = response.toString();
    Map<String, dynamic> res = jsonDecode(decode);
    print(res['success']);
    var check = res['success'];
    // If api response is true for success then will show dialog box
  //   if (check == true) {
  //     showDialog(
  //       useSafeArea: true,
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: Color(0xFFB2A0FB),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
  //           content: Container(
  //             height: 170.h,
  //             // width: 350.w,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.rectangle,
  //               color: const Color(0xFFFFFF),
  //               borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 // Image assets used for to get image from assets folder.
  //                 // Image.asset(
  //                 //   "assets/VerificationDone.png",
  //                 //   height: 200.h,
  //                 //   // width: 200.w,
  //                 // ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 Text(
  //                   "Congratulations!",
  //                   style: TextStyle(
  //                     fontFamily: 'Roboto-Regular',
  //                     fontSize: 30.sp,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 Text(
  //                   textAlign: TextAlign.center,
  //                   "Account has been created."
  //                       '\n'
  //                       "To rule your health records kindly Sign in.",
  //                   style: TextStyle(
  //                     fontFamily: 'Roboto-Regular',
  //                     fontSize: 20.sp,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 // InkWell widget used to make any widget clickable so we can perform task on them
  //                 InkWell(
  //                   onTap: () {
  //                     // On tap will navigate to Login screen
  //                     //showAlertDialog(context);
  //                     Navigator.of(context).popUntil((route) => route.isFirst);
  //                     Navigator.pushReplacement(
  //                         context, CustomPageRoute(child: LoginScreen()));
  //                   },
  //                   // Button is made of container
  //                   child: Container(
  //                     height: 40.h,
  //                     width: 120.w,
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(5.r),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Sign in",
  //                         style: TextStyle(
  //                             fontSize: 15.sp,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } else {}
  //   // Printing json data which is provided to api
  //   print("OTP request send to api with user info: ");
  //   print(toJson());
  // }
        if (check == true) {
      return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors
                .transparent, // Set transparent background color for the dialog
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, // Set desired background color here
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFFB1A0FB), width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "Congratulations!",
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff02486A),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Account has been created.\nTo rule your health records kindly Sign in.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 16.sp,
                            color: Color(0xff02486A),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                              CustomPageRoute(child: LoginScreen()));
                            // Navigator.of(context)
                            //     .popUntil((route) => route.isFirst);
                          },
                          child: Container(
                            height: 40.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFB1A0FB),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Set shadow color here
                                  spreadRadius: 2, // Set spread radius here
                                  blurRadius: 4, // Set blur radius here
                                  offset: Offset(0, 2), // Set offset here
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Image.asset(
                    "assets/Group 4.png",
                    height: 50,
                    width: 50,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/Group 5.png",
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {}
    // Printing json data which is provided to api
    print("OTP request send to api with user info: ");
    print(emailOtpData());
  }

  // Making Json to be send to API
  Map<String, dynamic> ResendOtpToJson() {
    return {
      (user.email): (widget.email),
    };
  }

  final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
  final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);
  //final ScrollController _scrollController = ScrollController();
  //final FocusNode _focusableWidgetNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // // This is just if you want to have the last focusable Widget scroll into view:
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (_focusableWidgetNode.hasPrimaryFocus) {
    //     // Tweak this if you want to change where you want to scroll to but
    //     // it should be rarely necessary:
    //     final double bottomOffset = _scrollController.position.maxScrollExtent;
    //     _scrollController.animateTo(bottomOffset,
    //         duration: Duration(milliseconds: 100), curve: Curves.linear);
    //   }
    // });
    double width = MediaQuery.of(context).size.width;
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      // Safe area will keep screen under notification panel
      body: SafeArea(
        //maintainBottomViewPadding: true,
        // Container used to take whole screen size with media query.
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
          // child: ListView(
          //   children: [
          // Padding provided to all widgets
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
                  _showAlertDialog(context);
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
                top: 0,
                //right: 0,
                left: 30,
                //bottom: 5,
                height: 290.0.h,
                //height: MediaQuery.of(context).size.height * 0.49,
                child: ClipRRect(
                  child: Image.asset("assets/dio-03 1.png"),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.46,
                child: Container(
                  width: 440.0.w,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0.w, 0.0.h, 0.0.w, 0.0.h),
                    // Colunm used to align all widgets in vertical format
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            "Verification Code",
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF37304A)),
                          ),
                        ),
                        // Image will appear in circle by using this widget with editable background color
                        // CircleAvatar(
                        //   backgroundColor: Color.fromRGBO(52, 145, 184, 200),
                        //   radius: 130.0.r,
                        //   child: Image.asset(
                        //     "assets/OTPmail.png",
                        //     // height: 250.h,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30.h,
                        // ),
                        // // Text widget used to display any text on screen
                        // Text(
                        //   textAlign: TextAlign.center,
                        //   "Enter 6 digit verification code sent to your email",
                        //   style: TextStyle(
                        //       fontFamily: 'Roboto-Regular',
                        //       fontSize: 22.sp,
                        //       color: AppBarColor2),
                        // ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Text widget used to display any text on screen
                        // Text(
                        //   textAlign: TextAlign.center,
                        //   widget.Email,
                        //   style: TextStyle(
                        //       fontFamily: 'Roboto-Regular',
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 25.sp,
                        //       color: AppBarColor2),
                        // ),
                        // SizedBox(
                        //   height: 30.h,
                        // ),
                        //OTP text field
                        OtpTextField(
                          // when focus on otp field
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            _verificationCode = verificationCode;
                            print(_verificationCode);
                            print(widget.email);
                          },
                        ),

                        SizedBox(
                          height: 15.h,
                        ),

                        // Otp Timer button used for calling resend otp api

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
                          onTap: () {
                            // Checking if all validation is done or not. if not then will show snack bar
                            if (_verificationCode.isNotEmpty) {
                              VerificationApiCall(_verificationCode);
                            } else {
                              CustomSnackBar(
                                  context, 'Please enter verification code');
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
                                "Verify",
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
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        Center(
                          child: OtpTimerButton(
                            controller: OtpController,
                            height: 30.h,

                            text: Text(
                              'Not Received? RESEND',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 17.sp,
                                  color: Colors.black),
                            ),
                            buttonType: ButtonType.text_button,
                            duration: duration,
                            // Duration given for button to be disabled
                            onPressed: () async {
                              print('Resend button pressed');
                              ResendOtpApiCall(); // Resend otp api call here
                              print('OTP sent to following mail');
                              print(widget.email);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function for Resend api calling
  ResendOtpApiCall() async {
    // Api call here
    final api = ApiServices(Dio(), "/resendOTP");
    //Will get api response here
    final response = await api.ApiUser(ResendOtpToJson(), context);
    // response and status code will be print
    print('Response status: ${response.statusCode}');
    print('Response body: ${response}');
    //Decoding response from json to mao string
    String decode = response.toString();
    Map<String, dynamic> res = jsonDecode(decode);
    print(res['success']);
    // if success message is true then dialog box will pop
    // Dialog box with message "OTP sent to your mail".
    var check = res['success'];
    if (check == true) {
      showCustomDialog(context, 'Message', res['message']);
    }
  }


  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure?",style: TextStyle(color: Colors.white),),
            backgroundColor: Color(0xFFB2A0FB),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, CustomPageRoute(child: RegisterPage()));
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          );
        });
  }
}


