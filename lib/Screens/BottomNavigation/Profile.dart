import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Assets/CustomPageRoute.dart';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/AddFamily.dart';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/MyActivity.dart';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/Settings.dart';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/Sharelog.dart';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/UpdateProfile.dart';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:Seerecs/Screens/EnterPassword.dart';
import 'package:Seerecs/Screens/EnterPin.dart';
//import 'package:Seerecs/Screens/LoginScreen.dart';
import 'package:Seerecs/Screens/VerificationChangePassword.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Assets/UserModel.dart' as user;

import '../../network/response_AlterBox.dart';
import '../BottomNavigation Screens/BottomNavigationContentScreens/FamilyMembers.dart';

//import '../../Assets/Messages.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

int? pinSwitchOn;
String? _firstName;
String? _lastName;
String? _city;
String? _email;
String? _zipcode;
String? _dob;
String? _address;
String? _phone;
String? _gender;

storeSetPinInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pinSwitchOn = prefs.getInt('pinSwitchOn');
}

setPinAuthenticationInfo() async {
  int setPinAuth = 1;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('setPinAuth', setPinAuth);
}

class _ProfileState extends State<Profile> {
  String? profileImage;

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use the correct key to retrieve firstName from SharedPreferences
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? city = prefs.getString('city');
    String? email = prefs.getString('email');
    String? zipcode = prefs.getString('zipcode');
    String? dob = prefs.getString('dob');
    String? address = prefs.getString('address');
    String? phone = prefs.getString('phone');
    String? gender = prefs.getString('gender');
    setState(() {
      _firstName = firstName;
      _lastName = lastName;
      _city = city;
      _email = email;
      _zipcode = zipcode;
      _dob = dob;
      _address = address;
      _phone = phone;
      _gender = gender;
    });
  }
  // void saveImage(String path) async {
  //   SharedPreferences saveProfileImage = await SharedPreferences.getInstance();
  //   saveProfileImage.setString("imagePath", path);
  // }
  //
  // void loadImage() async {
  //   SharedPreferences saveProfileImage = await SharedPreferences.getInstance();
  //   String? savedImagePath = saveProfileImage.getString("imagePath");
  //   if (savedImagePath != null) {
  //     setState(() {
  //       profileImage = savedImagePath;
  //     });
  //   }
  // }
  PickedFile? imageFile; // Declare imageFile as PickedFile or nullable PickedFile

  Future<void> loadImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        imageFile = PickedFile(imagePath);
      });
    }
  }

  Future<void> saveImage(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', imagePath);
  }
  Future<void> fetchDataFromAPI() async {
    final api = ApiServices(Dio(), "/getFamilyMembers");
    final response = await api.ApiUser(familyMemberData(), context);

    print('response body: ${response.data}');
    print('Status code : ${response.statusCode}');

    if (response.statusCode == 200) {
      setState(() {
        // Check if the response? data is an empty list
        if (response.data != null && response.data.isEmpty) {
          // If response? body is empty list, navigate to AddFamily
          Navigator.pushReplacement(
            context,
            CustomPageRoute(child: AddFamily()),
          );
        } else if (response.data != null && response.data is List) {
          // If response? body is a non-empty list, navigate to FamilyMembers
          Navigator.pushReplacement(
            context,
            CustomPageRoute(child: FamilyMembers()),
          );
        } else {
          // Handle other cases where response? data is not as expected
          print("Error: Unexpected response? data format");
        }
      });
    } else {
      // Handle other status codes if needed
      print("Error: Non-200 status code received");
    }
  }

  Future<void> loadProfileImage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      profileImage = _prefs.getString('imagePath') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    storeSetPinInfo();
    getUserInfo();
    loadProfileImage();
    loadImage();
  }

  String? userMail;
  // Map<String, dynamic> Json() {
  //   return {
  //     (family.email): (email.toString().toLowerCase()),
  //   };
  // }

  Map<String, dynamic> familyMemberData() {
    return {
      (user.email): (userMail.toString().toLowerCase()),
    };
  }

  //bool canBack = false;

  Future<bool> _onWillPopHome(context) async {
    bool canBack = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFB2A0FB),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
        title: new Text(
          'Are you sure?',
          style: TextStyle(color: Colors.white),
        ),
        content: new Text(
          'Do you want to exit an app',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            //onPressed: () => Navigator.of(context).pop(true),
            onPressed: () {
              exit(0); // Exit the app
            },
            child: new Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    return canBack;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () async {
          final showPop = await _onWillPopHome(context);
          return showPop;
        }, //backgroundColor: Color(0xFFF9FBFF),
        child: Scaffold(
          //backgroundColor: Colors.white,
          backgroundColor: Color(0xFFF9FBFF),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              //color: Colors.black,
              // border: Border.all(color: Colors.white, width: 7),
              // borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [Color(0xFFF9FBFF), Color(0xFFECF0FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                //physics: NeverScrollableScrollPhysics(),
                children: [
                  Stack(
                    // fit: StackFit.expand,
                    //alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 165.h),
                        width: width,
                        height: 80.0.h,
                        decoration: BoxDecoration(
                            color: Color(0xFFA994FF),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              15.0.w, 25.0.h, 15.0.w, 00.0.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Text("hgh"),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Reports",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Visits",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: width,
                        height: 180.0.h,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pushReplacement(
                                      context,
                                      CustomPageRoute(
                                          child: BottomNavigation())),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: Icon(
                                //       Icons.view_compact_alt,
                                //       color: Colors.black,
                                //     )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  radius: 55.0, // Adjust the radius as needed
                                  backgroundColor: Colors
                                      .grey, // Optional: Set a background color for the CircleAvatar
                                  backgroundImage:
                                  profileImage != null && profileImage!.isNotEmpty
                                      ? FileImage(File(profileImage!))
                                      : Image.asset(
                                          "assets/Group 30.png",
                                          height: 40.h,
                                          //width: 0.w,
                                          //fit: BoxFit.contain,
                                        ).image,
                                  // CircleAvatar(
                                  //   backgroundColor: Color(0xFFB2A0FB),
                                  //   radius: 70.r,
                                  //   backgroundImage: imagepath != null ? FileImage(File(imagepath!)) : null,
                                  //child: imagepath != null ? Image.asset(imagepath!) : Container(),
                                  // child: Image.asset(
                                  //   "assets/Vector (3).png",
                                  //   height: 40.h,
                                  //   //color: Colors.black,
                                  // 
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_firstName != null ? _firstName![0].toUpperCase() + _firstName!.substring(1) : ''} ${_lastName != null ? _lastName![0].toUpperCase() + _lastName!.substring(1) : ''}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Color(0xff374572),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                        //_city ?? '',
                                        _city != null
                                            ? _city![0].toUpperCase() +
                                                _city!.substring(1)
                                            : '',
                                        //'${userData['city']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffA9A6B3),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //verticalDirection: VerticalDirection.down,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                getUserInfo();
                                Navigator.pushReplacement(
                                    context,
                                    CustomPageRoute(
                                        child: UpdateProfile(
                                      // id: id,
                                      firstName: _firstName,
                                      lastName: _lastName,
                                      email: _email,
                                      city: _city,
                                      zipcode: _zipcode,
                                      dob: _dob,
                                      address: _address,
                                      phone: _phone,
                                      gender: _gender,
                                    )));
                              },
                              child: ProfileContents(
                                  // ProfileColor1,
                                  // ProfileColor2,
                                  'Update Profile',
                                  "assets/transaction 1.png"),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    fetchDataFromAPI();
                                  },
                                  child: ProfileContents(
                                      // AddFamilyMember1,
                                      // AddFamilyMember2,
                                      'Add Family Member',
                                      "assets/family (1) 1.png"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(context,
                                        CustomPageRoute(child: MyActivity()));
                                  },
                                  child: ProfileContents(
                                      // MyActivityColor1,
                                      // MyActivityColor2,
                                      'My Activity',
                                      "assets/daily-calendar 1.png"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            pinSwitchOn == 1
                                ? InkWell(
                                    onTap: () async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setInt('ChangePin', 0);
                                      int validatePinBackButton = 1;
                                      SharedPreferences prefs1 =
                                          await SharedPreferences.getInstance();
                                      await prefs1.setInt(
                                          'validatePinBackButton',
                                          validatePinBackButton);
                                      Navigator.push(context,
                                          CustomPageRoute(child: EnterPin()));
                                    },
                                    child: ProfileContents(
                                        // ChangePasswordColor1,
                                        // ChangePasswordColor2,
                                        'Change Password',
                                        "assets/reset-password 1.png"),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      final api =
                                          ApiServices(Dio(), "/sendOTP");
                                      dynamic otpData = json.encode(
                                          {"description": "Change Password"});
                                      // verification code will be converted to json body
                                      Map<String, dynamic> jsonOtpData =
                                          jsonDecode(otpData);
                                      // Will get response? of api.
                                      final response = await api.ApiUser(
                                          jsonOtpData, context);
                                      print(
                                          'response? status: ${response.statusCode}');
                                      print('response? body: ${response}');

                                      // Converting api json response? to string.
                                      // String decode = response?.toString();
                                      // Map<String, dynamic> response?Data =
                                      //     jsonDecode(decode);

                                      if (response.statusCode == 200) {
                                        CustomSnackBar(
                                            context, 'OTP sent to mail');
                                        Navigator.push(
                                            context,
                                            CustomPageRoute(
                                                child:
                                                    VerificationChangePassword()));
                                      }
                                    },
                                    child: ProfileContents(
                                        // ChangePasswordColor1,
                                        // ChangePasswordColor2,
                                        'Change Password',
                                        "assets/reset-password 1.png"),
                                  ),
                            SizedBox(
                              height: 20.h,
                            ),
                            pinSwitchOn == 1
                                ? Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          int SetPinAuth = 0;
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.setInt(
                                              'SetPinAuth', SetPinAuth);
                                          Navigator.push(
                                              context,
                                              CustomPageRoute(
                                                  child: EnterPassword()));
                                        },
                                        child: ProfileContents(
                                            // ChangePinColor1,
                                            // ChangePinColor2,
                                            'Change Pin',
                                            "assets/password 1.png"),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setPinAuthenticationInfo();
                                          Navigator.push(
                                              context,
                                              CustomPageRoute(
                                                  child: EnterPassword()));
                                        },
                                        child: ProfileContents(
                                            'Set Pin', "assets/password 1.png"),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        CustomPageRoute(child: Sharelog()));
                                  },
                                  child: ProfileContents(
                                      'Share Log', "assets/share.png"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                CustomSnackBar(context, 'Coming soon...');
                              },
                              child: ProfileContents(
                                  // ChangePasswordColor1,
                                  // ChangePasswordColor2,
                                  'Health Tips',
                                  "assets/Health.png"),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    CustomSnackBar(context, 'Coming soon...');
                                  },
                                  child: ProfileContents(
                                      // AppBarColor1,
                                      // AppBarColor2,
                                      'Crecs Directory',
                                      "assets/Notebook.png"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        CustomPageRoute(child: Settings()));
                                  },
                                  child: ProfileContents(
                                      'Preferences', "assets/Vector (5).png"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget ProfileContents(contentName, ImageAsset) {
    return Container(
      height: 100.h,
      width: 140.w,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        color: Colors.transparent,
        //shadowColor: Colors.grey,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFB2A0FB),
            ),
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     SecondaryColor, // Colors
            //     PrimaryColor, //Colors
            //   ],
            // ),
            borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.h),
              Image.asset(
                ImageAsset,
                height: 30.h,
                //color: Colors.white,
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(contentName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 17.sp,
                      //fontWeight: FontWeight.bold,
                      color: Color(0xFF978CB9),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
