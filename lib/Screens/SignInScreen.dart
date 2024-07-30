// import 'package:Seerecs/Screens/ForgotPassword/ForgotPassword.dart';
// import 'package:Seerecs/Screens/ForgotPassword/PasswordScreen.dart';
// import 'package:Seerecs/Screens/Home_Page.dart';
// import 'package:Seerecs/Screens/ProfilePage.dart';
// import 'package:Seerecs/Screens/RegisterScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:Seerecs/Assets/UserModel.dart';
// import 'package:Seerecs/iconform_icons.dart';
// //import 'package:iconsax/iconsax.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:Seerecs/Screens/ForgotPassword.dart';
// import 'package:Seerecs/Screens/Home_Page.dart';
// import 'package:Seerecs/Screens/AppPreferences.dart';
// import '../network/API_Services.dart';
// import '../Assets/CustomPageRoute.dart';
// import '../network/response?_AlterBox.dart';
// import 'ForgotUsername.dart';
// import 'RegisterPage.dart';
// import '../Assets/UserModel.dart' as user;
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignInScreen extends StatefulWidget {
//   SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _form = GlobalKey<FormState>(); //for storing form state.
//   final usernameController = TextEditingController();
//   TextEditingController emailController =
//       TextEditingController(); // Email Controller
//   TextEditingController passwordController =
//       TextEditingController(); //Password controller
//   final textFieldFocusNode = FocusNode(); // Password field Obscure focus check
//   bool _isObscure = false; //Boolean to check if eye icon tapped or not

//   final PrimaryColor = Color.fromRGBO(52, 145, 184, 90); // Color
//   final SecondaryColor = Color.fromRGBO(19, 56, 71, 60); //Color

//   // Making Json to be send to API
//   Map<String, dynamic> toJson() {
//     return {
//       (user.Email): (emailController.text.toLowerCase()),
//       (user.confirmPassword): (passwordController.text),
//     };
//   }

//   // regular expression to check if string
//   RegExp pass_valid =
//       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#/$&*~]).{6,}$');
//   double password_strength = 0;

//   // 0: No password
//   // 1/4: Weak
//   // 2/4: Medium
//   // 3/4: Strong
//   //   1:   Great
//   //A function that validate user entered password
//   bool validatePassword(String pass) {
//     String _password = pass.trim();
//     if (_password.isEmpty) {
//       setState(() {
//         password_strength = 0;
//       });
//     } else if (_password.length < 6) {
//       setState(() {
//         password_strength = 1 / 4;
//       });
//     } else if (_password.length < 8) {
//       setState(() {
//         password_strength = 2 / 4;
//       });
//     } else {
//       if (pass_valid.hasMatch(_password)) {
//         setState(() {
//           password_strength = 4 / 4;
//         });
//         return true;
//       } else {
//         setState(() {
//           password_strength = 3 / 4;
//         });
//         return false;
//       }
//     }
//     return false;
//   }

//   // Checking if eye icon on password field is tapped and making field obscure on condition.
//   void _toggleObscured() {
//     setState(() {
//       _isObscure = !_isObscure;
//       if (textFieldFocusNode.hasPrimaryFocus) return;
//       textFieldFocusNode.canRequestFocus = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _form,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//             child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white, width: 7),
//             borderRadius: BorderRadius.circular(30),
//             gradient: LinearGradient(
//               colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 50.0.h,
//                 ),
//                 Text(
//                   'Hello Again!',
//                   style: TextStyle(
//                       color: Color(0xFF37304A),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 25),
//                 ),
//                 SizedBox(
//                   height: 10.0.h,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 60),
//                   child: Text(
//                     'Welcome back you’ve been missed!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color(0xFF737081),
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30.0.h,
//                 ),
//                 FormTextField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   hintText: 'Username',
//                   obscureText: false,
//                   suffixIcon: Icon(
//                     Icons.person_outlined,
//                     color: Colors.grey,
//                   ),
//                   validator: (value) {
//                     // add your custom validation here.
//                     if ((value.toString().isEmpty)) {
//                       return 'Please enter valid email';
//                     }
//                     if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
//                         .hasMatch(value!)) {
//                       return 'Please enter a valid Email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 20.0.h,
//                 ),
//                 FormTextField(
//                   controller: passwordController,
//                   keyboardType: TextInputType.visiblePassword,
//                   obscureText: !_isObscure,
//                   hintText: 'Password',
//                   suffixIcon: GestureDetector(
//                     onTap: _toggleObscured,
//                     child: Icon(
//                       _isObscure
//                           ? Icons.visibility_off_rounded
//                           : Icons.visibility_rounded,
//                       size: 25.sp,
//                       color:
//                           (_isObscure == false) ? PrimaryColor : SecondaryColor,
//                     ),
//                   ),

//                   onChanged: (value) {
//                     _form.currentState!.validate();
//                   },
//                   //obscureText: false,
//                   // suffixIcon: Icon(
//                   //   Iconform.lock,
//                   //   color: Colors.grey,
//                   // ),
//                   // Validation of password.
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter password";
//                     } else {
//                       //call function to check password
//                       bool result = validatePassword(value);
//                       if (result) {
//                         // create account event
//                         return null;
//                       } else {
//                         return "Password should contain 6 character with capital,"
//                             '\n'
//                             "small letter & number & special";
//                       }
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 10.0.h,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       ForgotPasswordex()));
//                         },
//                         child: Text(
//                           'Forgot Password',
//                           style: TextStyle(
//                               color: Colors.grey[600],
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 25.0.h,
//                 ),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 //         builder: (BuildContext context) => HomePage()));
//                 //   },
//                 InkWell(
//                   onTap: () async {
//                     // Checking if all validation is done or not.
//                     final isValid = _form.currentState!.validate();
//                     // If all fields validated then it will call api
//                     if (isValid == true) {
//                       // Api call here
//                       final api = ApiServices(Dio(), "/login");
//                       // Will get response? of api.
//                       final response? = await api.ApiUser(toJson(), context);
//                       // Printing response? and status code here
//                       print('response? status: ${response?.statusCode}');
//                       print('response? body: ${response?}');
//                       print(
//                           'response? headers: ${response?.headers[HttpHeaders.authorizationHeader]}');
//                       // Converting api json response? to Map string.
//                       String decoderesponse? = response?.toString();
//                       Map<String, dynamic> res = jsonDecode(decoderesponse?);
//                       res['token'] =
//                           '${response?.headers[HttpHeaders.authorizationHeader]}';
//                       late var token = res['token'];
//                       token = token.substring(1, token.length - 1);
//                       print(token);
//                       // Shared preferences used here so we can store token which will get from api.
//                       SharedPreferences sharedPreferences =
//                           await SharedPreferences.getInstance();
//                       sharedPreferences.setString('token', token);

