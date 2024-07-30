import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Assets/CustomPageRoute.dart';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/LinkedDevices.dart';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:Seerecs/Screens/SetPin.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:local_auth/local_auth.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

int? notification;
int? location;
int? auth;
int? pin;
int? thumbverify;
int? lock;

class _SettingsState extends State<Settings> {
  // final ThemeData darkTheme = ThemeData.dark();
  // final ThemeData lightTheme = ThemeData.light();
  // final ThemeData defaultTheme = ThemeData();
  bool isNotify = notification == 1 ? true : false;
  bool isLocation = location == 1 ? true : false;
  bool isAuth = auth == 1 ? true : false;
  bool isPin = pin == 1 ? true : false;
  bool isThumb = thumbverify == 1 ? true : false;
  bool isLock = lock == 1 ? true : false;

  int? isViewed;
  int? backButton;

  final appBarColor1 = Color(0xFFB2A0FB);
  final appBarColor2 = Color(0xFF937deb);
  final subtext = Color(0xFF5C7581); // Color
  final text1 = Color(0xFF02486A); //Color

  // final Auth1 = Color(0xFFB2A0FB); // Color
  // final Auth2 = Color.fromARGB(255, 147, 125, 235); //Color
  // final Pin1 = Color(0xFFB2A0FB); // Color
  // final Pin2 = Color.fromARGB(255, 147, 125, 235); //Color
  // final Notify1 = Color(0xFFB2A0FB); // Color
  // final Notify2 = Color.fromARGB(255, 147, 125, 235); //Color

  storeStreamlineInfo() async {
    int isStreamLine = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streamLine', isStreamLine);

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    backButton = await prefs1.getInt('backButton');
  }

  // Making Json to be send to API
  Map<String, dynamic> preferencesData() {
    return {
      ('isNotification'): (isNotify == false ? false : true),
      ('isLocation'): (isLocation == false ? false : true),
      ('isTwoFactorAuth'): (isAuth == false ? false : true),
      ('isPin'): (isPin == false ? false : true),
      ('isThumb'): (isThumb == false ? false : true),
    };
  }

