// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../network/MyActivityApi.dart';
//
// class MyActivity extends StatefulWidget {
//   MyActivity({
//     super.key,
//   });
//
//   @override
//   State<MyActivity> createState() => _MyActivityState();
// }
//
// String? userMail;
// List? response?List;
//
// Map<String, dynamic> toJson() {
//   return {
//     ('email'): (userMail.toString().toLowerCase()),
//   };
// }
//
//
// //Colors
// // final MyActivityColor1 = Color.fromRGBO(52, 145, 184, 90);
// // final MyActivityColor2 = Color.fromRGBO(38, 90, 112, 60);
//
// //Date time format
// DateFormat format = new DateFormat('MM/dd/yyyy HH:mm:ss');
//
// class _MyActivityState extends State<MyActivity> {
//   MyActivityApiCall(context) async {
//     //print('MyActivityApiCall - start');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userMail = prefs.getString('userMail');
//     print(userMail);
//
//     final api = MyActivityApi(Dio(), "/activityLogs");
//     // Will get response? of api.
//     final response? = await api.ApiUser(toJson(), context);
//     print('response? body: ${response?.data}');
//     print('Status code : ${response?.statusCode}');
//     if (response?.statusCode == 200) {
//       setState(() {
//         response?List = response?.data['data'] as List;
//       });
//     }
//     //print('MyActivityApiCall - End');
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     //print('MyActivity initState');
//     MyActivityApiCall(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //print('MyActivity build - start');
//     //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
//     return Scaffold(
//       backgroundColor: Color(0xFFECF0FD),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Color(0xFFECF0FD),
//         //automaticallyImplyLeading: false,
//           leading: BackButton(
//             color: Color(0xFF02486A),
//             onPressed: () => Navigator.pop(context),
//           ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             //color: Color(0xFFB2A0FB),
//           ),
//         ),
//         title: Text(
//           'My Activity',
//           style: TextStyle(
//               fontFamily: 'Roboto-Regular',
//               fontSize: 32.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF02486A)
//           ),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.view_compact_alt,
//                 color: Color(0xFF02486A),
//               )),
//         ],
//       ),
//       // Safe area will keep screen under notification panel
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(10.0.w, 10.0.h, 10.0.w, 0.0.h),
//           child: ListView.builder(
//             itemCount: response?List == null ? 0 : response?List!.length,
//             itemBuilder: (BuildContext context, int index) {
//               //print('ListView itemBuilder - Index: $index');
//               DateTime createdAt = format.parse(response?List![index]['createdAt']);
              // DateTime now = DateTime.now();
              // //DateTime today = DateTime.now();
              // //String formattedTime = DateFormat.Hm().format(now);
              // //DateTime today = Duration(hours:DateTime.now().hour);
              // DateTime today = DateTime(now.year, now.month, now.day);
              // //DateTime today = DateTime.now().subtract(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second));
              //
              // DateTime yesterday = today.subtract(Duration(days: 1));
              // //DateTime Weekday = today.subtract(Duration(days: 2));
              //
              // DateTime Weekday = today.subtract(Duration(days: now.weekday-1));
              //
              // String formattedDate;
              // if (createdAt.isAfter(today)) {
              //   formattedDate = DateFormat('h:mm a').format(createdAt).toLowerCase();
              //   print('Day1: $formattedDate');
              // } else if (createdAt.isAfter(yesterday)) {
              //   formattedDate = 'Yesterday';
              //   print('Day2: $formattedDate');
              // } else if (createdAt.isAfter(Weekday)) {
              //   formattedDate = DateFormat('EEEE').format(createdAt);
              //   print('Day3: $formattedDate');
              // } else {
              //   formattedDate = DateFormat('MM/dd/yyyy').format(createdAt);
              //   print('Day4: $formattedDate');
              // }
//               String formatTimestamp(DateTime createdAt) {
//                 DateTime now = DateTime.now();
//                 DateTime today = DateTime(now.year, now.month, now.day);
//                 DateTime yesterday = today.subtract(Duration(days: 1));
//                 DateTime startOfWeek = today.subtract(Duration(days: now.weekday - 1));
//
//                 if (createdAt.isAfter(today)) {
//                   return DateFormat('h:mm a').format(createdAt).toLowerCase();
//                 } else if (createdAt.isAfter(yesterday)) {
//                   return 'Yesterday';
//                 } else if (createdAt.isAfter(startOfWeek)) {
//                   return DateFormat('EEEE').format(createdAt);
//                 } else {
//                   return DateFormat('MM/dd/yyyy').format(createdAt);
//                 }
//               }
//
//
//               String imagePath;
//               String action = response?List![index]['action'].toString();
//               if (action == 'PIN Validation' || action == 'Set PIN') {
//                 imagePath = "icons/Group 51.png";
//               } else if (action == 'Validate Password' || action == 'Forgot Password') {
//                 imagePath = "icons/Group 53.png";
//               } else if (action == 'Update Profile') {
//                 imagePath = "icons/Group 52.png";
//               }
//               else {
//                 imagePath = "icons/Group 52.png"; // Default image if action is unknown
//               }
//               return MyActivityGrid(
//                   response?List![index]['action'].toString(),
//                   response?List![index]['description'].toString(),
//                   formattedDate,
//                   imagePath
//               );
//             },
//           ),
//         ),
//       ),
//     );
//     print('MyActivity build - End');
//   }
// }
//
// Widget MyActivityGrid(Action, Description, TimeStamp, ImageAsset) {
//   //print('Action: $Action');
//   return Padding(
//     padding: const EdgeInsets.all(6.0),
//     child: Container(
//       //padding: EdgeInsets.only(top: 10),
//       height: 70.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.r),
//         color: Colors.white,
//         // color: Color.fromRGBO(24, 125, 203, 100),
//       ),
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0), // Adjust the value as needed
//         ),
//         child: ListTile(
//           tileColor: Colors.white,
//           leading: Stack(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Color(0xFFECEFFB),
//                 radius: 35.r,
//                 child: Image.asset(
//                   ImageAsset,
//                   height: 30.h,
//                   //color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${Action} ',
//                 style: TextStyle(
//                   height: 2.2,
//                     color: Color(0xFF37304A),
//                     fontSize: 18.sp,
//                     fontFamily: 'Roboto-Regular',
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 TimeStamp,
//                 style: TextStyle(
//                     color: Color(0xFF060606),
//                     fontSize: 15.sp,
//                     fontFamily: 'Roboto-Regular',
//                     //fontWeight: FontWeight.w400
//                 ),
//               ),
//             ],
//           ),
//           subtitle: Text(
//             Description,
//             style: TextStyle(
//                 color: Color(0xFF5C7581),
//                 fontSize: 15.sp,
//                 fontFamily: 'Roboto-Regular',
//                 fontWeight: FontWeight.w500),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../network/MyActivityApi.dart';

