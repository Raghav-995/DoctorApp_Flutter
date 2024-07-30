// import 'dart:convert';
// import 'package:Seerecs/Screens/EnterPassword.dart';
// import 'package:Seerecs/Screens/EnterPin.dart';
// import 'package:Seerecs/Screens/SignInScreen.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:Seerecs/Screens/AppPreferences.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Assets/CustomPageRoute.dart';
// import '../../network/API_Services.dart';
// import '../../network/response?_AlterBox.dart';
// import '../Home_Page.dart';
// import '../LoginScreen.dart';
// import '../VerificationChangePassword.dart';
// import 'BottomNavigationContentScreens/MyActivity.dart';
// import 'BottomNavigationContentScreens/UpdateProfile.dart';
// import '../../Assets/UserModel.dart' as user;
//
// class ProfileBottomNavigation extends StatefulWidget {
//   ProfileBottomNavigation({super.key});
//
//   @override
//   State<ProfileBottomNavigation> createState() =>
//       _ProfileBottomNavigationState();
// }
//
// int? PinSwitchOn;
//
// StoreSetPinInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   PinSwitchOn = prefs.getInt('PinSwitchOn');
// }
//
// SetPinAuthenticationInfo() async {
//   int SetPinAuth = 1;
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setInt('SetPinAuth', SetPinAuth);
// }
//
// final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
// final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);
//
// final AddFamilyMember1 = Color.fromRGBO(216, 104, 250, 90); // Color
// final AddFamilyMember2 = Color.fromRGBO(147, 83, 243, 40); //Color
// final ProfileColor1 = Color.fromRGBO(116, 104, 250, 90); // Color
// final ProfileColor2 = Color.fromRGBO(47, 83, 243, 40); //Color
// final ChangePasswordColor1 = Color.fromRGBO(255, 111, 104, 90); // Color
// final ChangePasswordColor2 = Color.fromRGBO(255, 77, 79, 40); //Color
// final MyActivityColor1 = Color.fromRGBO(148, 218, 255, 90); // Color
// final MyActivityColor2 = Color.fromRGBO(148, 179, 253, 30); //Color
// final ShareLog1 = Color.fromRGBO(44, 221, 183, 90); // Color
// final ShareLog2 = Color.fromRGBO(13, 194, 133, 40); //Color
// final ChangePinColor1 = Color.fromRGBO(245, 66, 102, 100); // Color
// final ChangePinColor2 = Color.fromRGBO(240, 19, 64, 60); //Color
//
// class _ProfileBottomNavigationState extends State<ProfileBottomNavigation> {
//   @override
//   void initState() {
//     super.initState();
//     StoreSetPinInfo();
//   }
//
//   void handleClick(String value) async {
//     switch (value) {
//       case 'App Preferences':
//         int BackButton = 1;
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setInt('BackButton', BackButton);
//         Navigator.push(
//             context, CustomPageRoute(child: StreamLinePreferences()));
//         break;
//       case 'Share':
//         Share.share('Join now to Rule Your Health!! -'
//             "\n"
//             'https://play.google.com/store/apps/details?id=com.example.Seerecs');
//         break;
//       case 'Terminology':
//         CustomSnackBar(context, 'Coming soon...');
//         break;
//       case 'Terms & Condition':
//         CustomSnackBar(context, 'Coming soon...');
//         break;
//       case 'Privacy Policy':
//         CustomSnackBar(context, 'Coming soon...');
//         break;
//       case 'Logout':
//         Navigator.pushReplacement(
//             context, CustomPageRoute(child: LoginScreen()));
//         break;
//     }
//   }
//
//   String? userMail;
//
//   Map<String, dynamic> toJson() {
//     return {
//       (user.Email): (userMail.toString().toLowerCase()),
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: BackButton(
//           onPressed: () {
//             //Navigator.push(context, CustomPageRoute(child: HomePage()));
//           },
//           color: Colors.white,
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.bottomLeft,
//               end: Alignment.topRight,
//               colors: [
//                 AppBarColor1,
//                 AppBarColor2,
//               ],
//             ),
//           ),
//         ),
//         title: Text(
//           'Profile',
//           style: TextStyle(
//               fontFamily: 'Roboto-Regular',
//               fontSize: 35.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.white),
//         ),
//         actions: <Widget>[
//           PopupMenuButton<String>(
//             onSelected: handleClick,
//             itemBuilder: (BuildContext context) {
//               return {
//                 'App Preferences',
//                 'Share',
//                 'Terminology',
//                 'Terms & Condition',
//                 'Privacy Policy',
//                 'Logout',
//               }.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       // Safe area will keep screen under notification panel
//       body: SafeArea(
//         // Container used to take whole screen size with media query.
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           color: Colors.white,
//           // All widgets will bw in list view.
//           child: ListView(
//             children: [
//               // Padding provided to all widgets
//               Padding(
//                 padding: EdgeInsets.fromLTRB(25.0.w, 10.0.h, 25.0.w, 10.0.h),
//                 // Row used to align all widgets in horizontal format
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Color.fromRGBO(27, 73, 78, 200),
//                       radius: 130.0.r,
//                       // Image assets used for to get image from assets folder.
//                       child: Image.asset(
//                         "assets/BottomNaviProfileDyno.png",
//                         height: 155.h,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       // crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                 final api = ApiServices(Dio(), "/userProfile");
//                                 // Will get response? of api.
//                                 final response? =
//                                     await api.ApiUser(toJson(), context);
//                                 print(
//                                     'response? status: ${response?.statusCode}');
//                                 print('response? body: ${response?}');
//
//                                 // Converting api json response? to string.
//                                 String decode = response?.toString();
//                                 Map<String, dynamic> response?Data =
//                                     jsonDecode(decode);
//                                 // id = response?Data['_id'] ?? "";
//                                 String firstName =
//                                     response?Data['firstName'] ?? "";
//                                 String lastName =
//                                     response?Data['lastName'] ?? "";
//                                 String email = response?Data['email'] ?? "";
//                                 String city = response?Data['city'] ?? "";
//                                 String zipcode = response?Data['zipcode'] ?? "";
//                                 String dob = response?Data['dob'] ?? "";
//                                 String address = response?Data['address'] ?? "";
//                                 String phone = response?Data['phone'] ?? "";
//                                 String alternateMail =
//                                     response?Data['alternateEmail'] ?? "";
//                                 String alternatePhone =
//                                     response?Data['alternatePhone'] ?? "";
//                                 Navigator.push(
//                                     context,
//                                     CustomPageRoute(
//                                         child: UpdateProfile(
//                                             // id: id,
//                                             firstName: firstName,
//                                             lastName: lastName,
//                                             email: email,
//                                             city: city,
//                                             zipcode: zipcode,
//                                             dob: dob,
//                                             address: address,
//                                             phone: phone, alternatePhone: '', alternateMail: '',
//                                             //alternateMail: alternateMail,
//                                             //alternatePhone: alternatePhone
//                                             )));
//                               },
//                               child: ProfileContents(
//
//                                   'Update Profile',
//                                   "assets/UpdateProfile.svg.png"),
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             Row(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     CustomSnackBar(context, 'Coming soon...');
//                                   },
//                                   child: ProfileContents(
//
//                                       'Add Family Member',
//                                       "assets/AddPeople.svg.png"),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             Row(
//                               children: [
//                                 InkWell(
//                                   onTap: () async {
//                                     Navigator.push(context,
//                                         CustomPageRoute(child: MyActivity()));
//                                   },
//                                   child: ProfileContents(
//
//                                       'My Activity',
//                                       "assets/MyActivity.svg.png"),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 25.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // PinSwitchOn == 1
//                             //     ? InkWell(
//                             //         onTap: () async {
//                             //           final SharedPreferences prefs =
//                             //               await SharedPreferences.getInstance();
//                             //           prefs.setInt('ChangePin', 0);
//                             //           int ValidatePinBackButton = 1;
//                             //           SharedPreferences prefs1 =
//                             //               await SharedPreferences.getInstance();
//                             //           await prefs1.setInt(
//                             //               'ValidatePinBackButton',
//                             //               ValidatePinBackButton);
//                             //           Navigator.push(context,
//                             //               CustomPageRoute(child: EnterPin()));
//                             //         },
//                             //         child: ProfileContents(
//
//                             //             'Change Password',
//                             //             "assets/ChangePassword.svg.png"),
//                             //       )
//                                  InkWell(
//                                     onTap: () async {
//                                       final api =
//                                           ApiServices(Dio(), "/sendOTP");
//                                       dynamic otpData = json.encode(
//                                           {"description": "Change Password"});
//                                       // verification code will be converted to json body
//                                       Map<String, dynamic> jsonOtpData =
//                                           jsonDecode(otpData);
//                                       // Will get response? of api.
//                                       final response? = await api.ApiUser(
//                                           jsonOtpData, context);
//                                       print(
//                                           'response? status: ${response?.statusCode}');
//                                       print('response? body: ${response?}');
//
//                                       // Converting api json response? to string.
//                                       // String decode = response?.toString();
//                                       // Map<String, dynamic> response?Data =
//                                       //     jsonDecode(decode);
//
//                                       if (response?.statusCode == 200) {
//                                         CustomSnackBar(
//                                             context, 'OTP sent to mail');
//                                         Navigator.push(
//                                             context,
//                                             CustomPageRoute(
//                                                 child:
//                                                     VerificationChangePassword()));
//                                       }
//                                     },
//                                     child: ProfileContents(
//
//                                         'Change Password',
//                                         "assets/ChangePassword.svg.png"),
//                                   ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             // PinSwitchOn == 1
//                             //     ? Row(
//                             //         children: [
//                             //           InkWell(
//                             //             onTap: () async {
//                             //               int SetPinAuth = 0;
//                             //               SharedPreferences prefs =
//                             //                   await SharedPreferences
//                             //                       .getInstance();
//                             //               await prefs.setInt(
//                             //                   'SetPinAuth', SetPinAuth);
//                             //               Navigator.push(
//                             //                   context,
//                             //                   CustomPageRoute(
//                             //                       child: EnterPassword()));
//                             //             },
//                             //             child: ProfileContents(
//
//                             //                 'Change Pin',
//                             //                 "assets/ChangePin.svg.png"),
//                             //           ),
//                             //         ],
//                             //       )
//                                 Row(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           SetPinAuthenticationInfo();
//                                           Navigator.push(
//                                               context,
//                                               CustomPageRoute(
//                                                   child: EnterPassword()));
//                                         },
//                                         child: ProfileContents(
//
//                                             'Set Pin',
//                                             "assets/ChangePin.svg.png"),
//                                       ),
//                                     ],
//                                   ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             Row(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     CustomSnackBar(context, 'Coming soon...');
//                                   },
//                                   child: ProfileContents(
//                                       'Share Log', "assets/ShareLog.svg.png"),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget ProfileContents(contentName, ImageAsset) {
//   return Container(
//     height: 110.h,
//     width: 140.w,
//     child: Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0.r),
//       ),
//       color: Colors.transparent,
//       shadowColor: Colors.grey,
//       elevation: 5,
//       child: Container(
//         decoration: BoxDecoration(
//
//           borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 10.h),
//             Image.asset(
//               ImageAsset,
//               height: 30.h,
//               color: Colors.white,
//             ),
//             SizedBox(height: 5.h),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Text(contentName,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontFamily: 'Roboto-Regular',
//                       fontSize: 17.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