  updateProfileApiCall() async {
    final api = ApiServices(Dio(), "/updateprofile");
    dynamic profileData = json.encode({});
    // verification code will be converted to json body
    Map<String, dynamic> jsonOtpData = jsonDecode(profileData);
    // Api response? will get here
    final response = await api.ApiUser(jsonOtpData, context);
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');
    //response? decoding from json to Map string
    String decode = response.toString();
    Map<String, dynamic> responseData = jsonDecode(decode);

    print(responseData['isNotification']);
    print(responseData['isLocation']);
    print(responseData['isTwoFactorAuth']);
    print(responseData['isPin']);
    print(responseData['isThumb']);
    print(responseData['isLock']);

    if (responseData['isPin'] == true) {
      int isPinState = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('isPinState', isPinState);
    }
    if (responseData['isNotification'] == true) {
      int isNotificationState = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('isNotificationState', isNotificationState);
    }
    if (responseData['isLocation'] == true) {
      int isLocationState = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('isLocationState', isLocationState);
    }
    if (responseData['isTwoFactorAuth'] == true) {
      int isTwoFactorAuthState = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('isTwoFactorAuthState', isTwoFactorAuthState);
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuth', isAuth);

    if (responseData['isThumb'] == true) {
      int isThumbState = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('isThumbState', isThumbState);
    }
    prefs.setBool('isThumb', isThumb);
    if (responseData['isLock'] == true) {
      int isLockState = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('isLockState', isLockState);
    }

    responseData['isNotification'] == true
        ? setState(() {
            notification = 1;
          })
        : setState(() {
            notification = 0;
          });
    print('Notification : ${notification}');
    responseData['isLocation'] == true
        ? setState(() {
            location = 1;
          })
        : setState(() {
            location = 0;
          });
    print('Location : ${location}');
    responseData['isTwoFactorAuth'] == true
        ? setState(() {
            auth = 1;
          })
        : setState(() {
            auth = 0;
          });
    print('Auth : ${auth}');
    responseData['isPin'] == true
        ? setState(() {
            pin = 1;
          })
        : setState(() {
            pin = 0;
          });
    print('Pin : ${pin}');
    responseData['isThumb'] == true
        ? setState(() {
            thumbverify = 1;
          })
        : setState(() {
            thumbverify = 0;
          });
    print('Thumb : ${thumbverify}');
    // response?Data['isLock'] == true
    //     ? setState(() {
    //         Lock = 1;
    //       })
    //     : setState(() {
    //         Lock = 0;
    //       });
    // print('Lock : ${Lock}');

    isNotify = notification == 1 ? true : false;
    isLocation = location == 1 ? true : false;
    isAuth = auth == 1;
    isPin = pin == 1 ? true : false;
    isThumb = thumbverify == 1 ? true : false;
    isLock = lock == 1 ? true : false;
  }

  @override
  void initState() {
    super.initState();
    //updateProfileApiCall();
  }

  // void thumb() async {
  //   bool auth = await Authentication.authentication();
  //   print("can authenticate: $auth");
  //   if (Thumb == 1) {
  //     if (auth) {
  //       // Navigator.push(context,
  //       //     MaterialPageRoute(builder: (context) => BottomNavigation()));
  //     }
  //   }
  // }

  toggleSwitchApiCall() async {
    final api = ApiServices(Dio(), "/updateprofile");
    // Will get response? of api.
    final response = await api.ApiUser(preferencesData(), context);
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');
    print('response? headers: ${response.headers}');

    // Converting api json response? to Map string.
    String decodeResponse = response.toString();
    Map<String, dynamic> res = jsonDecode(decodeResponse);

    print('Pin state : ${res['isPin']}');
    if (res['isPin'] == true) {
      int pinSwitchOn = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('pinSwitchOn', pinSwitchOn);
    }
    if (res['isPin'] == false) {
      int pinSwitchOn = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('pinSwitchOn', pinSwitchOn);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? isPinState = prefs.getInt('isPinState');

    if (response.statusCode == 200 && backButton == 1) {
      int setPinBackButton = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('setPinBackButton', setPinBackButton);
      print(res['isNotification']);
      isNotify == true
          ? checkPermission(Permission.notification, context)
          : null;
      isLocation == true ? checkPermission(Permission.location, context) : null;
      // isTwoFactorAuthState == 0 && isAuth == false
      //     ? Navigator.pushReplacement(
      //         context, CustomPageRoute(child: BottomNavigation()))
      //     : null;
      print(res['isPin']);
      isPinState == 1 ? Navigator.pop(context) : null;
      isPin == true && pin == 0
          ? Navigator.push(context, CustomPageRoute(child: SetPin()))
          : null;
    } else if (response.statusCode == 200 && backButton == 0 ||
        backButton == null) {
      int setPinBackButton = 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('setPinBackButton', setPinBackButton);
      if (isPinState == 1) {
        //navigateEnterPin(context);
        // Navigator.pushReplacement(
        //           context, CustomPageRoute(child: BottomNavigation()));
      }

      if (isPinState == 0 || isPinState == null && isPin == true) {
        Navigator.pushReplacement(context, CustomPageRoute(child: SetPin()));
      } else {
        //navigateEnterPin(context);
        Navigator.pushReplacement(
            context, CustomPageRoute(child: BottomNavigation()));
      }
    }
    print(preferencesData());
  }

  int selected = 0;

  Widget customRadio(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected == index ? Color(0xffB09DF7) : Color(0xffECF0FD),
          // border: Border.all(
          //   color: Colors.blue,
          //   width: 1,
          // ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected == index ? Colors.white : Color(0xff02486A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPopHome() async {
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
    
    //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
    return WillPopScope(
      onWillPop: () async {
        final showPop = await _onWillPopHome();
        return showPop;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFECEFFC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFECF0FD),
          //backgroundColor: ThemeColors.getAppBarColor1(context),
          //automaticallyImplyLeading: false,
          leading: BackButton(
            //color: Color(0xFF02486A),
            onPressed: () => Navigator.pop(context),
            // Navigator.push(
            // context,
            // CustomPageRoute(child: Care
            //   ())),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xFFB2A0FB),
            ),
          ),
          title: Text(
            'Update Preference',
            //style: Theme.of(context).textTheme.headline4
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF334888)),
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
        // Safe area will keep screen under notification panel
        body: SafeArea(
          // Container used to take whole screen size with media query.
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: Colors.white,
            // All widgets will bw in list view.
            child: ListView(
              children: [
                // Padding provided to all widgets
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0.w, 10.0.h, 10.0.w, 10.0.h),
                  // Row used to align all widgets in horizontal format
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        'Color Theme',
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff374572)
                            // Theme.of(context).textTheme.headline5
                            ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        // height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                customRadio("Light", 0),
                                customRadio("Dark", 1),
                                customRadio("System", 2),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Security',
                        //style: Theme.of(context).textTheme.headline5
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff374572)),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        //height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Location',
                              // style: text,
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: text1),
                            ),
                            subtitle: Text(
                              'Allow GPS to track you',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: subtext),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: appBarColor1,
                              // color of the round icon, which moves from right to left
                              thumbColor: isLocation == true
                                  ? appBarColor2
                                  : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isLocation,
                              // changes the state of the switch
                              onChanged: (value) async {
                                // setState(() => isLocation = value);
                                // // isLocation == true
                                // //     ? checkPermission(
                                // //         Permission.location, context)
                                // //     : false;
                                // if (isLocation) {
                                //   // If the switch is turned on, check location permission
                                //   bool hasPermission = await checkPermission(
                                //       Permission.location, context);

                                //   if (!hasPermission) {
                                //     // If permission is denied, toggle off the switch
                                //     setState(() => isLocation = false);
                                //   }
                                // }
                                try {
                                  print('Current isLocation: $isLocation');
                                  setState(() {
                                    isLocation = value;
                                  });
                                  if (isLocation) {
                                    bool hasPermission = await checkPermission(
                                        Permission.location, context);

                                    print(
                                        'Location Permission Status: $hasPermission');

                                    if (!hasPermission) {
                                      // If permission is denied, toggle off the switch
                                      setState(() => isLocation = false);
                                      print(
                                          'Permission denied. Setting isLocation to false.');
                                    }
                                  }

                                  print('Updated isLocation: $isLocation');
                                } catch (e) {
                                  print('Error: $e');
                                }
                                // _changeStateLocation(value);
                                // _storeLocationState();
                                // ToggleSwitchApiCall();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      // Container(
                      //   //height: 70.h,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(15.r),
                      //     // color: Color.fromRGBO(24, 125, 203, 100),
                      //   ),
                      //   child: Center(
                      //     child: ListTile(
                      //       title: Text(
                      //         '2MFA',
                      //         style: TextStyle(
                      //             fontFamily: 'Roboto-Regular',
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.w500,
                      //             color: text),
                      //       ),
                      //       subtitle: Text(
                      //         'Protect your account',
                      //         style: TextStyle(
                      //             fontFamily: 'Roboto-Regular',
                      //             fontSize: 15.sp,
                      //             color: subtext),
                      //       ),
                      //       trailing: CupertinoSwitch(
                      //         // overrides the default green color of the track
                      //         activeColor: AppBarColor1,
                      //         // color of the round icon, which moves from right to left
                      //         thumbColor: isAuth == true
                      //             ? AppBarColor2
                      //             : Colors.grey[700],
                      //         // when the switch is off
                      //         trackColor: Colors.grey,
                      //         // boolean variable value
                      //         value: isAuth,
                      //         // changes the state of the switch
                      //         onChanged: (value) async {
                      //           setState(() => isAuth = value);
                      //           //isAuth == true ? EnterPin() : null;
                      //           // _changeStateAuth(value);
                      //           // _storeAuthState();
                      //           // ToggleSwitchApiCall();
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 5.h),
                      Container(
                        //height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Pin',
                              //style: text,
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: text1),
                            ),
                            subtitle: Text(
                              'Tighten your security',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: subtext),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: appBarColor1,
                              // color of the round icon, which moves from right to left
                              thumbColor: isPin == true
                                  ? appBarColor2
                                  : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isPin,
                              // changes the state of the switch
                              onChanged: (value) async {
                                setState(() => isPin = value);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        //height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Thumb Verification',
                              //style: text,
                              style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: text1,
                              ),
                            ),
                            subtitle: Text(
                              'Device Fingerprint Supportive',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: subtext),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: appBarColor1,
                              // color of the round icon, which moves from right to left
                              thumbColor: isThumb == true
                                  ? appBarColor2
                                  : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isThumb,
                              // changes the state of the switch
                              onChanged: (value) async {
                                setState(() => isThumb = value);
                                //isThumb == true ? thumb() : null;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        //height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Use Device Lock',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: text1),
                            ),
                            subtitle: Text(
                              'Use same lock as your device',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: subtext),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: appBarColor1,
                              // color of the round icon, which moves from right to left
                              thumbColor: isLock == true
                                  ? appBarColor2
                                  : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isLock,
                              // changes the state of the switch
                              //onChanged: toggleDeviceLock,
                              onChanged: (value) async {
                                setState(() => isLock = value);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Notification',
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff374572)),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        //height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'TBD',
                              // style: TextStyle(
                              //     fontFamily: 'Roboto-Regular',
                              //     fontSize: 16.sp,
                              //     fontWeight: FontWeight.w500,
                              //     color: text),
                            ),
                            // subtitle: Text(
                            //   'Show notification at the top of the list',
                            //   style: TextStyle(
                            //       fontFamily: 'Roboto-Regular',
                            //       fontSize: 15.sp,
                            //       color: subtext),
                            // ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: appBarColor1,
                              // color of the round icon, which moves from right to left
                              thumbColor: isNotify == true
                                  ? appBarColor2
                                  : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isNotify,
                              // changes the state of the switch
                              onChanged: (value) async {
                                setState(() => isNotify = value);
                                //   SharedPreferences prefs =
                                //       await SharedPreferences.getInstance();
                                //   int? isNotificationState =
                                //       prefs.getInt('isNotificationState');
                                //   if (isNotify) {
                                //     // If the switch is turned on, check notification permission
                                //     bool hasPermission = await checkPermission(
                                //         Permission.notification, context);
                                //
                                //     if (!hasPermission) {
                                //       // If permission is denied, show a message to the user
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //             content: Text(
                                //                 "Notification permission denied")),
                                //       );
                                //
                                //       // Set the switch back to the previous state (off)
                                //       setState(() => isNotify = false);
                                //     }
                                //   }
                                //   // isNotify == true
                                //   //     ? checkPermission(
                                //   //         Permission.notification, context)
                                //   //     : null;
                                try {
                                  print('Current isNotify: $isNotify');
                                  setState(() {
                                    isNotify = value;
                                  });
                                  if (isNotify) {
                                    bool hasPermission = await checkPermission(
                                        Permission.notification, context);

                                    print(
                                        'Notify Permission Status: $hasPermission');

                                    if (!hasPermission) {
                                      // If permission is denied, toggle off the switch
                                      setState(() => isNotify = false);
                                      print(
                                          'Permission denied. Setting isNotify to false.');
                                    }
                                  }

                                  print('Updated isNotify: $isNotify');
                                } catch (e) {
                                  print('Error: $e');
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Connected Devices',
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff374572)),
                      ),
                      SizedBox(height: 5.h),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            CustomPageRoute(child: LinkedDevices()),
                          );
                        },
                        child: Container(
                          //height: 70.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            // color: Color.fromRGBO(24, 125, 203, 100),
                          ),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                'Linked Devices',
                                // style: TextStyle(
                                //     fontFamily: 'Roboto-Regular',
                                //     fontSize: 16.sp,
                                //     fontWeight: FontWeight.w500,
                                //     color: text),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '(0)', // Replace 5 with the actual number
                                    // style: TextStyle(
                                    //   fontFamily: 'Roboto-Regular',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w500,
                                    //   color: text,
                                    // ),
                                  ),
                                ],
                              ),
                              // subtitle: Text(
                              //   'Show notification at the top of the list',
                              //   style: TextStyle(
                              //       fontFamily: 'Roboto-Regular',
                              //       fontSize: 15.sp,
                              //       color: subtext),
                              // ),
                              // trailing: CupertinoSwitch(
                              //   // overrides the default green color of the track
                              //   activeColor: AppBarColor1,
                              //   // color of the round icon, which moves from right to left
                              //   thumbColor: isNotify == true
                              //       ? AppBarColor2
                              //       : Colors.grey[700],
                              //   // when the switch is off
                              //   trackColor: Colors.grey,
                              //   // boolean variable value
                              //   value: isNotify,
                              //   // changes the state of the switch
                              //   onChanged: (value) async {
                              //     setState(() => isNotify = value);

                              //   },
                              // ),
                            ),
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTapDown: (_) {
                      //     setState(() {
                      //       _isButtonPressed = true;
                      //     });
                      //   },
                      //   onTapUp: (_) {
                      //     setState(() {
                      //       _isButtonPressed = false;
                      //     });
                      //   },
                      //   onTap: () async {
                      //     await StoreStreamlineInfo();

                      //     int StreamLine = 0;
                      //     SharedPreferences preferences =
                      //         await SharedPreferences.getInstance();
                      //     await preferences.setInt('StreamLine', StreamLine);
                      //     print("streamline: $StreamLine");
                      //     if (StreamLine == 0) {
                      //       setState(() {
                      //         isViewed == 1;
                      //       });
                      //     }
                      //     ToggleSwitchApiCall();
                      //   },
                      //   child: AnimatedContainer(
                      //     duration: Duration(milliseconds: 200),
                      //     height: 45.h,
                      //     //width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       color: _isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                      //       border: Border.all(color: Colors.white, width: 3),
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     child: Center(
                      //       // Text widget used to display any text on screen
                      //       child: Text(
                      //         "Update Preferences",
                      //         style: TextStyle(
                      //           //height: 2.5.h,
                      //           fontFamily: 'Roboto-Regular',
                      //           fontSize: 20.sp,
                      //           fontWeight: FontWeight.bold,
                      //           color: _isButtonPressed ? Color(0xFFB2A0FB) : Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeTheme(int index) {
    switch (index) {
      case 0:
        _setLightTheme();
        break;
      case 1:
        _setDarkTheme();
        break;
      case 2:
        _setSystemTheme();
        break;
      default:
        break;
    }
  }

  void _setLightTheme() {
    MaterialApp app = MaterialApp(
      theme: ThemeData.light(),
    );
    runApp(app);
  }

  void _setDarkTheme() {
    MaterialApp app = MaterialApp(
      theme: ThemeData.dark(),
    );
    runApp(app);
  }

  void _setSystemTheme() {
    MaterialApp app = MaterialApp(
      themeMode: ThemeMode.system,
    );
    runApp(app);
  }

  //linkedDevices() {}
}

