// import 'dart:async';
// import 'package:Seerecs/Screens/SignInScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:Seerecs/Assets/CustomPageRoute.dart';
// import 'package:Seerecs/Screens/LoginScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Home_Page.dart';
// import 'package:Seerecs/Screens/AppPreferences.dart';

// late var finalToken; // variable to store token which will get from api in login page
// int? OnboardingInt;
// int? isStreamLine;

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// Future respectiveNavigation(context) {
//   return isStreamLine == 1
//       ? Navigator.pushReplacement(
//           context, CustomPageRoute(child: (StreamLinePreferences())))
//       : Navigator.pushReplacement(
//           context,
//           CustomPageRoute(
//               child: (finalToken == null ? LoginScreen() : HomePage())));
// }

// class _SplashScreenState extends State<SplashScreen> {
//   // init state for navigating to home page or login screen depending upon user login before or not
//   @override
//   void initState() {
//     getValidationData().whenComplete(() async {
//       Timer(
//         Duration(milliseconds: 2500),
//         () => respectiveNavigation(context),
//       );
//     });
//     super.initState();
//   }

//   // Here will get shared preference from login screen
//   Future getValidationData() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     // Token from api will be stored in obtainedToken variable.
//     var obtainedToken = sharedPreferences.get('token');
//     setState(() {
//       finalToken = obtainedToken;
//     });
//     print(finalToken);

//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     isStreamLine = await preferences.getInt('StreamLine');
//     print(isStreamLine);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Center widget used for all widget will appear in center
//       body: Center(
//         // All widgets will bw in list view.
//         child: ListView(
//           children: [
//             // Colunm used to align all widgets in vertical format
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Container used to take whole screen space
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   // Image assets used for to get image from assets folder.
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/Crecslaptop.png",
//                         height: 250.0.h,
//                         // width: 230.0.w,
//                       ),
//                       SizedBox(height: 30.h,),
//                       Text(
//                         "Full Transparency. Full Control.",
//                         style: TextStyle(
//                             fontSize: 27.sp,
//                             fontFamily: 'Roboto-Regular',
//                             color: Color.fromRGBO(27, 73, 78, 60),
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
