// import 'dart:ui';
// import 'package:Seerecs/Screens/ForgotPassword/ForgotPassword.dart';
// import 'package:Seerecs/Screens/ForgotPassword/PasswordRecovery.dart';
// import 'package:Seerecs/Screens/ForgotPassword/VerificationCode.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class AppScrollBehavior extends MaterialScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       };
// }

// class PasswordScreen extends StatefulWidget {
//   const PasswordScreen({super.key});

//   @override
//   State<PasswordScreen> createState() => _PasswordScreenState();
// }

// class _PasswordScreenState extends State<PasswordScreen> {
//   final _controller = PageController();
//   bool isLastPage = false;

//   int _activePage = 0;
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Stack(children: [
//         PageView(
//           controller: _controller,
//           //physics: RightBlockedScrollPhysics(),
//           //scrollDirection: axisDirectionToAxis(AxisDirection.left),
//           onPageChanged: (index) {
//             setState(() => _activePage == index);
//           },
//           reverse: false,
//           children: [ForgotPassword(), OTPScreen(), PasswordRecovery()],
//         ),
//       Positioned(
//           bottom: 20,
//           right: 0,
//           left: 0,
          
//               child:Center(
//                   child: SmoothPageIndicator(
//                       controller: _controller,
//                       count: 3,
//                       effect: WormEffect(
//                         dotColor: Colors.white,
//                         activeDotColor: Color(0xFF3C3785),
//                         dotWidth: 10,
//                         dotHeight: 10,
//                       )),
//                 ),
//         ),
        
//       ]),
//     ));
//   }
// }
