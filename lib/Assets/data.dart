// import 'package:Seerecs/Assets/CustomPageRoute.dart';
// import 'package:Seerecs/Screens/AppPreferences.dart';
// import 'package:Seerecs/Screens/Home_Page.dart';
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:Seerecs/Assets/pagescroll.dart';
//
// class AppScrollBehavior extends MaterialScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       };
// }
//
// class OnboardingData extends StatefulWidget {
//   const OnboardingData({super.key});
//
//   @override
//   State<OnboardingData> createState() => _OnboardingDataState();
// }
//
// class _OnboardingDataState extends State<OnboardingData> {
//   final PageController _pageController = PageController();
//
//   int _activePage = 0;
//
//   // void onNextPage() {
//   //   if (_activePage < _pages.length) {
//   //     _pageController.nextPage(
//   //       duration: const Duration(milliseconds: 500),
//   //       curve: Curves.fastEaseInToSlowEaseOut,
//   //     );
//   //   }
//   // }
//
//   // final List<Map<String, dynamic>> _pages = [
//   //   {
//   //     //'color': '#ffe24e',
//   //     'title': 'View Health Records',
//   //     'image': 'assets/Doc-03 1.png',
//   //     'description':
//   //         "C-Recs is a healthcare app that helps users manage and track their health and wellness.",
//   //     'skip': false
//   //   },
//   //   {
//   //     //'color': '#a3e4f1',
//   //     'title': 'Visit',
//   //     'image': 'assets/Doc 1.png',
//   //     'description':
//   //         'C-Recs provides instant appointments when needed, with the desired choice of medical experts.',
//   //     'skip': false
//   //   },
//   //   {
//   //     //'color': '#31b77a',
//   //     'title': 'Care Team',
//   //     'image': 'assets/Doc-02 1.png',
//   //     'description':
//   //         'The easiest way to track your medical personnel, stay in touch, and help them be efficient, even on the go.',
//   //     'skip': true
//   //   },
//
//   // ];
//
//   // late var finalToken;
//   // Future respectiveNavigation(context) {
//   //   return _pages == 1
//   //       ? Navigator.pushReplacement(
//   //           context, CustomPageRoute(child: (StreamLinePreferences())))
//   //       : Navigator.pushReplacement(
//   //           context,
//   //           CustomPageRoute(
//   //               child: (finalToken == null ? WelcomeScreen() : HomePage())));
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//               controller: _pageController,
//               itemCount: 4,
//               scrollBehavior: AppScrollBehavior(),
//               onPageChanged: (int page) {
//                 setState(() {
//                   _activePage = page;
//                 });
//               },
//               itemBuilder: (BuildContext context, int index) {
//                 return Positioned(
//                   //top: MediaQuery.of(context).size.height / 1.05,
//                   top: 500,
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   child: Column(
//                     children: [
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: _buildIndicator())
//                     ],
//                   ),
//                 );
//                 //return WelcomeScreen();
//               }),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildIndicator() {
//     final indicators = <Widget>[];
//
//     for (var i = 0; i < 4; i++) {
//       if (_activePage == i) {
//         indicators.add(_indicatorsTrue());
//       } else {
//         indicators.add(_indicatorsFalse());
//       }
//     }
//     return indicators;
//   }
//
//   Widget _indicatorsTrue() {
//     final String color;
//     if (_activePage == 0) {
//       color = '#3C3785';
//     } else if (_activePage == 1) {
//       color = '#3C3785';
//     } else {
//       color = '#3C3785';
//     }
//
//     return AnimatedContainer(
//       duration: const Duration(microseconds: 300),
//       height: 10,
//       width: 10,
//       margin: const EdgeInsets.only(right: 18),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         color: Color(0xFF3C3785),
//       ),
//     );
//   }
//
//   Widget _indicatorsFalse() {
//     return AnimatedContainer(
//       duration: const Duration(microseconds: 300),
//       height: 10,
//       width: 10,
//       margin: const EdgeInsets.only(right: 18),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         color: Colors.grey.shade100,
//       ),
//     );
//   }
// }
