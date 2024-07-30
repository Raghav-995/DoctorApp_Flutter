// import 'package:flutter/material.dart';
// import 'package:Seerecs/Screens/ForgotPassword/PasswordRecovery.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pinput/pinput.dart';
//
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:Seerecs/network/API_Services.dart';
// import 'package:Seerecs/Assets/CustomPageRoute.dart';
// import 'package:Seerecs/Assets/UserModel.dart' as user;
// import 'package:Seerecs/network/response_AlterBox.dart';
// import 'package:Seerecs/Screens/LoginScreen.dart';
// import 'package:otp_timer_button/otp_timer_button.dart';
// // import 'package:otp_text_field/otp_field.dart';
// // import 'package:otp_text_field/otp_field_style.dart';
// // import 'package:otp_text_field/style.dart';
//
// class OTPScreen extends StatefulWidget {
//   OTPScreen({super.key, required this.Email});
//
//   final String Email;
//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   OtpTimerButtonController OtpController =
//       OtpTimerButtonController(); // Otp text field controller
//
//   int duration = 30; // int duration will be given to resend button
//   // int counter = 0;
//   late String verificationCode = ""; // for storing Verification code
//
//   // Making Json to be send to API
//   Map<String, dynamic> toJson() {
//     return {
//       (user.email): (widget.Email.toLowerCase()),
//       (user.verificationCode): (verificationCode)
//     };
//   }
//
//   // Function will call api
//   VerificationApiCall(final OtpCode) async {
//     // Call your API here and pass `_verificationCode` as a parameter
//     final api = ApiServices(Dio(), "/verify");
//     dynamic otpData = json.encode({
//       "email": "${widget.Email}",
//       "otp": "${OtpCode}",
//     });
//     // verification code will be converted to json body
//     Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
//     // Api response? will get here
//     final response = await api.ApiUser(jsonOtpData, context);
//     //Print response? here
//     print('response? status: ${response.statusCode}');
//     print('response? body: ${response}');
//
//     //response? decoding from json to Map string
//     String decode = response.toString();
//     Map<String, dynamic> res = jsonDecode(decode);
//     print(res['success']);
//     var check = res['success'];
//     // If api response? is true for success then will show dialog box
//     if (check == true) {
//       showDialog(
//         useSafeArea: true,
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
//             content: Container(
//               height: 350.h,
//               width: 350.w,
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: const Color(0xFFFFFF),
//                 borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Image assets used for to get image from assets folder.
//                   Image.asset(
//                     "assets/VerificationDone.png",
//                     height: 200.h,
//                     // width: 200.w,
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Text(
//                     "Congratulations!",
//                     style: TextStyle(
//                       fontFamily: 'Roboto-Regular',
//                       fontSize: 30.sp,
//                       fontWeight: FontWeight.bold,
//                       //color: Color.fromARGB(255, 25, 185, 169),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Text(
//                     textAlign: TextAlign.center,
//                     "Account has been created."
//                     '\n'
//                     "To rule your health records kindly Sign in.",
//                     style: TextStyle(
//                       fontFamily: 'Roboto-Regular',
//                       fontSize: 20.sp,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   // InkWell widget used to make any widget clickable so we can perform task on them
//                   InkWell(
//                     onTap: () {
//                       // On tap will navigate to Login screen
//                       Navigator.of(context).popUntil((route) => route.isFirst);
//                       Navigator.pushReplacement(
//                           context, CustomPageRoute(child: LoginScreen()));
//                     },
//                     // Button is made of container
//                     child: Container(
//                       height: 30.h,
//                       width: 150.w,
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 25, 185, 169),
//                         borderRadius: BorderRadius.circular(5.r),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Sign in",
//                           style: TextStyle(
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     } else {}
//     // Printing json data which is provided to api
//     print("OTP request send to api with user info: ");
//     print(toJson());
//   }
//
//   // Making Json to be send to API
//   Map<String, dynamic> ResendOtpToJson() {
//     return {
//       (user.email): (widget.Email),
//     };
//   }
//
//   final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
//   final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);
//
//   @override
//   Widget build(BuildContext context) {
//     int start = 30;
//     PinTheme defaultTheme = PinTheme(
//       margin: EdgeInsets.all(10),
//       height: 60,
//       width: 60,
//       textStyle: const TextStyle(
//         fontSize: 25,
//       ),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF7F8F9),
//         border: Border.all(
//           color: const Color(0xFFE8ECF4),
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//     );
//
//     PinTheme focusedTheme = PinTheme(
//       margin: EdgeInsets.all(10),
//       height: 60,
//       width: 60,
//       textStyle: const TextStyle(
//         fontSize: 25,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: const Color(0xFF37304A),
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//     );
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               border: Border.all(color: Colors.white, width: 7),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Positioned(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         //color: const Color(0xff333366),
//                         borderRadius: BorderRadius.circular(30)),
//                     constraints:
//                         const BoxConstraints(maxWidth: 410, maxHeight: 350),
//                   ),
//                 ),
//                 Positioned(
//                   top: 20,
//                   left: 15,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   //right: 0,
//                   //left: 30,
//                   //bottom: 5,
//                   height: 315.0.h,
//                   //height: MediaQuery.of(context).size.height * 0.49,
//
//                   child: ClipRRect(
//                     child: Image.asset("assets/dio-03 1.png"),
//                   ),
//                 ),
//                 Positioned(
//                   //top: 480,
//                   top: MediaQuery.of(context).size.height / 2.1,
//                   //height: 100.0.h,
//                   child: Container(
//                     //height: 190.0.h,
//                     width: 430.0.w,
//
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 1),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 20),
//                           SizedBox(
//                             //width: MediaQuery.of(context).size.width * 0.9,
//                             child: const Text(
//                               "Verification Code",
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF37304A)),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           //OTPTextField(),
//                           Container(
//                             width: 650,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Pinput(
//                                       length: 6,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       defaultPinTheme: defaultTheme,
//                                       focusedPinTheme: focusedTheme,
//                                       submittedPinTheme: focusedTheme,
//                                       onChanged: (String code) {},
//                                       //runs when every textfield is filled
//                                       onSubmitted: (String verificationCode) {
//                                         verificationCode = verificationCode;
//                                         print(verificationCode);
//                                         print(widget.Email);
//                                       }),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 25,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 90),
//                             child: RichText(
//                                 textAlign: TextAlign.center,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "Enter your code ",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           color: Color(0xFF141047),
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     TextSpan(
//                                       text: "(00:$start)",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           color: Color(0xFF141047),
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ],
//                                 )),
//                           ),
//                           //const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 "Not Received?",
//                                 style: TextStyle(
//                                   color: Color(0xFFF737081),
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               OtpTimerButton(
//                                 controller: OtpController,
//                                 height: 45.h,
//                                 text: Text(
//                                   " RESEND",
//                                   style: TextStyle(
//                                     color: Color(0xFFF8381D),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 buttonType: ButtonType.text_button,
//                                 duration: duration,
//                                 // Duration given for button to be disabled
//                                 onPressed: () async {
//                                   print('Resend button pressed');
//                                   ResendOtpApiCall(); // Resend otp api call here
//                                   print('OTP sent to following mail');
//                                   print(widget.Email);
//                                 },
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           InkWell(
//                             onTap: () async {
//                               // Checking if all validation is done or not. if not then will show snack bar
//                               if (verificationCode.isNotEmpty) {
//                                 VerificationApiCall(verificationCode);
//                               } else {
//                                 CustomSnackBar(
//                                     context, 'Please enter verification code');
//                               }
//                             },
//                             child: Container(
//                               //padding: EdgeInsets.all(20),
//                               margin: EdgeInsets.symmetric(horizontal: 25),
//                               decoration: BoxDecoration(
//                                   color: Color(0xFFB2A0FB),
//                                   border:
//                                       Border.all(color: Colors.white, width: 3),
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: Center(
//                                 child: Text(
//                                   'Sign In',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
//
// // Function for Resend api calling
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
// }
