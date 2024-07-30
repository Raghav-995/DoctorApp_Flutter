import 'dart:async';
import 'dart:convert';
import 'package:Seerecs/Assets/CustomPageRoute.dart';
import 'package:Seerecs/Assets/themeChanger.dart';
import 'package:Seerecs/Screens/EnterPin.dart';
import 'package:Seerecs/onboarding/OnBoard.dart';
import 'package:Seerecs/onboarding/WelcomePage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:is_lock_screen2/is_lock_screen2.dart';
import 'package:Seerecs/Assets/local_auth_services.dart';
import 'package:Seerecs/Assets/UserModel.dart' as user;


int? initScreen;

final GlobalKey<NavigatorState> NavigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');
  
  runApp(HealthApp());
}

class HealthApp extends StatefulWidget {
  //bool isLoggedIn;
  HealthApp({super.key});

  @override
  State<HealthApp> createState() => _HealthAppState();
}

void NavigateEnterPin(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('ChangePin', 0);
  int validatePinBackButton = 1;
  SharedPreferences prefs1 = await SharedPreferences.getInstance();
  await prefs1.setInt('validatePinBackButton', validatePinBackButton);
  NavigatorKey.currentState?.push(CustomPageRoute(child: EnterPin()));
}

//void ThumbVerification(BuildContext context)
class _HealthAppState extends State<HealthApp> with WidgetsBindingObserver {
  //final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  LocalAuthServices localAuthServices = LocalAuthServices();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addObserver(this);
    print('Initializing _HealthAppState');
    //_themeData = ThemeData.light();
    sendDeviceInfoToAPI();
    super.initState();
  }

  // void updateTheme(ThemeData theme) {
  //   setState(() {
  //     _themeData = theme;
  //   });
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
     print('app inactive, is lock screen: ${await isLockScreen()}');
    } else if (state == AppLifecycleState.resumed) {
      AppLifecycleState.inactive == false
        ? print('app resumed')
          : navigate(context);
    }
 }

  Future<Map<String, dynamic>> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
    else {
      return _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    }
    //return 0;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'os': 'Android',
      'deviceID': build.device,
      'deviceModel': build.model,
      'brand': build.brand,
      'androidVersion': build.version.release,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return {
      // 'os': 'iOS',
      // 'osVersion': data.systemVersion,
      // 'deviceName': data.name,
      (user.deviceName): data.name,
      (user.os): 'iOS',
      (user.osVersion): data.systemVersion,
      (user.appVersion): '1.1.0',
      'identifiers': data.identifierForVendor,
      // Add more fields as needed
    };
  }

  Future<void> sendDataToAPI(Map<String, dynamic> data) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? obtainedToken = sharedPreferences.getString('token');

      if (obtainedToken == null) {
        throw Exception('Token not found in SharedPreferences');
      }

      final Dio dio = Dio();

      final innerJsonString = json.encode(data);
      final jsonData = json.encode({'data': innerJsonString});

      final response = await dio.request(
        'https://seerecs.org/user/addDeviceInfo',
        options: Options(
          method: 'POST',
          headers: {'Authorization': 'Bearer $obtainedToken'},
        ),
        data: jsonData,
      );

      //_statusMessage = 'Response: ${response.data}';
      print(response.data);
    } catch (e) {
      print('error: $e');
    }
  }
///
  Future<void> sendDeviceInfoToAPI() async {
    try {
      final Map<String, dynamic> deviceInfo = await getDeviceInfo();
      await sendDataToAPI(deviceInfo);
      setState(() {
      });
    } catch (e) {
      setState(() {
      });
    }
  }