//                       // Shared preferences used here so we can store date which will get from api.
//                       res['userMail'] = emailController.text;
//                       late var userMail = res['userMail'];
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       prefs.setString('userMail', userMail);
//                       print(userMail);

//                       //If status code is 200 then will navigate to Welcome page.
//                       if (response?.statusCode == 200) {
//                         CustomSnackBar(context, 'User Sign In Successfully');
//                         int StreamLine = 1;
//                         SharedPreferences preferences =
//                             await SharedPreferences.getInstance();
//                         await preferences.setInt('StreamLine', StreamLine);

//                         int? isStreamLine;
//                         SharedPreferences prefs =
//                             await SharedPreferences.getInstance();
//                         isStreamLine = await prefs.getInt("streamLine");
//                         await prefs.setInt("streamLine", 1);
//                         print('streamLine : ${isStreamLine}');
//                         if (isStreamLine == 1) {
//                           Navigator.of(context).pushReplacement(
//                               CustomPageRoute(child: HomePage()));
//                         } else {
//                           await prefs.setInt('streamLine', 0);
//                           Navigator.of(context).pushReplacement(
//                               CustomPageRoute(child: StreamLinePreferences()));
//                         }
//                       } else {}
//                       // Printing json data which is provided to api
//                       print("login request send to api with user info: ");
//                       print(toJson());
//                     }
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     margin: EdgeInsets.symmetric(horizontal: 25),
//                     decoration: BoxDecoration(
//                         color: Color(0xFFB2A0FB),
//                         border: Border.all(color: Colors.white, width: 3),
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Center(
//                       child: Text(
//                         'Sign In',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 35.0.h,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           height: 2.0.h,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                     colors: [Color(0xFFEEF0F7), Colors.grey],
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight)),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Text(
//                           'or continue with',
//                           style:
//                               TextStyle(color: Color(0xFF737081), fontSize: 13),
//                         ),
//                       ),
//                       Expanded(
//                         child: SizedBox(
//                           height: 2.0.h,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                               colors: [Color(0xFFEEF0F7), Colors.grey],
//                               begin: Alignment.centerRight,
//                               end: Alignment.centerLeft,
//                             )),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40.0.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white, width: 3),
//                         borderRadius: BorderRadius.circular(8),
//                         color: Color(0xFFEEF0F7),
//                       ),
//                       child: Image.asset(
//                         'assets/google.png',
//                         height: 25.0.h,
//                         width: 50.0.w,
//                       ),
//                     ),
//                     SizedBox(width: 25),
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white, width: 3),
//                         borderRadius: BorderRadius.circular(8),
//                         color: Color(0xFFEEF0F7),
//                       ),
//                       child: Image.asset(
//                         'assets/apple.png',
//                         height: 25.0.h,
//                         width: 50.0.w,
//                       ),
//                     ),
//                     SizedBox(width: 25),
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white, width: 3),
//                         borderRadius: BorderRadius.circular(8),
//                         color: Color(0xFFEEF0F7),
//                       ),
//                       child: Image.asset(
//                         'assets/facebook.png',
//                         height: 25.0.h,
//                         width: 50.0.w,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 50.0.h),

//                 // not a member? register now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Not a member?',
//                       style: TextStyle(
//                           color: Colors.grey[700], fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(width: 4),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushReplacement(MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 RegisterPage()));
//                       },
//                       child: const Text(
//                         'Register now',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )),
//       ),
//     );
//   }
// }
