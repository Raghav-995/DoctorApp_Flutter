// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../network/API_Services.dart';
// import 'package:Seerecs/Assets/FamilyModel.dart' as family;
//
// class FamilyMembers extends StatefulWidget {
//   FamilyMembers({Key? key}) : super(key: key);
//
//   @override
//   State<FamilyMembers> createState() => _FamilyMembersState();
// }
//
// List? response?List;
// String? _firstName;
// String? _lastName;
// String? _email;
// String? _mobileNo;
// String? _address;
// String? _city;
// String? _zipCode;
// String? _relation;
//
// Map<String, dynamic> toJson() {
//   return {
//     family.FirstName: _firstName,
//     family.LastName: _lastName,
//     family.Email: _email?.toLowerCase(),
//     family.Contact: _mobileNo,
//     family.Address: _address,
//     family.City: _city,
//     family.Zipcode: _zipCode,
//     family.Relation: _relation,
//   };
// }
//
// DateFormat format = DateFormat('MM/dd/yyyy HH:mm:ss');
//
// class _FamilyMembersState extends State<FamilyMembers> {
//   GetMembersApiCall(context) async {
//     try {
//       final api = ApiServices(Dio(), "/getFamilyMembers");
//       final response? = await api.ApiUser(toJson(), context);
//
//       if (response?.statusCode == 200) {
//         final response?Data = response?.data as Map<String, dynamic>?;
//
//
//         if (response?Data != null) {
//           final dataList = response?Data['data'] as List?;
//
//           if (dataList != null) {
//             response?List = dataList.cast<Map<String, dynamic>>();
//
//             response?List!.sort((a, b) {
//               if (a == null || b == null || a['createdAt'] == null || b['createdAt'] == null) {
//                 print('Error: createdAt field is null.');
//                 return 0; // Treat as equal if createdAt is null
//               }
//
//               DateTime? dateTimeA = DateTime.tryParse(a['createdAt']);
//               DateTime? dateTimeB = DateTime.tryParse(b['createdAt']);
//
//               if (dateTimeA == null || dateTimeB == null) {
//                 print('Error: Failed to parse createdAt field.');
//                 return 0; // Treat as equal if parsing fails
//               }
//
//               return dateTimeB.compareTo(dateTimeA); // Sort B before A
//             });
//           } else {
//             print('Error: response? data does not contain a valid list.');
//           }
//         } else {
//           print('Error: response? data is null or not in the expected format.');
//         }
//       } else {
//         print('Error: API request failed with status code ${response?.statusCode}.');
//       }
//     } catch (e, stackTrace) {
//       print('Error: $e\nStack trace: $stackTrace');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     GetMembersApiCall(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFECF0FD),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Color(0xFFECF0FD),
//         leading: BackButton(
//           color: Color(0xFF02486A),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           'Family Members',
//           style: TextStyle(
//             fontFamily: 'Roboto-Regular',
//             fontSize: 32.sp,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF02486A),
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.view_compact_alt,
//               color: Color(0xFF02486A),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(10.0.w, 10.0.h, 10.0.w, 0.0.h),
//           child: ListView.builder(
//             itemCount: response?List?.length ?? 0,
//             itemBuilder: (BuildContext context, int _id) {
//               final memberData = response?List?[_id];
//               if (memberData == null) {
//                 return SizedBox();
//               }
//               DateTime createdAt = format.parse(memberData['createdAt']);
//               String formattedDate = formatTimestamp(createdAt);
//               String imagePath = "icons/Group 52.png"; // Default image path
//
//               return MembersGrid(
//                 memberData['firstName'].toString(),
//                 memberData['lastName'].toString(),
//                 memberData['relation'].toString(),
//                 formattedDate,
//                 imagePath,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   String formatTimestamp(DateTime createdAt) {
//     DateTime now = DateTime.now();
//     DateTime today = DateTime(now.year, now.month, now.day);
//     DateTime yesterday = today.subtract(Duration(days: 1));
//     DateTime startOfWeek = today.subtract(Duration(days: now.weekday - 1));
//
//     if (createdAt.isAfter(today)) {
//       return DateFormat('h:mm a').format(createdAt).toLowerCase();
//     } else if (createdAt.isAfter(yesterday)) {
//       return 'Yesterday';
//     } else if (createdAt.isAfter(startOfWeek)) {
//       return DateFormat('EEEE').format(createdAt);
//     } else {
//       return DateFormat('MM/dd/yyyy').format(createdAt);
//     }
//   }
// }
//
// Widget MembersGrid(FirstName, LastName, Relation, TimeStamp, ImageAsset) {
//   return Padding(
//     padding: const EdgeInsets.all(6.0),
//     child: Container(
//       height: 70.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.r),
//         color: Colors.white,
//       ),
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
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
//                 ),
//               ),
//             ],
//           ),
//           title: Row(
//             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 FirstName,
//                 style: TextStyle(
//                     height: 2.2,
//                     color: Color(0xFF37304A),
//                     fontSize: 18.sp,
//                     fontFamily: 'Roboto-Regular',
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 LastName,
//                 style: TextStyle(
//                     height: 2.2,
//                     color: Color(0xFF37304A),
//                     fontSize: 18.sp,
//                     fontFamily: 'Roboto-Regular',
//                     fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 TimeStamp,
//                 style: TextStyle(
//                   color: Color(0xFF060606),
//                   fontSize: 15.sp,
//                   fontFamily: 'Roboto-Regular',
//                 ),
//               ),
//             ],
//           ),
//           subtitle: Text(
//             Relation,
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