// void authenticate() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool devicelock = prefs.getBool('isDeviceLockEnabled') ?? false;
//   print('devicelock: $devicelock');
//     final bool isAvailable = await localAuthServices.authenticate();
//     if(devicelock ==  true){
//     if (isAvailable) {
//       localAuthServices.didauthenticated().then((value) {
//         if (value) {
//           Future.delayed(const Duration(seconds: 3), () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const BottomNavigation(),
//               ),
//               (route) => false,
//             );
//           });
//         } else {
//           authenticate();
//         }
//       });
//     }
//     }
//   }
  // void getdata() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? isTwoFactorAuthState = prefs.getInt('isTwoFactorAuthState');

  //   if (isTwoFactorAuthState == 1) {
  //     // If isTwoFactorAuthState is 1, navigate to EnterPin
  //     navigateEnterPin();
  //   } else {
  //     // Otherwise, do nothing or navigate to another page if needed
  //   }
  // }

//   void thumb() async {
//     bool auth = await Authentication.authentication();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? Thumb = prefs.getInt('Thumb');
//     //int? Thumb;
//     print("can authenticate: $auth");
//     if (Thumb == 1) {
//       if (auth) {
//         // Navigator.push(context,
//         //     MaterialPageRoute(builder: (context) => BottomNavigation()));
//       }
//     }
//   }
// ThumbVerification() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   int? isThumbState = prefs.getInt('isThumbState');
//   bool? isThumb = prefs.getBool('isThumb');
//   if (isThumbState != null && isThumb != null) {
//     print('Context: $context');
//     if (isThumbState == 1 && isThumb == true) {
//       thumb();
  //  print('Before navigation');
  // // navigateEnterPin(context);
  //  print('After navigation');
  //  Navigator.pushReplacement(
  //    context,
  //    CustomPageRoute(child: BottomNavigation()),
  //);
  //navigateEnterPin(context);
  //navigatorKey.currentState?.push(CustomPageRoute(child: EnterPin()));
