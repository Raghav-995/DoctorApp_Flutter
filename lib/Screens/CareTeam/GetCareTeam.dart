import 'dart:convert';
import 'dart:core';
import 'package:Seerecs/Assets/CareTeamModel.dart';
import 'package:Seerecs/Screens/CareTeam/AddCare.dart';
import 'package:Seerecs/Screens/CareTeam/GetProvider.dart';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:Seerecs/Screens/CareTeam/UpdateCareTeam.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Assets/CustomPageRoute.dart';


class GetCareteam extends StatefulWidget {
  GetCareteam({
    Key? key,
    this.careTeamName,
    this.careTeamId, this.profileImagePath,
  }) : super(key: key);
  final String? careTeamName;
  final String? careTeamId;
  final String? profileImagePath;
  @override
  State<GetCareteam> createState() => _getCareteamState();
}

//String? userMail;
//late List response?List;
List? responseList;

Map<String, dynamic> careTeamData() {
  return {
    ('careTeamName'): (careTeamName.toString()),
  };
}

DateFormat format = DateFormat('MM/dd/yyyy HH:mm:ss');
String? selectedTeamId;

class _getCareteamState extends State<GetCareteam> {
  GetCareTeamApi(context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? obtainedToken = sharedPreferences.getString('token');

    if (obtainedToken == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    final Dio dio = Dio();
    dynamic careTeamData = json.encode({"careTeamName": "${careTeamName}"});
    // final innerJsonString = json.encode(data);
    // final jsonData = json.encode({'data': innerJsonString});

    final response = await dio.request(
      'https://seerecs.org/user/getCareTeams',
      options: Options(
        method: 'POST',
        headers: {'Authorization': 'Bearer $obtainedToken'},
      ),
      data: careTeamData,
    );

    // final api = ApiServices(Dio(), "/getCareTeams");
    // final response = await api.ApiUser(careTeamData(), context);
    print('Response body: ${response.data}');
    print('Status code : ${response.statusCode}');
    // Your existing code for API call

    // if (response.statusCode == 200) {
    // setState(() {
    // var responseData = response.data;
    // if (responseData != null && responseData['careTeams'] is List) {
    // List<dynamic> careTeams = responseData['careTeams'];
    // responseList = careTeams.cast<Map<String, dynamic>>();
    //
    // // Find the desired team using its _id
    // Map<String, dynamic>? selectedTeam;
    // for (var team in responseList!) {
    // if (team['_id'] == selectedTeamId) {
    // selectedTeam = team;
    // break;
    // }
    // }
    //
    // if (selectedTeam != null) {
    // // Perform navigation here using the selected team's data
    // // For example, you can push a new page passing the selected team's data
    // // Navigator.push(
    // // context,
    // // MaterialPageRoute(
    // // builder: (context) => getProvider(),
    // // ),
    // // );
    // } else {
    // print("Error: Team with _id $selectedTeamId not found.");
    // }
    // } else {
    // print("Error: 'careTeams' field is not a List in the response? data");
    // }
    //
    // // Sort responseList if needed
    // // Your existing sorting logic
    // });
    // }

    if (response.statusCode == 200) {
      setState(() {
        // Access the "careTeams" array directly from response?.data
        var responseData = response.data;
        if (responseData != null && responseData['careTeams'] is List) {
          List<dynamic> careTeams = responseData['careTeams'];
          responseList = careTeams.cast<Map<String, dynamic>>();
        } else {
          print("Error: 'careTeams' field is not a List in the response? data");
        }

        // Sort response?List if needed
        if (responseList != null) {
          try {
            responseList!.sort((a, b) {
              // Ensure a and b are not null before accessing properties
              if (a != null && b != null) {
                // Parse createdAt strings and handle format exceptions
                try {
                  DateTime dateTimeA = DateTime.parse(a['createdAt'] ?? '');
                  DateTime dateTimeB = DateTime.parse(b['createdAt'] ?? '');
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
  // void navigateToUpdateTeam(BuildContext context, String careTeamId, String careTeamName) {
  //   Navigator.push(context, CustomPageRoute(child: UpdateCareTeam(careTeamName: careTeamName, careTeamId: careTeamId)));
  // }

  // void navigateToUpdateTeam(BuildContext context) {
  //   // Navigator.push(
  //   //     context,
  //   //     CustomPageRoute(
  //   //         child: BottomNavigation(
  //   //      // careTeamName: careTeamName,
  //   //     )));
  //   print(widget.careTeamName);
  //   Navigator.push(context, CustomPageRoute(child: UpdateCareTeam(careTeamName: widget.careTeamName ?? '',careTeamId: widget.careTeamId ?? '',)));
  // }

  @override
  void initState() {
    super.initState();
    GetCareTeamApi(context);
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
            onPressed: () => Navigator.push(
                context, CustomPageRoute(child: BottomNavigation())),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: Text(
            'Care Teams',
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
            child: Stack(
              children: [
              Padding(
                        padding: EdgeInsets.fromLTRB(10.0.w, 10.0.h, 10.0.w, 0.0.h),
                        child: ListView.builder(
              itemCount: responseList == null ? 0 : responseList!.length,
              itemBuilder: (BuildContext context, int index) {
                // Extracting data from the response?List[index]
                Map<String, dynamic>? memberData = responseList?[index];
                String careTeamId = memberData?['_id'];
                String careTeamName = memberData?['careTeamName'];
                List<dynamic>? providers = memberData?['providers'];
                int providerCount = providers?.length ?? 0;
                // Text('Number of Providers: $providerCount');
                if (memberData == null) {
                  // Handle case where memberData is null
                  return SizedBox(); // or any other widget as needed
                }
                DateTime createdAt;
                try {
                  String createdAtString = memberData['createdAt'] ?? '';
                  if (createdAtString.isNotEmpty) {
                    createdAt = DateTime.parse(createdAtString);
                  } else {
                    createdAt =
                        DateTime.now(); // Default value (current date and time)
                  }
                } catch (e) {
                  print("Error parsing createdAt string: $e");
                  // Handle the error (e.g., provide default value)
                  createdAt =
                      DateTime.now(); // Default value (current date and time)
                }
                print('Number of providers care: $providerCount');
                String formattedDate = formatTimestamp(createdAt);
              
                
                // Text('Number of Providers: $providerCount');
                // print('Number of Providers: $providerCount');
                return GestureDetector(
                    onTap: () {
                      // Navigate to getProvider screen with careTeamId
                      navigateToCareTeam(careTeamId, careTeamName);
                    },
                    // child: MembersGrid(
                    //   memberData['careTeamName'].toString(),
                    //   providerCount,
                    //   formattedDate,
                    //   imagePath,
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: ListTile(
                              tileColor: Colors.white,
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          child: UpdateCareTeam(
                                        careTeamName: memberData['careTeamName'] ?? '',
                                        careTeamId: memberData['_id'] ?? '',
                                      )));
                                  //navigateToUpdateTeam(context, careTeamId, careTeamName);
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Color(0xFFECEFFB),
                                      radius: 35.r,
                                      child:
                                      memberData.containsKey('profileImagePath') &&
                                          memberData['profileImagePath'] != null &&
                                          memberData['profileImagePath'] is String &&
                                          memberData['profileImagePath'].isNotEmpty &&
                                          Uri.tryParse(memberData['profileImagePath']) != null
                                          ? CircleAvatar(
                                        radius: 35.r,
                                        backgroundImage: NetworkImage('http://seerecs.org/user/uploads/${memberData['profileImagePath']}'),
                                      )
                                          : Image.asset(
                                        'assets/Group 30.png', // Default image if profile image file is not available
                                        height: 70.h,
                                        fit: BoxFit.cover, // Adjust the fit as per your requirement
                                      ),
                                      // Image.asset(
                                      //   imagePath,
                                      //   height: 70.h,
                                      // ),
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      right: 5.0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 12.r,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.black,
                                          size: 17.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        memberData['careTeamName'].toString(),
                                        style: TextStyle(
                                          height: 2.2,
                                          color: Color(0xFF37304A),
                                          fontSize: 18.sp,
                                          fontFamily: 'Roboto-Regular',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '($providerCount)', // Display count in the format "(4)"
                                        style: TextStyle(
                                          height: 2.2,
                                          color: Color(0xFF5C7581),
                                          fontSize: 10,
                                          fontFamily: 'Roboto-Regular',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        formattedDate,
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
                            ),
                          ),
                        ),
                      ),
                    ));
              },
                        ),

                      ),
                Positioned( // Position the FAB
                  bottom: 0.0,
                  right: 20.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        CustomPageRoute(child: AddCare()),
                      );
                    },
                    backgroundColor: Color(0xFFB2A0FB),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                  ),
                ),

        ]
            )
    ),

      ),
    );
  }

  void navigateToCareTeam(String careTeamId, String careTeamName) {
    // Implement navigation logic to go to the particular care team screen
    // For example:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            getProvider(careTeamId: careTeamId, careTeamName: careTeamName),
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

  // Widget MembersGrid(String firstName,int count, String timeStamp, String imageAsset) {
  //   return Padding(
  //     padding: const EdgeInsets.all(6.0),
  //     child: GestureDetector(
  //       // late
  //       child: Container(
  //         height: 70.h,
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8.r),
  //           color: Colors.white,
  //         ),
  //         child: Card(
  //           elevation: 0,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(8.0),
  //           ),
  //           child: ListTile(
  //             tileColor: Colors.white,
  //             leading: GestureDetector(
  //               onTap: () {
  //                 print("image clicked");
  //                 Navigator.pushReplacement(
  //                   context,
  //                   CustomPageRoute(child: UpdateCareTeam(careTeamId: widget.careTeamId,careTeamName: widget.careTeamName,)),
  //                 );
  //                 //navigateToUpdateCareTeamPage();
  //               },
  //               child: Stack(
  //                 alignment: AlignmentDirectional.bottomStart,
  //                 children: [
  //                   CircleAvatar(
  //                     backgroundColor: Color(0xFFECEFFB),
  //                     radius: 35.r,
  //                     child: Image.asset(
  //                       imageAsset,
  //                       height: 70.h,
  //                     ),
  //                   ),
  //                           Positioned(
  //               bottom: 0.0,
  //               right: 5.0,
  //               child: CircleAvatar(
  //                 backgroundColor: Colors.white,
  //                 radius: 12.r,
  //                 child: Icon(
  //                   Icons.camera_alt_outlined,
  //                   color: Colors.black,
  //                   size: 17.0,
  //                 ),
  //               ),)
  //                 ],
  //               ),
  //             ),
  //             title: Row(
  //               children: [
  //                 Text(
  //                   firstName,
  //                   style: TextStyle(
  //                     height: 2.2,
  //                     color: Color(0xFF37304A),
  //                     fontSize: 18.sp,
  //                     fontFamily: 'Roboto-Regular',
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 Text(
  //                   '($count)', // Display count in the format "(4)"
  //                   style: TextStyle(
  //                     height: 2.2,
  //                     color: Color(0xFF37304A),
  //                     fontSize: 18.sp,
  //                     fontFamily: 'Roboto-Regular',
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //
  //               ],
  //             ),
  //             subtitle: Text(
  //               timeStamp,
  //               style: TextStyle(
  //                 color: Color(0xFF060606),
  //                 fontSize: 15.sp,
  //                 fontFamily: 'Roboto-Regular',
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget MembersGrid(
      String careTeam, int count, String timeStamp, String imageAsset) {
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
          child: Center(
            child: ListTile(
              tileColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  print("image clicked");
                  Navigator.pushReplacement(
                    context,
                    CustomPageRoute(
                        child: UpdateCareTeam(
                      careTeamId: widget.careTeamId ?? '',
                      careTeamName: widget.careTeamName ?? '',
                    )),
                  );
                  // navigateToUpdateTeam(context,widget.careTeamId ?? '',widget.careTeamName ?? '');
                  //navigateToUpdateCareTeamPage();
                },
                child: Stack(
                  //alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 71, 95, 190),
                      radius: 35.r,
                      child: Image.asset(
                        imageAsset,
                        height: 70.h,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 5.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 12.r,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 17.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        careTeam,
                        style: TextStyle(
                          height: 2.2,
                          color: Color(0xFF37304A),
                          fontSize: 18.sp,
                          fontFamily: 'Roboto-Regular',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '($count)', // Display count in the format "(4)"
                        style: TextStyle(
                          height: 2.2,
                          color: Color(0xFF5C7581),
                          fontSize: 10,
                          fontFamily: 'Roboto-Regular',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(width: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                ],
              ),
              // subtitle: Row(
              //   // mainAxisAlignment: MainAxisAlignment.end,
              //   // crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       timeStamp,
              //       style: TextStyle(
              //         color: Color(0xFF060606),
              //         fontSize: 15.sp,
              //         fontFamily: 'Roboto-Regular',
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