import 'dart:core';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/AddMember.dart';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../Assets/CustomPageRoute.dart';
import '../../../network/API_Services.dart';
import 'package:Seerecs/Assets/FamilyModel.dart' as family;

import '../../BottomNavigation/Profile.dart';

class FamilyMembers extends StatefulWidget {
  FamilyMembers({
    Key? key,
  }) : super(key: key);

  @override
  State<FamilyMembers> createState() => _FamilyMembersState();
}

//String? userMail;
//late List response?List;
List? responseList;
String? firstName;
String? lastName;
String? email;
String? mobileNo;
String? address;
String? city;
String? zipCode;
String? relation;

Map<String, dynamic> familyMemberData() {
  return {
    (family.firstName): (firstName),
    (family.lastName): (lastName),
    (family.email): (email.toString().toLowerCase()),
    (family.contactNo): (mobileNo),
    (family.address): (address),
    (family.city): (city),
    (family.zipCode): (zipCode),
    (family.relation): (relation),
  };
}

DateFormat format = DateFormat('MM/dd/yyyy HH:mm:ss');

class _FamilyMembersState extends State<FamilyMembers> {
  GetMembersApiCall(context) async {
    final api = ApiServices(Dio(), "/getFamilyMembers");
    final response = await api.ApiUser(familyMemberData(), context);

    print('response? body: ${response.data}');
    print('Status code : ${response.statusCode}');

    if (response.statusCode == 200) {
      setState(() {
        // Access the list of family members directly from response?.data
        var responseData = response.data;
        if (response.data != null && responseData is List) {
          responseList = responseData;
        } else {
          print("Error: response? data is not a List");
          // Handle the case where the data is not a List
          // For example, you could log an error message or handle it in any appropriate way
        }

        // Sort response?List if needed
        if (responseList != null) {
          try {
            responseList!.sort((a, b) {
              // Ensure a and b are not null before accessing properties
              if (a != null && b != null) {
                // Parse createdAt strings and handle format exceptions
                try {
                  DateTime dateTimeA = format.parse(a['createdAt'] ?? '');
                  DateTime dateTimeB = format.parse(b['createdAt'] ?? '');
                  // Your sorting logic here
                  return dateTimeB.compareTo(dateTimeA); // Sort B before A
                } catch (e) {
                  print("Error parsing createdAt string: $e");
                  return 0; // Return 0 if there's an error parsing the date
                }
              } else {
                // Handle the case where a or b is null
                return 0;
              }
            });
          } catch (e) {
            print("Error sorting response?List: $e");
            // Handle the error when sorting response?List
          }
        }
      });
    }
  }

  void navigateToNextScreen(BuildContext context) {
    // Navigate to the desired screen using Navigator.push
    Navigator.push(context, CustomPageRoute(child: BottomNavigation()));
  }

  @override
  void initState() {
    super.initState();
    GetMembersApiCall(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigateToNextScreen(context);

        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFECF0FD),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFECF0FD),
          leading: BackButton(
            color: Color(0xFF02486A),
            onPressed: () =>
                Navigator.push(context, CustomPageRoute(child: Profile())),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: Text(
            'Family Members',
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
                // Extracting data from the response?List[index]
                Map<String, dynamic>? memberData = responseList?[index];
                if (memberData == null) {
                  // Handle case where memberData is null
                  return SizedBox(); // or any other widget as needed
                }
                DateTime createdAt;
                try {
                  String createdAtString = memberData['createdAt'] ?? '';
                  if (createdAtString.isNotEmpty) {
                    createdAt = format.parse(createdAtString);
                  } else {
                    // Handle the case where createdAt string is empty or null
                    // For example, provide a default value or handle it in any other appropriate way
                    createdAt =
                        DateTime.now(); // Default value (current date and time)
                  }
                } catch (e) {
                  print("Error parsing createdAt string: $e");
                  // Handle the error (e.g., provide default value)
                  createdAt =
                      DateTime.now(); // Default value (current date and time)
                }

                String formattedDate = formatTimestamp(createdAt);
                String imagePath;
                imagePath = "assets/Group 30.png";

                return MembersGrid(
                  memberData['firstName'].toString(),
                  memberData['lastName'].toString(),
                  memberData['relation'].toString(),
                  formattedDate,
                  imagePath,
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              CustomPageRoute(child: AddMember()),
            );
          },
          backgroundColor: Color(0xFFB2A0FB),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

Widget MembersGrid(firstName, lastName, relation, timeStamp, imageAsset) {
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
                  height: 70.h,
                ),
              ),
            ],
          ),
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                firstName,
                style: TextStyle(
                    height: 2.2,
                    color: Color(0xFF37304A),
                    fontSize: 18.sp,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                lastName,
                style: TextStyle(
                    height: 2.2,
                    color: Color(0xFF37304A),
                    fontSize: 18.sp,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 80,
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
            relation,
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