//       print("ok");
//     }
//   }
// }
  // else if (isThumbState == 0 && isThumb == false) {
  // }
  // Future<void> getdata(BuildContext context) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     int? isTwoFactorAuthState = prefs.getInt('isTwoFactorAuthState');
  //     bool? isAuth = prefs.getBool('isAuth');
  //     // bool ischeck = prefs.containsKey("isTwoFactorAuthState") &&
  //     //     prefs.getInt('isTwoFactorAuthState') == 1;
  //     if (isTwoFactorAuthState == 1 && isAuth == true) {
  //       navigateEnterPin(context);
  //       print("ok");
  //       // }
  //     } else if (isTwoFactorAuthState == 0 && isAuth == false) {
  //       Navigator.pushReplacement(
  //           context, CustomPageRoute(child: BottomNavigation()));
  //       print("not ok");
  //     }
  //   } catch (e) {
  //     print('Error in getdata: $e');
  //   }
  // }
  // Future<void> loadData() async {
  //   print('Before if statement');
  //
  //   //try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     int? isTwoFactorAuthState = prefs.getInt('isTwoFactorAuthState');
  //     bool? isAuth = prefs.getBool('isAuth');
  //   print('isTwoFactorAuthState: $isTwoFactorAuthState, isAuth: $isAuth');
  //   if (isTwoFactorAuthState != null && isAuth != null){
  //     print('Context: $context');
  //     if (isTwoFactorAuthState == 1 && isAuth == true) {
  //     print('Before navigation');
  //     navigateEnterPin(context);
  //     print('After navigation');
  //
  //     navigateEnterPin(context);
  //       //navigatorKey.currentState?.push(CustomPageRoute(child: EnterPin()));
  //       print("ok");
  //     } else if (isTwoFactorAuthState == 0 && isAuth == false) {
  //       Navigator.pushReplacement(
  //         context,
  //         CustomPageRoute(child: BottomNavigation()),
  //       );
  //       print("not ok");
  //     }
  //   }else {
  //     print('One or both SharedPreferences values are null.');
  //   }
  //   // } catch (e) {
  //   print('Error in loadData: $e');
  // }
  //   print('after if statement');
  // }

  // void navigateEnterPin() {
  //   Future.delayed(Duration.zero, () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => EnterPin()),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480, 690),
      //designSize: const Size(375, 667),
      //designSize: Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ChangeNotifierProvider(
            create: (_) => ThemeChanger(),
            child: Builder(builder: (BuildContext context) {
              Provider.of<ThemeChanger>(context);
              return MaterialApp(
                //resizeToAvoidBottomInset: true,
                title: "Seerecs",
                //theme: _themeData,
                // theme: ThemeData(
                //   scaffoldBackgroundColor: Colors.white,
                //   fontFamily: 'Roboto-Regular',
                //   // colorScheme: ColorScheme.fromSwatch().copyWith(
                //   //   //primary: Color.fromRGBO(52, 145, 184, 40),
                //   //   primary: Color(0xFFB2A0FB),
                //   //   //primary: Colors.white,
                //   //   //secondary: Colors.grey,
                //   //   secondary: Colors.white,
                //   // ),
                //   inputDecorationTheme: InputDecorationTheme(
                //     enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //       width: 2.w,
                //       color: Color.fromARGB(80, 80, 80, 80),
                //     )),
                //     focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(width: 3.w, color: Colors.grey)),
                //   ),
                //   textTheme: TextTheme(
                //       bodyMedium: TextStyle(
                //           fontFamily: 'Roboto-Regular',
                //           //color: Color.fromRGBO(38, 90, 112, 60),
                //           fontSize: 15.sp)),
                //   textSelectionTheme: TextSelectionThemeData(
                //     cursorColor: Colors.grey[700],
                //   ),
                // ),
                // theme: ThemeData(
                //   brightness: Brightness.light,
                //   textTheme: TextTheme(
                //     headline4: TextStyle(
                //       fontFamily: 'Roboto-Regular',
                //       //fontFamily: Font,
                //       fontWeight: FontWeight.w600,
                //       fontSize: 24.sp,
                //       color: Color(0xff37304A),
                //     ),
                //     headline5: TextStyle(
                //       fontFamily: 'Roboto-Regular',
                //       fontWeight: FontWeight.w700,
                //       //fontFamily: 'Bold',
                //       fontSize: 18.sp,
                //       color: Color(0xff374572),
                //     ),
                //     headline6: TextStyle(
                //       fontFamily: 'Roboto-Regular',
                //       //fontFamily: 'Bold',
                //       fontSize: 14.0,
                //       color: Color(0xff334888),
                //     ),
                //   ),
                // ),
                // darkTheme: ThemeData(
                //   brightness: Brightness.dark,
                //   scaffoldBackgroundColor: Colors.grey,
                //   textTheme: TextTheme(
                //     headline4: TextStyle(
                //       fontFamily: 'Bold',
                //       fontSize: 18.0,
                //       color: Colors.white,
                //     ),
                //     headline5: TextStyle(
                //       fontFamily: 'Bold',
                //       fontSize: 16.0,
                //       color: Colors.white,
                //     ),
                //     headline6: TextStyle(
                //       fontFamily: 'Bold',
                //       fontSize: 14.0,
                //       color: Colors.white,
                //     ),
                //   ),
                //   iconTheme: IconThemeData(
                //     color: Colors.white,
                //   ),
                // ),

                debugShowCheckedModeBanner: false,
                navigatorKey: NavigatorKey,
                //home: ForgotPasswordPg(Mail: '',),
                //home: LocationDioDemo(),
                //home: UpdateProfile(firstName: '', lastName: '', email: '', city: '', zipcode: '', dob: '', address: '', phone: '', gender: '',),
                initialRoute: initScreen == 0 || initScreen == null
                    ? 'onboard'
                    : 'welcome',
                routes: {
                  'onboard': (context) => OnBoard(),
                  'welcome': (context) => WelcomePage(),
                },
              );
            }));
      },
    );
  }
}

void navigate(context) {
  //Navigator.push(context, CustomPageRoute(child: EnterPin()));
}
// void Navigate() {
//   navigatorKey.currentState?.pushReplacement(
//     MaterialPageRoute(builder: (context) => EnterPin()),
//   );
// }
