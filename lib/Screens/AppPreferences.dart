import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Assets/CustomPageRoute.dart';
import '../network/API_Services.dart';
import 'SetPin.dart';
import 'package:local_auth/local_auth.dart';

class StreamLinePreferences extends StatefulWidget {
  StreamLinePreferences({super.key});

  @override
  State<StreamLinePreferences> createState() => _StreamLinePreferencesState();
}

bool isButtonPressed = false;
int? notification;
int? location;
int? auth;
int? pin;
int? thumbLock;
int? lock;

class _StreamLinePreferencesState extends State<StreamLinePreferences> {
  Location deviceLocation = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  String locationText = '';
  //bool isLocationEnabled = false;
  Dio dio = Dio();
  bool isNotify = notification == 1 ? true : false;
  bool isLocation = location == 1 ? true : false;
  //bool isAuth = Auth == 1 ? true : false;
  bool isAuth = auth == 1;
  bool isPin = pin == 1 ? true : false;
  bool isThumb = thumbLock == 1 ? true : false;
  bool isLock = lock == 1 ? true : false;

  int? isViewed;
  int? backButton;

  final appBarColor1 = Color(0xFFB2A0FB);
  final appBarColor2 = Color(0xFF937deb);
  final notify1 = Color(0xFFB2A0FB); // Color
  final notify2 = Color(0xFF937deb); //Color
  final location1 = Color(0xFFB2A0FB); // Color
  final location2 = Color(0xFF937deb); //Color
  final auth1 = Color(0xFFB2A0FB); // Color
  final auth2 = Color(0xFF937deb); //Color
  final pin1 = Color(0xFFB2A0FB); // Color
  final pin2 = Color(0xFF937deb); //Color
  final lock1 = Color(0xFFB2A0FB); // Color
  final lock2 = Color(0xFF937deb); //Color

  storeStreamlineInfo() async {
    int isStreamLine = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streamLine', isStreamLine);

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    backButton = await prefs1.getInt('BackButton');
  }

  // Making Json to be send to API
  Map<String, dynamic> preferencesData() {
    return {
      ('isNotification'): (isNotify == false ? false : true),
      ('isLocation'): (isLocation == false ? false : true),
      //('isTwoFactorAuth'): (isAuth == false ? false : true),
      ('isPin'): (isPin == false ? false : true),
      ('isThumb'): (isThumb == false ? false : true),
      ('isTwoFactorAuth'): (isAuth = true),
      //(user.ProfilePicture): _imagePath,
      //('ProfilePicture'): (formdata ),
    };
  }

