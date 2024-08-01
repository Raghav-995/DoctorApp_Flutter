import 'package:Seerecs/Screens/BottomNavigation/careTeam.dart';
import 'package:Seerecs/Screens/CareTeam/AddProvider.dart';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../Assets/CustomPageRoute.dart';
import '../../network/API_Services.dart';
import 'package:Seerecs/Assets/CareTeamModel.dart' as care;

class getProvider extends StatefulWidget {
  getProvider({
    Key? key,
    this.careTeamName, this.careTeamId, this.profileImagePath}) : super(key: key);
  final String? careTeamName;
  final String? careTeamId;
  final String? profileImagePath;
  @override
  State<getProvider> createState() => _getProviderState();
}

//String? userMail;
//late List response?List;
List? responseList;
var firstName;
var lastName;
var mobileNo;
var designation;


DateFormat format = DateFormat('MM/dd/yyyy HH:mm:ss');

class _getProviderState extends State<getProvider> {

  Map<String, dynamic> providerData() {
    return {
      // ('careTeamName'): (careTeamName.toString()),
      // (care.firstName): (firstName),
      // (care.lastName): (lastName),
      // (care.contactNo): (mobileNo),
      // (care.designation): (designation),
      (care.careTeamId): (widget.careTeamId),
    };
  }

  // GetProviderApi(context) async {
  //   final api = ApiServices(Dio(), "/getProvider");
  //   // dynamic providerData = json.encode({"careTeamId": widget.careTeamId});
  //   // Map<String, dynamic> data = json.decode(providerData);
  //   //final response = await api.ApiUser(data, context);
  //
  //   final response = await api.ApiUser(providerData(), context);
  //   print('Response body: ${response.data}');
  //   print('Status code : ${response.statusCode}');
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       var responseData = response.data;
  //       if (responseData != null && responseData['providers'] is List) {
  //         List<dynamic> providers = responseData['providers'];
  //         responseList = providers.cast<Map<String, dynamic>>();
  //       } else {
  //         print("Error: 'providers' field is not a List in the response? data");
  //       }
  //
  //       if (responseList != null) {
  //         try {
  //           responseList!.sort((a, b) {
  //             if (a != null && b != null) {
  //               try {
  //                 DateTime dateTimeA = DateTime.parse(a['createdAt'] ?? '');
  //                 DateTime dateTimeB = DateTime.parse(b['createdAt'] ?? '');
  //                 return dateTimeB.compareTo(dateTimeA);
  //               } catch (e) {
  //                 print("Error parsing createdAt string: $e");
  //                 return 0;
  //               }
  //             } else {
  //               return 0;
  //             }
  //           });
  //         } catch (e) {
  //           print("Error sorting response?List: $e");
  //         }
  //       }
  //     });
  //   }
  // }
  void getProviderData() async {
    final api = ApiServices(Dio(), "/getProvider");
    final response = await api.ApiUser(providerData(), context);
    print('Response body: ${response.data}');
    print('Status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      setState(() {
        var responseData = response.data;
        if (responseData != null && responseData['providers'] is List) {
          List<dynamic> providers = responseData['providers'];
          responseList = providers.cast<Map<String, dynamic>>();
          // Filter the responseList based on the careTeamId
          responseList = responseList!
              .where((provider) => provider['careTeamId'] == widget.careTeamId)
              .toList();
        } else {
          print("Error: 'providers' field is not a List in the response data");
        }

        if (responseList != null) {
          try {
            responseList!.sort((a, b) {
              if (a != null && b != null) {
                try {
                  DateTime dateTimeA = DateTime.parse(a['createdAt'] ?? '');
                  DateTime dateTimeB = DateTime.parse(b['createdAt'] ?? '');
                  return dateTimeB.compareTo(dateTimeA);
                } catch (e) {
                  print("Error parsing createdAt string: $e");
                  return 0;
                }
              } else {
                return 0;
              }
            });
          } catch (e) {
            print("Error sorting responseList: $e");
          }
        }
      });
    }
  }

  void navigateToNextScreen(BuildContext context) {
    // Navigate to the desired screen using Navigator.push
    Navigator.pushReplacement(context, CustomPageRoute(child: BottomNavigation()));
  }
  // Map<String, int> careTeamProviderCount = {};
  //
  // // Function to increment the count of providers for a care team
  // void incrementCareTeamProviderCount(String careTeamId) {
  //   setState(() {
  //     careTeamProviderCount[careTeamId] = (careTeamProviderCount[careTeamId] ?? 0) + 1;
  //   });
  // }
  //
  // // Function to decrement the count of providers for a care team
  // void decrementCareTeamProviderCount(String careTeamId) {
  //   setState(() {
  //     if (careTeamProviderCount.containsKey(careTeamId)) {
  //       careTeamProviderCount[careTeamId] = careTeamProviderCount[careTeamId]! - 1;
  //       if (careTeamProviderCount[careTeamId] == 0) {
  //         careTeamProviderCount.remove(careTeamId);
  //       }
  //     }
  //   });
  // }
  @override
  void initState() {
    super.initState();
    getProviderData();
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
            onPressed: () =>     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){return CareTeam();})),

          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: Text(
            "My Care Teams",
            //widget.careTeamName ?? '',
            //'${widget.careTeamName}',
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
                // Map<String, dynamic>? Data = responseList?[index];
                // if (Data == null) {
                //   return SizedBox();
                // }
                Map<String, dynamic>? provider = responseList?[index];
                if (provider == null) {
                  return SizedBox();
                }
                // Extract provider information here
                var firstName = provider['firstName'];
                var lastName = provider['lastName'];
                var designation = provider['designation'];
                var contactNo = provider['contactNo'];
                //var createdAt = provider['createdAt'];
                DateTime createdAt;
                try {
                  String createdAtString = provider['createdAt'] ?? '';
                  if (createdAtString.isNotEmpty) {
                    createdAt = DateTime.parse(createdAtString);
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(createdAt);
    String time = DateFormat('kk:mm').format(createdAt);
                // Determine imagePath based on the available fields in your response?
                // For this example, let's use a default image path
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 70.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                          tileColor: Colors.white,
                          leading: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFFECEFFB),
                                radius: 24.r,
                                child: provider.containsKey('profileImagePath') &&
                                    provider['profileImagePath'] != null &&
                                    provider['profileImagePath'] is String &&
                                    provider['profileImagePath'].isNotEmpty &&
                                    Uri.tryParse(provider['profileImagePath']) != null
                                    ? CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage: NetworkImage('http://seerecs.org/user/uploads/${provider['profileImagePath']}'),
                                )
                                    : Image.asset(
                                  'assets/Group 30.png', // Default image if profile image file is not available
                                  height: 70.h,
                                  fit: BoxFit.cover, // Adjust the fit as per your requirement
                                ),
                              ),
                            ],
                          ),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    firstName,
                                    style: TextStyle(
                                        height: 2.2,
                                        color: Color(0xFF37304A),
                                        fontSize: 16.sp,
                                        fontFamily: 'Roboto-Regular',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Text(
                                    lastName,
                                    style: TextStyle(
                                        height: 2.2,
                                        color: Color(0xFF37304A),
                                        fontSize: 16.sp,
                                        fontFamily: 'Roboto-Regular',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 45,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    formattedDate,maxLines: 2,overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Color(0xFF060606),
                                      fontSize: 15.sp,
                                      fontFamily: 'Roboto-Regular',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  designation,
                                  style: TextStyle(
                                    height: 2.2,
                                    color: Color(0xFF37304A),
                                    fontSize: 18.sp,
                                    fontFamily: 'Roboto-Regular',
                                    //fontWeight: FontWeight.w600
                                  ),
                                ),
                                
                                Text(
                                  'PH: ${contactNo}',
                                  style: TextStyle(
                                    height: 2.2,
                                    color: Color(0xFF37304A),
                                    fontSize: 18.sp,
                                    fontFamily: 'Roboto-Regular',
                                    //fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  time,
                                  style: TextStyle(
                                    height: 2.2,
                                    color: Color(0xFF37304A),
                                    fontSize: 18.sp,
                                    fontFamily: 'Roboto-Regular',
                                    //fontWeight: FontWeight.w600
                                  ),
                                ),
                              ])),
                    ),
                  ),
                );
                //incrementCareTeamProviderCount(provider['careTeamId']);
                // return MembersGrid(
                //   firstName,
                //   lastName,
                //   formattedDate,
                //   designation,
                //   contactNo,
                //   imagePath,
                //   // Data['firstName'].toString(),
                //   // Data['lastName'].toString(),
                //   // formattedDate,
                //   // Data['designation'].toString(),
                //   // Data['contactNo'].toString(),
                //   // imagePath,
                // );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              CustomPageRoute(child: AddProvider(careTeamId: widget.careTeamId,careTeamName: widget.careTeamName,)),
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

