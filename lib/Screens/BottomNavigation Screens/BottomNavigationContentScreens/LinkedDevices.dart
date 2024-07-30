import 'package:Seerecs/network/API_Services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
//import '../Assets/UserModel.dart' as user;
import 'package:Seerecs/Assets/UserModel.dart' as user;


class LinkedDevices extends StatefulWidget {
  LinkedDevices({
    Key? key,
  }) : super(key: key);

  @override
  State<LinkedDevices> createState() => _LinkedDevicesState();
}

String? userMail;
List? responseList;
var deviceName;
var os;
var osVersion;
Map<String, dynamic> deviceData() {
  return {
    (user.deviceName): (deviceName.toString()),
    (user.os): (os.toString()),
    (user.osVersion): (osVersion.toString()),
  };
}

DateFormat format = DateFormat('MM/dd/yyyy HH:mm:ss');

class _LinkedDevicesState extends State<LinkedDevices> {
  linkedDevicesApiCall(context) async {
    final api = ApiServices(Dio(), "/addDeviceInfo");
    final response = await api.ApiUser(deviceData(), context);
    print('response body: ${response.data}');
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
            DateTime startOfWeek =
                today.subtract(Duration(days: now.weekday - 1));

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
    linkedDevicesApiCall(context);
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
          'Linked Devices',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Device Logged In',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: responseList == null ? 0 : responseList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime createdAt =
                        format.parse(responseList![index]['createdAt']);
                    String formattedDate = formatTimestamp(createdAt);

                    String imagePath;
                    String action = responseList![index]['action'].toString();
                    if (action == 'PIN Validation' || action == 'Set PIN') {
                      imagePath = "icons/Group 51.png";
                    } else if (action == 'Validate Password' ||
                        action == 'Forgot Password') {
                      imagePath = "icons/Group 53.png";
                    } else if (action == 'Update Profile') {
                      imagePath = "icons/Group 52.png";
                    } else {
                      imagePath =
                          "icons/Group 52.png"; // Default image if action is unknown
                    }

                    return MyActivityGrid(
                      responseList![index]['os'].toString(),
                      responseList![index]['deviceName'].toString(),
                      formattedDate,
                      imagePath,
                    );
                  },
                ),
              ),
            ],
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

Widget MyActivityGrid(os, deviceName, timeStamp, imageAsset) {
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
                  imageAsset,
                  height: 30.h,
                ),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                os,
                style: TextStyle(
                    height: 2.2,
                    color: Color(0xFF37304A),
                    fontSize: 18.sp,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.w600),
              ),
              Text(
                timeStamp,
                style: TextStyle(
                  color: Color(0xFF060606),
                  fontSize: 15.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ],
          ),
          subtitle: Text(
            deviceName,
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