  // Map<String, dynamic> locationData() {
  //   return {
  //     ('latitude'):
  //   }
  // }
  // updateProfileApiCall() async {
  //   final SharedPreferences sharedPreferences =
  //   await SharedPreferences.getInstance();
  //   final String? obtainedToken = sharedPreferences.getString('token');
  //
  //   if (obtainedToken == null) {
  //     //throw Exception('Token not found in SharedPreferences');
  //     final api = ApiServices(Dio(), "/updateProfile");
  //     // Will get response? of api.
  //     dynamic profileData = json.encode({});
  //     // code will be converted to json body
  //     Map<String, dynamic> jsonData = jsonDecode(profileData ?? '{}');
  //     final response = await api.ApiUser(jsonData, context);
  //     print('response status: ${response.statusCode}');
  //     print('response body: ${response}');
  //     print('response headers: ${response.headers}');
  //
  //     // Converting api json response? to Map string.
  //     String decodeResponse = response.toString();
  //     //Map<String, dynamic> responseData = jsonDecode(decodeResponse);
  //   }
  //   final Dio dio = Dio();
  //   dynamic profileData = json.encode({});
  //   // code will be converted to json body
  //   Map<String, dynamic> jsonData = jsonDecode(profileData ?? '{}');
  //   final response = await dio.request(
  //     'https://seerecs.org/user/updateprofile',
  //     options: Options(
  //       method: 'POST',
  //       headers: {'Authorization': 'Bearer $obtainedToken'},
  //     ),
  //     data: jsonData,
  //   );
  //   print('response status: ${response.statusCode}');
  //   print('response body: ${response}');
  //   //response? decoding from json to Map string
  //   String decode = response.toString();
  //   Map<String, dynamic> responseData = jsonDecode(decode);
  //
  //   print(responseData['isNotification']);
  //   print(responseData['isLocation']);
  //   print(responseData['isTwoFactorAuth']);
  //   print(responseData['isPin']);
  //   print(responseData['isThumb']);
  //
  //   if (responseData['isPin'] == true) {
  //     int isPinState = 1;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setInt('isPinState', isPinState);
  //   }
  //   if (responseData['isNotification'] == true) {
  //     int isNotificationState = 1;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setInt('isNotificationState', isNotificationState);
  //   }
  //   if (responseData['isLocation'] == true) {
  //     int isLocationState = 1;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setInt('isLocationState', isLocationState);
  //   }
  //   if (responseData['isTwoFactorAuth'] == true) {
  //     int isTwoFactorAuthState = 1;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setInt('isTwoFactorAuthState', isTwoFactorAuthState);
  //   }
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isAuth', isAuth);
  //
  //   if (responseData['isThumb'] == true) {
  //     int isThumbState = 1;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setInt('isThumbState', isThumbState);
  //   }
  //   prefs.setBool('isThumb', isThumb);
  //
  //   responseData['isNotification'] == true
  //       ? setState(() {
  //           notification = 1;
  //         })
  //       : setState(() {
  //           notification = 0;
  //         });
  //   print('Notification : ${notification}');
  //   responseData['isLocation'] == true
  //       ? setState(() {
  //           location = 1;
  //         })
  //       : setState(() {
  //           location = 0;
  //         });
  //   print('Location : ${location}');
  //   responseData['isTwoFactorAuth'] == true;
  //   setState(() {
  //     auth = 1;
  //   });
  //   print('Auth : ${auth}');
  //   responseData['isPin'] == true
  //       ? setState(() {
  //           pin = 1;
  //         })
  //       : setState(() {
  //           pin = 0;
  //         });
  //   print('Pin : ${pin}');
  //   responseData['isThumb'] == true
  //       ? setState(() {
  //           thumbLock = 1;
  //         })
  //       : setState(() {
  //           thumbLock = 0;
  //         });
  //   print('Thumb : ${thumbLock}');
  //
  //   isNotify = notification == 1 ? true : false;
  //   isLocation = location == 1 ? true : false;
  //   isAuth = auth == 1;
  //   isPin = pin == 1 ? true : false;
  //   isThumb = thumbLock == 1 ? true : false;
  // }
  Future<void> updateProfileApiCall() async {
    try {
        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        final String? obtainedToken = sharedPreferences.getString('token');

        if (obtainedToken == null) {
          //throw Exception('Token not found in SharedPreferences');
          final api = ApiServices(Dio(), "/updateProfile");
          // Will get response? of api.
          dynamic profileData = json.encode({});
          // code will be converted to json body
          Map<String, dynamic> jsonData = jsonDecode(profileData ?? '{}');
          final response = await api.ApiUser(jsonData, context);
          print('response status: ${response.statusCode}');
          print('response body: ${response}');
          print('response headers: ${response.headers}');

          // Converting api json response? to Map string.
          response.toString();
          //Map<String, dynamic> responseData = jsonDecode(decodeResponse);
        }
        final Dio dio = Dio();
        dynamic profileData = json.encode({});
        // code will be converted to json body
        Map<String, dynamic> jsonData = jsonDecode(profileData ?? '{}');
        final response = await dio.request(
          'https://seerecs.org/user/updateprofile',
          options: Options(
            method: 'POST',
            headers: {'Authorization': 'Bearer $obtainedToken'},
          ),
          data: jsonData,
        );
        print('response status: ${response.statusCode}');
        print('response body: ${response}');
        //response? decoding from json to Map string
        String decode = response.toString();
        Map<String, dynamic> responseData = jsonDecode(decode);

        print(responseData['isNotification']);
        print(responseData['isLocation']);
        print(responseData['isTwoFactorAuth']);
        print(responseData['isPin']);
        print(responseData['isThumb']);

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
        responseData['isTwoFactorAuth'] == true;
        setState(() {
          auth = 1;
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
                thumbLock = 1;
              })
            : setState(() {
                thumbLock = 0;
              });
        print('Thumb : ${thumbLock}');

        isNotify = notification == 1 ? true : false;
        isLocation = location == 1 ? true : false;
        isAuth = auth == 1;
        isPin = pin == 1 ? true : false;
        isThumb = thumbLock == 1 ? true : false;

      // }
      // else {
      //   // Handle API error here
      //   print('Failed to update profile');
      // }
    } catch (error) {
      // Handle errors
      print('Error occurred: $error');
      // You can show an error message to the user if needed
      // For example:
      // CustomSnackBar(context, 'An error occurred: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    updateProfileApiCall();
    deviceLocation.serviceEnabled().then((value) {
      if (!value) {
        deviceLocation.requestService();
      }
    });
  }

  Future<void> _toggleLocationService(bool isEnabled) async {
    if (isEnabled) {
      _locationSubscription = Stream.periodic(Duration(hours: 1))
          .asyncMap((_) => _getLocation())
          .listen((LocationData locationData) {
        setState(() {
          locationText =
              'Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}, Altitude: ${locationData.altitude}';
          _sendLocationData(locationData);
        });
      });
    } else {
      _locationSubscription?.cancel();
    }
  }

  Future<LocationData> _getLocation() async {
    try {
      return await deviceLocation.getLocation();
    } catch (error) {
      print('Error getting location: $error');
      throw error;
    }
  }

  Future<void> _sendLocationData(LocationData locationData) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? obtainedToken = sharedPreferences.getString('token');

      if (obtainedToken == null) {
        throw Exception('Token not found in SharedPreferences');
      }
      // Make POST request to addlocation API endpoint
      final response = await dio.request('https://seerecs.org/user/addDeviceLocation',
          options: Options(
            method: 'POST',
            headers: {'Authorization': 'Bearer $obtainedToken'},
          ),
          data: {
            'latitude': locationData.latitude,
            'longitude': locationData.longitude,
            'elevation': locationData.altitude,
          });
      print(response.data);
      print('Location data sent successfully');
    } catch (error) {
      print('Error sending location data: $error');
    }
  }

  void thumb() async {
    bool auth = await Authentication.authentication();
    print("can authenticate: $auth");
    if (Thumb == 1) {
      if (auth) {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    }
  }

  toggleSwitchApiCall() async {
    final api = ApiServices(Dio(), "/updateProfile");
    // Will get response? of api.
    final response = await api.ApiUser(preferencesData(), context);
    print('response status: ${response.statusCode}');
    print('response body: ${response}');
    print('response headers: ${response.headers}');

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
    prefs.getInt('isTwoFactorAuthState');

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
      // isPinState == 1
      //     ? Navigator.pushReplacement(
      //         context, CustomPageRoute(child: BottomNavigation()))
      //     : null;
      // // isTwoFactorAuthState == 1 && isAuth == true
      //     ? Navigator.pushReplacement(
      //     context, CustomPageRoute(child: EnterPin()))
      //     : null;
      //isPinState == 0 || isPinState == null && isPin == true
      //  ? Navigator.pushReplacement(context, CustomPageRoute(child: SetPin()))
      //: "BottomNavigation";
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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final showPop = await _onWillPopHome();
        return showPop;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          //leading: backButton == 1 ? BackButton(color: Colors.white) : null,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  appBarColor1,
                  appBarColor2,
                ],
              ),
            ),
          ),
          title: Text(
            'App Preferences',
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        // Safe area will keep screen under notification panel
        body: SafeArea(
          // Container used to take whole screen size with media query.
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            // All widgets will bw in list view.
            child: ListView(
              children: [
                // Padding provided to all widgets
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0.w, 5.0.h, 30.0.w, 10.0.h),
                  // Row used to align all widgets in horizontal format
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        'Customize your comfort',
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 25.sp,
                            // fontWeight: FontWeight.bold,
                            color: appBarColor2),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Notification',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: notify2),
                            ),
                            subtitle: Text(
                              'Show notification at the top of the list',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 14.sp,
                                  // fontWeight: FontWeight.bold,
                                  color: notify1),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: notify1,
                              // color of the round icon, which moves from right to left
                              thumbColor:
                                  isNotify == true ? notify2 : Colors.grey[700],
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
                      SizedBox(height: 20.h),
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Location',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 27.sp,
                                  fontWeight: FontWeight.bold,
                                  color: location2),
                            ),
                            subtitle: Text(
                              'Allow GPS to track you',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 17.sp,
                                  // fontWeight: FontWeight.bold,
                                  color: location1),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: location1,
                              // color of the round icon, which moves from right to left
                              thumbColor: isLocation == true
                                  ? location2
                                  : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isLocation,
                              // changes the state of the switch
                              onChanged: (value) {
                                setState(() {
                                  isLocation = value;
                                  if (value) {
                                    startLocationUpdates();
                                  } else {
                                    stopLocationUpdates();
                                  }
                                });
                               // _toggleLocationService(value);
                              },
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
                              // try {
                              //   print('Current isLocation: $isLocation');
                              //   setState(() {
                              //     isLocation = value;
                              //   });
                              //   if (isLocation) {
                              //     bool hasPermission = await checkPermission(
                              //         Permission.location, context);
                              //
                              //     print(
                              //         'Location Permission Status: $hasPermission');
                              //
                              //     if (!hasPermission) {
                              //       // If permission is denied, toggle off the switch
                              //       setState(() => isLocation = false);
                              //       print(
                              //           'Permission denied. Setting isLocation to false.');
                              //     }
                              //   }
                              //
                              //   print('Updated isLocation: $isLocation');
                              // } catch (e) {
                              //   print('Error: $e');
                              // }
                              // _changeStateLocation(value);
                              // _storeLocationState();
                              // ToggleSwitchApiCall();
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Container(
                      //   height: 70.h,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey[200],
                      //     borderRadius: BorderRadius.circular(15.r),
                      //     // color: Color.fromRGBO(24, 125, 203, 100),
                      //   ),
                      //   child: Center(
                      //     child: ListTile(
                      //       title: Text(
                      //         '2MFA',
                      //         style: TextStyle(
                      //             fontFamily: 'Roboto-Regular',
                      //             fontSize: 27.sp,
                      //             fontWeight: FontWeight.bold,
                      //             color: Auth2),
                      //       ),
                      //       subtitle: Text(
                      //         'Protect your account',
                      //         style: TextStyle(
                      //             fontFamily: 'Roboto-Regular',
                      //             fontSize: 17.sp,
                      //             // fontWeight: FontWeight.bold,
                      //             color: Auth1),
                      //       ),
                      //       trailing: CupertinoSwitch(
                      //         // overrides the default green color of the track
                      //         activeColor: Auth1,
                      //         // color of the round icon, which moves from right to left
                      //         thumbColor:
                      //             isAuth == true ? Auth2 : Colors.grey[700],
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
                      // SizedBox(height: 20.h),
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Pin',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 27.sp,
                                  fontWeight: FontWeight.bold,
                                  color: pin2),
                            ),
                            subtitle: Text(
                              'Tighten your security',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 17.sp,
                                  // fontWeight: FontWeight.bold,
                                  color: pin1),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: pin1,
                              // color of the round icon, which moves from right to left
                              thumbColor:
                                  isPin == true ? pin2 : Colors.grey[700],
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
                      SizedBox(height: 20.h),
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Thumb Verification',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: pin2),
                            ),
                            subtitle: Text(
                              'Device Fingerprint Supportive',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 15.sp,
                                  // fontWeight: FontWeight.bold,
                                  color: pin1),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: pin1,
                              // color of the round icon, which moves from right to left
                              thumbColor:
                                  isThumb == true ? pin2 : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isThumb,
                              // changes the state of the switch
                              onChanged: (value) async {
                                setState(() => isThumb = value);
                                isThumb == true ? thumb() : null;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.r),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Use Device Lock',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: lock2),
                            ),
                            subtitle: Text(
                              'Use same lock as your device',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 15.sp,
                                  // fontWeight: FontWeight.bold,
                                  color: lock1),
                            ),
                            trailing: CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: lock1,
                              // color of the round icon, which moves from right to left
                              thumbColor:
                                  isLock == true ? lock2 : Colors.grey[700],
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: isLock,
                              // changes the state of the switch
                              onChanged: (value) async {
                                setState(() => isLock = value);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0,),
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
                          await storeStreamlineInfo();

                          int StreamLine = 0;
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.setInt('StreamLine', StreamLine);
                          print("streamline: $StreamLine");
                          if (StreamLine == 0) {
                            setState(() {
                              isViewed == 1;
                            });
                          }
                          toggleSwitchApiCall();
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: 45.h,
                          //width: double.infinity,
                          decoration: BoxDecoration(
                            color: isButtonPressed
                                ? Colors.white
                                : Color(0xFFB2A0FB),
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SizedBox(
                            height: 40.0,
                            child: Center(
                            
                              // Text widget used to display any text on screen
                              child: Text(
                                "Update Preferences",
                                style: TextStyle(
                                  //height: 2.5.h,
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isButtonPressed
                                      ? Color(0xFFB2A0FB)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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

  // Future<void> _addLocationToAPI(LocationData locationData) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String? obtainedToken = sharedPreferences.getString('token');
  //   // obtainedToken converted to string
  //   obtainedToken.toString();
  //   print(obtainedToken);
  //   Dio dio = Dio();
  //   final api = ApiServices(Dio(), "/addDeviceLocation");
  //   String apiUrl = 'https://seerecs.org/user/addDeviceLocation';
  //   //try{
  //   // final response = await api.ApiUser(locationData(), context);
  //   // //Print response here
  //   // print('Response status: ${response.statusCode}');
  //   // print('Response body: ${response}');
  //   try {
  //     Response response = await dio.post(apiUrl,
  //         options: Options(
  //           method: 'POST',
  //           headers: {'Authorization': 'Bearer $obtainedToken'},
  //         ),
  //         data: {
  //           'latitude': locationData.latitude,
  //           'longitude': locationData.longitude,
  //           'elevation': locationData.altitude,
  //         });
  //
  //     print('Location data added to API: ${response.data}');
  //   } catch (error) {
  //     print('Error adding location data to API: $error');
  //   }
  // }

  Future<bool> checkPermission(
      Permission permission, BuildContext context) async {
    //PermissionStatus status = await permission.status;
    //location.PermissionStatus locationStatus = await location?.Permission().status;
    final status1 = await permission.request();

    // if (!locationStatus.isGranted) {
    //   locationStatus = await permission.request();
    // }
    bool isPermissionGranted = status1.isGranted;
    //|| status.isGranted;

    if (isPermissionGranted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Granted")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission is not Granted")));
    }

    return isPermissionGranted;
  }

  void startLocationUpdates() {
    if (_locationSubscription == null) {
      _locationSubscription = deviceLocation.onLocationChanged.listen((locationData) {
        // Send location data to API
        sendLocationData(locationData);
      });

      // Update location every hour
      Timer.periodic(Duration(hours: 1), (timer) {
        deviceLocation.getLocation().then((locationData) {
          sendLocationData(locationData);
        });
      });
    }
  }

  void stopLocationUpdates() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  void sendLocationData(LocationData locationData) async {
    try {
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      final String? obtainedToken = sharedPreferences.getString('token');

      if (obtainedToken == null) {
        throw Exception('Token not found in SharedPreferences');
      }
      // Perform API call to store location data
      Response response = await dio.request('https://seerecs.org/user/addDeviceLocation',
          options: Options(
            method: 'POST',
            headers: {'Authorization': 'Bearer $obtainedToken'},
          ),
          data: {
            'latitude': locationData.latitude,
            'longitude': locationData.longitude,
            'elevation': locationData.altitude,
          });
      print('Location data sent: ${response.statusCode}');
      print(locationData.latitude);
    } catch (e) {
      print('Error sending location data: $e');
    }
  }
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
            biometricOnly: true,
          ));
    } catch (e) {
      print('error $e');
      return false;
    }
  }
}
