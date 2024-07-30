
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class Sharelog extends StatefulWidget {
  Sharelog({
    super.key,
  });

  @override
  State<Sharelog> createState() => _SharelogState();
}

String? userMail;
List? responseList;

// Map<String, dynamic> toJson() {
//   return {
//     ('email'): (userMail.toString().toLowerCase()),
//   };
// }


//Colors
// final MyActivityColor1 = Color.fromRGBO(52, 145, 184, 90);
// final MyActivityColor2 = Color.fromRGBO(38, 90, 112, 60);

//Date time format
DateFormat format = new DateFormat('MM/dd/yyyy HH:mm:ss');

class _SharelogState extends State<Sharelog> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return Scaffold(
      backgroundColor: Color(0xFFECF0FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFECF0FD),
        //automaticallyImplyLeading: false,
        leading: BackButton(
          color: Color(0xFF02486A),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            //color: Color(0xFFB2A0FB),
          ),
        ),
        title: Text(
          'Share log',
          style: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF02486A)
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.view_compact_alt,
        //         color: Color(0xFF02486A),
        //       )),
        // ],
      ),
      // // Safe area will keep screen under notification panel
      body: SafeArea(
        child: Center(
          child: Text(
            'Nothing Shared Yet',style: TextStyle(fontSize: 18),),
        )
          //padding: EdgeInsets.fromLTRB(10.0.w, 10.0.h, 10.0.w, 0.0.h),
          // child: Column(
          //   children: [
          //     Container(
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
          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
          //                   color: Color(0xFFECEFFB), // Specify the background color of the container
          //                 ),
          //                 child: CircleAvatar(
          //                   backgroundColor: Color(0xFFECEFFB),
          //                   radius: 30.r,
          //                   child: Image.asset(
          //                     "icons/Group.png",
          //                     height: 30.h,
          //                     //color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           title: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Reports Access Expired',
          //                 style: TextStyle(
          //                     height: 2.2,
          //                     color: Color(0xFF37304A),
          //                     fontSize: 18.sp,
          //                     fontFamily: 'Roboto-Regular',
          //                     fontWeight: FontWeight.w600),
          //               ),
          //               Text(
          //                 " 12:38 pm",
          //                 style: TextStyle(
          //                   color: Color(0xFF060606),
          //                   fontSize: 15.sp,
          //                   fontFamily: 'Roboto-Regular',
          //                   //fontWeight: FontWeight.w400
          //                 ),
          //               ),
          //             ],
          //           ),
          //           subtitle: Text(
          //             "Dr. Den’s access to reports revoked",
          //             style: TextStyle(
          //                 color: Color(0xFF5C7581),
          //                 fontSize: 15.sp,
          //                 fontFamily: 'Roboto-Regular',
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 10.h,
          //     ),
          //     Container(
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
          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
          //                   color: Color(0xFFECEFFB), // Specify the background color of the container
          //                 ),
          //                 child: CircleAvatar(
          //                   backgroundColor: Color(0xFFECEFFB),
          //                   radius: 30.r,
          //                   child: Image.asset(
          //                     "icons/Vector (4).png",
          //                     height: 30.h,
          //                     //color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           title: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Reports Seen By Doctor',
          //                 style: TextStyle(
          //                     height: 2.2,
          //                     color: Color(0xFF37304A),
          //                     fontSize: 18.sp,
          //                     fontFamily: 'Roboto-Regular',
          //                     fontWeight: FontWeight.w600),
          //               ),
          //               Text(
          //                 " 12:38 pm",
          //                 style: TextStyle(
          //                   color: Color(0xFF060606),
          //                   fontSize: 15.sp,
          //                   fontFamily: 'Roboto-Regular',
          //                   //fontWeight: FontWeight.w400
          //                 ),
          //               ),
          //             ],
          //           ),
          //           subtitle: Text(
          //             "Dr. Fox seen your reports",
          //             style: TextStyle(
          //                 color: Color(0xFF5C7581),
          //                 fontSize: 15.sp,
          //                 fontFamily: 'Roboto-Regular',
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 10.h,
          //     ),
          //     Container(
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
          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
          //                   color: Color(0xFFECEFFB), // Specify the background color of the container
          //                 ),
          //                 child: CircleAvatar(
          //                 backgroundColor: Color(0xFFECEFFB),
          //                   radius: 30.r,
          //                   child: Image.asset(
          //                     "icons/Group (1).png",
          //                     height: 30.h,
          //                     //color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           title: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Reports Delivered To Doctor',
          //                 style: TextStyle(
          //                     height: 2.2,
          //                     color: Color(0xFF37304A),
          //                     fontSize: 18.sp,
          //                     fontFamily: 'Roboto-Regular',
          //                     fontWeight: FontWeight.w600),
          //               ),
          //               Text(
          //                 " 6/2/24 ",
          //                 style: TextStyle(
          //                   color: Color(0xFF060606),
          //                   fontSize: 15.sp,
          //                   fontFamily: 'Roboto-Regular',
          //                   //fontWeight: FontWeight.w400
          //                 ),
          //               ),
          //             ],
          //           ),
          //           subtitle: Text(
          //             "Dr. Fox received your reports ",
          //             style: TextStyle(
          //                 color: Color(0xFF5C7581),
          //                 fontSize: 15.sp,
          //                 fontFamily: 'Roboto-Regular',
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 10.h,
          //     ),
          //     Container(
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
          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
          //                   color: Color(0xFFECEFFB), // Specify the background color of the container
          //                 ),
          //                 child: CircleAvatar(
          //                   backgroundColor: Color(0xFFECEFFB),
          //                   radius: 30.r,
          //                   child: Image.asset(
          //                     "icons/Group (2).png",
          //                     height: 30.h,
          //                     //color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           title: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Reports Shared For 24 Hrs',
          //                 style: TextStyle(
          //                     height: 2.2,
          //                     color: Color(0xFF37304A),
          //                     fontSize: 18.sp,
          //                     fontFamily: 'Roboto-Regular',
          //                     fontWeight: FontWeight.w600),
          //               ),
          //               Text(
          //                 " 6/2/24",
          //                 style: TextStyle(
          //                   color: Color(0xFF060606),
          //                   fontSize: 15.sp,
          //                   fontFamily: 'Roboto-Regular',
          //                   //fontWeight: FontWeight.w400
          //                 ),
          //               ),
          //             ],
          //           ),
          //           subtitle: Text(
          //             "You shared your reports with Dr. Fox",
          //             style: TextStyle(
          //                 color: Color(0xFF5C7581),
          //                 fontSize: 15.sp,
          //                 fontFamily: 'Roboto-Regular',
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),

          // child: ListView.builder(
          //     itemCount: response?List == null ? 0 : response?List?.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return MyActivityGrid(
          //           response?List?[index]['action'].toString(),
          //           response?List?[index]['description'].toString(),
          //           DateFormat('MM/dd/yyyy HH:mm:ss')
          //               .format(format
          //               .parse(response?List?[index]['createdAt'])
          //               .add(DateTime.now().timeZoneOffset))
          //               .toString()
          //               .substring(0, 19),
          //           "assets/Login.svg.png");
          //     }),

          //     DateTime createdAt = format.parse(response?List![index]['createdAt']);
            
          //     // Get today's date at midnight
          //     DateTime today = DateTime.now().subtract(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second));
            
          //     // Get yesterday's date at midnight
          //     DateTime yesterday = today.subtract(Duration(days: 1));
            
          //     String formattedDate;
          //     if (createdAt.isAfter(today)) {
          //       // Operation done today, show time
          //       formattedDate = DateFormat('hh:mm a').format(createdAt).toLowerCase();
          //     } else if (createdAt.isAfter(yesterday)) {
          //       // Operation done yesterday, show 'Yesterday'
          //       //formattedDate = 'Yesterday';
          //       formattedDate = DateFormat('EEEE').format(createdAt);
          //     } else {
          //       // Operation done earlier, show date in a different format
          //       formattedDate = DateFormat('dd/MM/yyyy').format(createdAt);
          //     }
            
          //     String imagePath;
              // String action = response?List![index]['action'].toString();
              // if (action == 'PIN Validation' || action == 'Set PIN') {
              //   imagePath = "icons/Vector.png";
              // } else if (action == 'Validate Password' || action == 'Forgot Password') {
              //   imagePath = "icons/Vector2.png";
              // } else if (action == 'Validate Password') {
              //   imagePath = "icons/Vector3.png";
              // }
              // else {
              //   imagePath = "icons/Vector3.png"; // Default image if action is unknown
              // }
              // return SharelogGrid(
              //     response?List![index]['action'].toString(),
              //     response?List![index]['description'].toString(),
              //     formattedDate,
              //     imagePath
              // );




    );
  }
}

//Widget SharelogGrid(Action, Description, TimeStamp, ImageAsset) {

//}