class MyActivity extends StatefulWidget {
  MyActivity({
    Key? key,
  }) : super(key: key);

  @override
  State<MyActivity> createState() => _MyActivityState();
}

String? userMail;
List? responseList;

Map<String, dynamic> ActivityData() {
  return {
    ('email'): (userMail.toString().toLowerCase()),
  };
}

DateFormat format = DateFormat('MM/dd/yyyy HH:mm:ss');

class _MyActivityState extends State<MyActivity> {
  MyActivityApiCall(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userMail = prefs.getString('userMail');
    print(userMail);

    final api = MyActivityApi(Dio(), "/activityLogs");
    final response = await api.ApiUser(ActivityData(), context);
    print('response? body: ${response.data}');
    print('Status code : ${response.statusCode}');
    if (response.statusCode == 200) {
      setState(() {
        responseList = response.data['data'] as List;
        // Sort response?List
        if (responseList != null) {
          responseList!.sort((a, b) {
            DateTime dateTimeA = format.parse(a['createdAt']);
            DateTime dateTimeB = format.parse(b['createdAt']);
            DateTime now = DateTime.now();
            DateTime today = DateTime(now.year, now.month, now.day);
            DateTime yesterday = today.subtract(Duration(days: 1));
            DateTime startOfWeek = today.subtract(Duration(days: now.weekday - 1));

            if (dateTimeA.isAfter(today)) {
              return -1; // Sort A before B
            } else if (dateTimeB.isAfter(today)) {
              return 1; // Sort B before A
            } else if (dateTimeA.isAfter(yesterday)) {
              return -1; // Sort A before B
            } else if (dateTimeB.isAfter(yesterday)) {
              return 1; // Sort B before A
            } else if (dateTimeA.isAfter(startOfWeek)) {
              return -1; // Sort A before B
            } else if (dateTimeB.isAfter(startOfWeek)) {
              return 1; // Sort B before A
            } else {
              // Sort by date
              return dateTimeB.compareTo(dateTimeA); // Sort B before A
            }
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    MyActivityApiCall(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFECF0FD),
        leading: BackButton(
          color: Color(0xFF02486A),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        title: Text(
          'My Activity',
          style: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF02486A)),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.view_compact_alt,
        //       color: Color(0xFF02486A),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0.w, 10.0.h, 10.0.w, 0.0.h),
          child: ListView.builder(
            itemCount: responseList == null ? 0 : responseList!.length,
            itemBuilder: (BuildContext context, int index) {
              DateTime createdAt = format.parse(responseList![index]['createdAt']);
              String formattedDate = formatTimestamp(createdAt);

              String imagePath;
              String action = responseList![index]['action'].toString();
              if (action == 'PIN Validation' || action == 'Set PIN') {
                imagePath = "icons/Group 51.png";
              } else if (action == 'Validate Password' || action == 'Forgot Password') {
                imagePath = "icons/Group 53.png";
              } else if (action == 'Update Profile') {
                imagePath = "icons/Group 52.png";
              } else {
                imagePath = "icons/Group 52.png"; // Default image if action is unknown
              }

              return MyActivityGrid(
                responseList![index]['action'].toString(),
                responseList![index]['description'].toString(),
                formattedDate,
                imagePath,
              );
            },
          ),
        ),
      ),
    );
  }

  String formatTimestamp(DateTime createdAt) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime startOfWeek = today.subtract(Duration(days: now.weekday - 1));

    if (createdAt.isAfter(today)) {
      return DateFormat('h:mm a').format(createdAt).toLowerCase();
    } else if (createdAt.isAfter(yesterday)) {
      return 'Yesterday';
    } else if (createdAt.isAfter(startOfWeek)) {
      return DateFormat('EEEE').format(createdAt);
    } else {
      return DateFormat('MM/dd/yyyy').format(createdAt);
    }
  }
}

Widget MyActivityGrid(Action, Description, TimeStamp, ImageAsset) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Container(
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          tileColor: Colors.white,
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFECEFFB),
                radius: 35.r,
                child: Image.asset(
                  ImageAsset,
                  height: 30.h,
                ),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$Action ',
                style: TextStyle(
                    height: 2.2,
                    color: Color(0xFF37304A),
                    fontSize: 18.sp,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.w600),
              ),
              Text(
                TimeStamp,
                style: TextStyle(
                  color: Color(0xFF060606),
                  fontSize: 15.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ],
          ),
          subtitle: Text(
            Description,
            style: TextStyle(
                color: Color(0xFF5C7581),
                fontSize: 15.sp,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ),
  );
}