// Future<void> checkPermission(
//     Permission permission, BuildContext context) async {
//   PermissionStatus status = await Permission.notification.status;
//   final status1 = await permission.request();
//   if (!status.isGranted) {
//     status = await Permission.notification.request();
//   }
//   if (status1.isGranted) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("Permission is Granted")));
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Permission is not Granted")));
//   }
// }
Future<bool> checkPermission(
    Permission permission, BuildContext context) async {
  PermissionStatus status = await permission.status;
  final notifyStatus = await permission.request();

  if (!status.isGranted) {
    status = await permission.request();
  }
  bool isPermissionGranted = notifyStatus.isGranted || status.isGranted;

  if (isPermissionGranted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Permission is Granted")));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission is not Granted")));
  }

  return isPermissionGranted;
}

class Authentication {
  static final _auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async {
    return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
  }

  static Future<bool> authentication() async {
    try {
      if (!await canAuthenticate()) return false;

      return await _auth.authenticate(
          localizedReason: 'get into the app',
          options: const AuthenticationOptions(
              //biometricOnly: true,
              ));
    } catch (e) {
      print('error $e');
      return false;
    }
  }
}
// class ThemeColors {
//   static Color getAppBarColor1(BuildContext context) {
//     final brightness = Theme.of(context).brightness;
//     return brightness == Brightness.light ? Colors.blue : Colors.black;
//   }

//   static Color getAppBarColor2(BuildContext context) {
//     final brightness = Theme.of(context).brightness;
//     return brightness == Brightness.light ? Colors.green : Colors.white;
//   }

//   static Color getSubtextColor(BuildContext context) {
//     final brightness = Theme.of(context).brightness;
//     return brightness == Brightness.light ? Colors.grey : Colors.white;
//   }

//   static Color getTextColor(BuildContext context) {
//     final brightness = Theme.of(context).brightness;
//     return brightness == Brightness.light ? Colors.black : Colors.white;
//   }
// }
