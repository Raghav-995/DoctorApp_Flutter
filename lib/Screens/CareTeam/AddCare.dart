import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Assets/CustomPageRoute.dart';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:Seerecs/Screens/CareTeam/AddProvider.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/Assets/CareTeamModel.dart' as care;

class AddCare extends StatefulWidget {
  const AddCare({super.key, this.careTeamName});
  final String? careTeamName;
  @override
  State<AddCare> createState() => _AddCareState();
}

class _AddCareState extends State<AddCare> {
  CareTeamApicall(final careTeamName) async {
    final api = ApiServices(Dio(), "/addCareTeam");
    //dynamic Data = json.encode({"careTeamName": careTeamName});
    dynamic careTeamData = json.encode({"careTeamName": "${careTeamName}"});
    // verification code will be converted to json body
    Map<String, dynamic> jsonData = jsonDecode(careTeamData);
    // Api response? will get here
    final response = await api.ApiUser(jsonData, context);
    //Print response? here
    print('response status: ${response.statusCode}');
    print('response body: ${response}');
    print('response headers: ${response.headers[HttpHeaders.authorizationHeader]}');
    // New token will be saved here
    // String decodeResponse = response.toString();
    // Map<String, dynamic> res = jsonDecode(decodeResponse);
    // res['token'] = '${response.headers[HttpHeaders.authorizationHeader]}';
    // late var token = res['token'];
    // token = token.substring(1, token.length - 1);
    // print(token);
    // // Shared preferences used here so we can store token which will get from api.
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString('token', token);

    //response? decoding from json to Map string
  //   String? decode = response.toString();
  //   Map<String, dynamic> responseData = jsonDecode(decode);
  //   print(responseData['message']);
  //   // If api response? is true for success then will show dialog box
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     CustomSnackBar(context, 'Care team created successfully');
  //     //Navigator.pop(context);
  //     Navigator.push(context, CustomPageRoute(child: getCareteam()));
  //   } else {}
  //   // Printing json data which is provided to api
  //   print("Enter careteam request send to api with user info: ");
  //   //print(Data);
  // }
    //final Map<String, dynamic> responseData = jsonDecode(response.body);

    String decode = response.toString();
    Map<String, dynamic> res = jsonDecode(decode);
    final String? careTeamId = res['careTeam']['_id'];
    //String careTeamId = res['_id'];
    print(res['success']);
    //var check = res['success'];
    // If api response is true for success then will show dialog box
    if (response.statusCode == 200 || response.statusCode == 201) {
      return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors
                .transparent, // Set transparent background color for the dialog
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, // Set desired background color here
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFFB1A0FB), width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "Your Care Team Has Been Created",
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff02486A),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Add Your Provider",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 16.sp,
                            color: Color(0xff02486A),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                                              Navigator.pushReplacement(
                                                  context, CustomPageRoute(child: AddProvider(careTeamName: careTeamName,careTeamId: careTeamId,)));
                            // Navigator.of(context)
                            //     .popUntil((route) => route.isFirst);
                          },
                          child: Container(
                            height: 40.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFB1A0FB),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Set shadow color here
                                  spreadRadius: 2, // Set spread radius here
                                  blurRadius: 4, // Set blur radius here
                                  offset: Offset(0, 2), // Set offset here
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Add Provider",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Image.asset(
                    "assets/Group 4.png",
                    height: 50,
                    width: 50,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/Group 5.png",
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          );
        },
      );
      // showDialog(
      //   useSafeArea: true,
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       backgroundColor: Color(0xFFB2A0FB),
      //       shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
      //       content: Container(
      //         height: 150.h,
      //         // width: 350.w,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.rectangle,
      //           color: const Color(0xFFFFFF),
      //           borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
      //         ),
      //         child: Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               // Image assets used for to get image from assets folder.
      //               // Image.asset(
      //               //   "assets/VerificationDone.png",
      //               //   height: 200.h,
      //               //   // width: 200.w,
      //               // ),
      //               SizedBox(
      //                 height: 10.h,
      //               ),
      //               Text(
      //                 "Your Care Team Has Been Created",
      //                 style: TextStyle(
      //                   fontFamily: 'Roboto-Regular',
      //                   fontSize: 25.sp,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20.h,
      //               ),
      //               Text(
      //                 textAlign: TextAlign.center,
      //                 "Add Your First Provider",
      //                 style: TextStyle(
      //                   fontFamily: 'Roboto-Regular',
      //                   fontSize: 20.sp,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 10.h,
      //               ),
      //               // InkWell widget used to make any widget clickable so we can perform task on them
      //               InkWell(
      //                 onTap: () {
      //                   // On tap will navigate to Login screen
      //                   //showAlertDialog(context);
      //                   Navigator.of(context).popUntil((route) => route.isFirst);
      //                   Navigator.pushReplacement(
      //                       context, CustomPageRoute(child: AddProvider(careTeamName: careTeamName,careTeamId: careTeamId,)));
      //                   // Navigator.pushReplacement(
      //                   //     context, CustomPageRoute(child: getProvider(careTeamName: careTeamName,careTeamId: careTeamId,)));
      //                 },
      //                 // Button is made of container
      //                 child: Container(
      //                   height: 40.h,
      //                   width: 120.w,
      //                   decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(5.r),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       "Add Provider",
      //                       style: TextStyle(
      //                           fontSize: 15.sp,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.black),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // );
    } else {}
    // Printing json data which is provided to api
    print("care team request send to api with user info: ");
    //print(toJson());
  }
  Map<String, dynamic> providerData() {
    var _firstName;
    var _lastName;
    var _mobileNo;
    var _designation;
    return {
      (care.firstName): (_firstName),
      (care.lastName): (_lastName),
      (care.contactNo): (_mobileNo),
      (care.designation): (_designation),
    };
  }

  // Future<void> fetchDataFromAPI() async {
  //   final api = ApiServices(Dio(), "/getProvider");
  //   final response = await api.ApiUser(providerData(), context);
  //
  //   print('response body: ${response.data}');
  //   print('Status code : ${response.statusCode}');
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       var responseData = response.data;
  //       // Check if the response? data is an empty list
  //       if (response.data != null && response.data.isEmpty) {
  //         // If response? body is empty list, navigate to AddFamily
  //         Navigator.pushReplacement(
  //           context,
  //           CustomPageRoute(child: Provider()),
  //         );
  //       } else if (response.data != null && responseData['providers'] is List) {
  //         List<dynamic> providers = responseData['providers'];
  //         Navigator.pushReplacement(
  //           context,
  //           CustomPageRoute(child: getProvider()),
  //         );
  //       } else {
  //         // Handle other cases where response? data is not as expected
  //         print("Error: Unexpected response? data format");
  //       }
  //     });
  //   } else {
  //     // Handle other status codes if needed
  //     print("Error: Non-200 status code received");
  //   }
  // }

  final form = GlobalKey<FormState>();
  late TextEditingController nameController = TextEditingController();
  // First name text field controller
  @override
  Widget build(BuildContext context) {
    bool isButtonPressed = false;
    return Form(
      key: form,
      child: Scaffold(
          backgroundColor: Color(0xFFECEFFC),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFECF0FD),
            //automaticallyImplyLeading: false,
            leading: BackButton(
              //color: Color(0xFF02486A),
              onPressed: () => Navigator.push(context, CustomPageRoute(child: BottomNavigation())),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //color: Color(0xFFB2A0FB),
              ),
            ),
            title: Text(
              'Add Care Team',
              style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         Icons.view_compact_alt,
            //         color: Colors.black,
            //       )),
            // ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  //overflow: Overflow.clip,
                  alignment: AlignmentDirectional.bottomCenter,
                  fit: StackFit.loose,
                  children: [
                    // Container(
                    //   height: 240.h,
                    // decoration: BoxDecoration(
                    //   color: Color(0xFFB2A0FB),
                    //     // gradient: LinearGradient(
                    //     //   colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                    //     //   begin: Alignment.topLeft,
                    //     //   end: Alignment.bottomRight,
                    //     // ),
                    //    border: Border.all(color: Colors.white,width: 4),
                    //     //borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                    //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                    // ),
                    // ),
                    // Image.asset(
                    //   "assets/caredyno.png",
                    //   //alignment: Alignment.bottomRight,
                    //   height: 200.h,
                    //   width: 300.w,
                    // ),
            
                    Positioned(
                        child: Container(
                      height: 240.h,
                      decoration: BoxDecoration(
                          color: Color(0xFFB2A0FB),
                          // gradient: LinearGradient(
                          //   colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          // ),
                          border: Border.all(color: Colors.white, width: 4),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(20, 20))
                          //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                          ),
                    )),
                    Positioned(
                      top: 20.h,
                      height: 240.h,
                      child: Image.asset(
                        "assets/8-removebg-preview 2.png",
                        //alignment: Alignment.bottomRight,
                        height: 250.h,
                        // width: 300.w,
                      ),
                    ),
                  ],
                ),
                
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Add Personalized Care Team",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF02486A)),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter Care Team Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF02486A)),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                    
                        TextFormField(
                          controller:
                              nameController, // Assuming _nameController is initialized elsewhere
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                            ),
                            hintText: 'Please enter care team name',
                          ),
                          validator: (value) {
                            // Uncomment this block for validation logic
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid name";
                            }
                            // Additional validation logic can be added here
                            return null; // Return null if input is valid
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 55),
                        //   child: Text("A care team is a group of healthcare professionals working collaboratively to "
                        //       "provide comprehensive and coordinated care to meet the diverse needs of a you.",style: TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0xFF737081)),textAlign: TextAlign.center,),
                        // ),
                        SizedBox(
                          height: 40.h,
                        ),
                        InkWell(
                          onTapDown: (_) {
                            setState(() {
                              isButtonPressed = true;
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              isButtonPressed = false;
                            });
                          },
                          onTap: () async {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return Provider(careTeamName: widget.careTeamName);
                            // }));
                            final isValid = form.currentState!.validate();
                            // If all fields validated then it will call api
                            if (isValid == true) {
                              CareTeamApicall(nameController.text);
                            }
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: 40.h,
                            width: 220.w,
                            decoration: BoxDecoration(
                              color: isButtonPressed
                                  // ignore: dead_code
                                  ? Colors.white
                                  : Color(0xFFB2A0FB),
                              //border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Create Team",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Image.asset(
                //   "assets/64-removebg-preview (1) 1.png",
                //   height: 250.h,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 20),
                //   child: Align(
                //     alignment: Alignment.bottomRight,
                //     child: FloatingActionButton(
                //       onPressed: null,
                //       backgroundColor: Color(0xFFB2A0FB),
                //       shape: CircleBorder(),
                //       child: const Icon(Icons.add, size: 40,),
                //     ),
                //   ),
                // ),
                //FloatingActionButtonLocation.centerDocked,
            
                // FloatingActionButtonLocation.endFloat,
                // floatingActionButton: FloatingActionButton(
                //   //onPressed: _incrementCounter,
                //   //tooltip: 'Increment',
                //   child: const Icon(Icons.add),
                // ),,
              ],
            ),
          )),
    );
  }
}
