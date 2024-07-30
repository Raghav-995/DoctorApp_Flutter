// import 'dart:ui';
//
// import 'package:Seerecs/Assets/data.dart';
// import 'package:flutter/material.dart';
//
// class AppScrollBehavior extends MaterialScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       };
// }
//
// class PageScroll extends StatefulWidget {
//   const PageScroll({super.key});
//
//   @override
//   State<PageScroll> createState() => _PageScrollState();
// }
//
// class _PageScrollState extends State<PageScroll> {
//   PageController pageController = PageController(initialPage: 0);
//   int _activePage = 0;
//   void onNextPage() {
//     pageController.nextPage(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.fastEaseInToSlowEaseOut,
//     );
//   }
//
//   //final List _screens = [OnboardingData(), WelcomeScreen()];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //scrollBehavior: AppScrollBehavior(),
//       body: PageView(
//         controller: PageController(initialPage:2),
//         scrollDirection: Axis.horizontal,
//         reverse: false,
//         pageSnapping: true,
//         //itemCount: _screens.length,
//         onPageChanged: (index) {
//           print("");
//         },
//         children: [
//           //OnBoardingScreen(title: 'i', description: 'yhjb', skip: false, image: '', onTab: onNextPage, index: 3),
//           OnboardingData(),
//           //WelcomeScreen(),
//         ],
//       ),
//     );
//   }
// }
//
//
// // physics: PageScrollPhysics(),
//             //   pageSnapping: true,
//             //   controller: PageController(
//             //     viewportFraction: 1 / 2,
//             //   ),
//             //   padEnds: false,
//             //   itemCount: _screens.length,
//             //   itemBuilder: (context, index) {
//             //     return OnBoardingScreen(
//             //       index: 2,
//             //       title: _screens[index]['title'],
//             //       description: _screens[index]['description'],
//             //       image:_screens[index]['image'],
//             //       skip:_screens[index]['skip'],
//             //       onTab: onNextPage,
//             //     );