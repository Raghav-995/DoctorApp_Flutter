// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Assets/CustomPageRoute.dart';
// import 'LoginScreen.dart';

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final int _numPages = 3;
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;

//   List<Widget> _buildPageIndicator() {
//     List<Widget> list = [];
//     for (int i = 0; i < _numPages; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 150),
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 7.0.h,
//       width: isActive ? 24.0 : 16.0,
//       decoration: BoxDecoration(
//         color: isActive ? Color.fromRGBO(27, 73, 78, 60) : Colors.grey[300],
//         borderRadius: BorderRadius.all(Radius.circular(12.r)),
//       ),
//     );
//   }

//   StoreOnboardInfo() async {
//     int isViewed = 0;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('onBoard', isViewed);
//   }

//   final PrimaryColor = Color.fromRGBO(103, 145, 133, 90); // Color
//   final SecondaryColor = Color.fromRGBO(27, 73, 78, 60); // Color

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       bottom: false,
//       child: Scaffold(
//         body: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 height: 600.h,
//                 child: PageView(
//                   physics: ClampingScrollPhysics(),
//                   controller: _pageController,
//                   onPageChanged: (int page) {
//                     setState(() {
//                       _currentPage = page;
//                     });
//                   },
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(40.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Center(
//                             child: Image.asset(
//                               'assets/Onboarding1.png',
//                               // height: 300.0,
//                               // width: 300.0,
//                             ),
//                           ),
//                           SizedBox(height: 30.0.h),
//                           Text(
//                             'Unify all of your medical records,'
//                             '\n'
//                             'from anywhere',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontFamily: 'Roboto-Regular',
//                                 fontSize: 25.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: SecondaryColor),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(40.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Center(
//                             child: Image.asset(
//                                 'assets/OnboardingScreen2.png',
//                               // height: 300.0,
//                               // width: 300.0,
//                             ),
//                           ),
//                           SizedBox(height: 30.0.h),
//                           Text(
//                             'Share instantly and safely with'
//                             '\n'
//                             'doctors and your loved ones',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontFamily: 'Roboto-Regular',
//                                 fontSize: 25.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: SecondaryColor),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(40.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Center(
//                             child: Image.asset(
//                               'assets/Onboard3.png',
//                               // height: 300.0,
//                               // width: 300.0,
//                             ),
//                           ),
//                           SizedBox(height: 30.0.h),
//                           Text(
//                             'Create care teams that''\n''revolve around you',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontFamily: 'Roboto-Regular',
//                                 fontSize: 25.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: SecondaryColor),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: _buildPageIndicator(),
//               ),
//             ],
//           ),
//         ),
//         bottomSheet: _currentPage == _numPages - 1
//             ? InkWell(
//                 onTap: () {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (builder) => LoginScreen()));
//                 },
//                 child: Container(
//                   height: 55.0.h,
//                   width: double.infinity,
//                   color: Color.fromRGBO(27, 73, 78, 60),
//                   child: GestureDetector(
//                     onTap: () async {
//                       await StoreOnboardInfo();
//                       Navigator.pushReplacement(
//                           context,
//                           CustomPageRoute(
//                               child: LoginScreen()));
//                     },
//                     child: Center(
//                       child: Text(
//                         'Get Started',
//                         style: TextStyle(
//                           fontFamily: 'Roboto-Regular',
//                           color: Colors.white,
//                           fontSize: 25.0.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : Text(''),
//       ),
//     );
//   }
// }