// Widget MembersGrid(
//     FirstName, LastName, TimeStamp, Designation, Contact, ImageAsset) {
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
//             tileColor: Colors.white,
//             leading: Stack(
//               alignment: AlignmentDirectional.bottomStart,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Color(0xFFECEFFB),
//                   radius: 35.r,
//                   child: Image.asset(
//                     ImageAsset,
//                     height: 70.h,
//                   ),
//                 ),
//               ],
//             ),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       FirstName,
//                       style: TextStyle(
//                           height: 2.2,
//                           color: Color(0xFF37304A),
//                           fontSize: 18.sp,
//                           fontFamily: 'Roboto-Regular',
//                           fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Text(
//                       LastName,
//                       style: TextStyle(
//                           height: 2.2,
//                           color: Color(0xFF37304A),
//                           fontSize: 18.sp,
//                           fontFamily: 'Roboto-Regular',
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 80,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       TimeStamp,
//                       style: TextStyle(
//                         color: Color(0xFF060606),
//                         fontSize: 15.sp,
//                         fontFamily: 'Roboto-Regular',
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             subtitle: Row(
//                 //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     Designation,
//                     style: TextStyle(
//                       height: 2.2,
//                       color: Color(0xFF37304A),
//                       fontSize: 18.sp,
//                       fontFamily: 'Roboto-Regular',
//                       //fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   Text(
//                     Contact,
//                     style: TextStyle(
//                       height: 2.2,
//                       color: Color(0xFF37304A),
//                       fontSize: 18.sp,
//                       fontFamily: 'Roboto-Regular',
//                       //fontWeight: FontWeight.w600
//                     ),
//                   ),
//                 ])),
//       ),
//     ),
//   );
// }
