// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';
// import 'package:Seerecs/Screens/BottomNavigation/Records.dart';
// import 'package:Seerecs/Screens/BottomNavigation/Profile.dart';
// import 'package:Seerecs/Screens/BottomNavigation/Visit.dart';
// import 'package:Seerecs/Screens/BottomNavigation/Care.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../network/API_Services.dart';
// import 'BottomNavigation Screens/CareTeams_BottomNavigations.dart';
// import 'BottomNavigation Screens/Records_BottomNavigation.dart';
// import 'BottomNavigation Screens/Visit_BottomNavigation.dart';
// import 'BottomNavigation Screens/Profile_BottomNavigation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// StoreSetPinInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //PinSwitchOn = prefs.getInt('PinSwitchOn')!;
// }

// // Making Json to be send to API
// Map<String, dynamic> toJson() {
//   return {};
// }

// class _HomePageState extends State<HomePage> {
//   GetRecordApiCall() async {
//     // Call your API here and pass `_verificationCode` as a parameter
//     final api = ApiServices(Dio(), "/getRecord");
//     // Api response? will get
//     final response? = await api.ApiUser(toJson(), context);
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

//     print("Get Record request send to api");
//     // print(otpData());
//   }

//   final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
//   final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);

//   ListQueue<int> _navigationQueue = ListQueue();
//   int _selectedIndex = 0;
//   bool canBack = false;

//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     StoreSetPinInfo();
//     GetRecordApiCall();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   final AppBarColor1 = Color.fromRGBO(16, 104, 250, 90);
//   final AppBarColor2 = Color.fromRGBO(255, 77, 79, 40);

//   Future<bool> _onWillPopHome() async {
//     if (_selectedIndex != 0) {
//       // Navigator.pop(context);
//       setState(() {
//         _selectedIndex = 0;
//         //using this page controller you can make beautiful animation effects
//         _pageController.animateToPage(_selectedIndex,
//             duration: Duration(milliseconds: 500), curve: Curves.easeOut);
//         _navigationQueue.removeLast();
//       });
//     } else if (_selectedIndex == 0) {
//       canBack = await showDialog(
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
//               onPressed: () => Navigator.of(context).pop(true),
//               child: new Text('Yes'),
//             ),
//           ],
//         ),
//       );
//     }
//     return canBack;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         final showPop = await _onWillPopHome();
//         return showPop;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             //border: Border.all(color: Colors.white, width: 7),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: SizedBox.expand(
//             child: PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() => _selectedIndex = index);
//                 index == 0 ? GetRecordApiCall() : null;
//               },
//               children: <Widget>[
//                 //HomeScreen(),
//                 Records(),
//                 Visit(),
//                 Care(),
//                 Profile()
//                 // RecordsBottomNavigation(),
//                 // VisitBottomNavigation(),
//                 // CareTeamBottomNavigation(),
//                 //ProfileBottomNavigation(),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Container(
//           height: 60.h,
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40.r),
//               topRight: Radius.circular(40.r),
//               // bottomLeft: Radius.circular(40.r),
//               // bottomRight: Radius.circular(40.r)),
//             ),
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: PrimaryColor,
//               iconSize: 20.0.sp,
//               selectedIconTheme: IconThemeData(size: 28.0.sp),
//               selectedItemColor: Colors.black,
//               unselectedItemColor: Colors.white,
//               selectedFontSize: 17.sp,
//               unselectedFontSize: 14.sp,
//               currentIndex: _selectedIndex,
//               onTap: _onItemTapped,
//               items: <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.file_present_sharp, size: 25.sp),
//                   label: 'Record',
//                   // backgroundColor: Colors.black
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.handshake,
//                     size: 25.sp,
//                   ),
//                   label: 'Visit',
//                   // backgroundColor: Colors.yellow
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.group,
//                     size: 25.sp,
//                   ),
//                   label: 'Care Team',
//                   // backgroundColor: Colors.blue,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.person,
//                     size: 25.sp,
//                   ),
//                   label: 'Profile',
//                   // backgroundColor: Colors.blue,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       // index == 0 ? GetRecordApiCall() : null;
//       _navigationQueue.addLast(index);
//       //using this page controller you can make beautiful animation effects
//       _pageController.animateToPage(index,
//           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//     });
//   }
// }
