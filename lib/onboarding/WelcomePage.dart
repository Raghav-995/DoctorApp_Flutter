//import 'dart:ffi';
import 'dart:async';
import 'package:Seerecs/Assets/CustomPageRoute.dart';
import 'package:Seerecs/Screens/PinAuth.dart';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:Seerecs/Screens/LoginScreen.dart';
import 'package:Seerecs/Screens/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'Home_Page.dart';
import 'package:Seerecs/Screens/AppPreferences.dart';

late var finalToken; // variable to store token which will get from api in login page
int? isStreamLine;
bool hasNavigated = false;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

void navigateEnterPin(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('ChangePin', 0);
  int ValidatePinBackButton = 1;
  SharedPreferences prefs1 = await SharedPreferences.getInstance();
  await prefs1.setInt('ValidatePinBackButton', ValidatePinBackButton);
  Navigator.push(context, MaterialPageRoute(builder: (context) => PinAuth()));
}

Future<void> welcomeNavigation(context) async {
  if (!hasNavigated) {
    hasNavigated = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    int? isStreamLine = await preferences.getInt('StreamLine');
    //print(isStreamLine);// Set the flag to true to prevent further navigation
    print('isStreamLine: $isStreamLine');
    if (isStreamLine == 1) {
      Navigator.pushReplacement(
          context, CustomPageRoute(child: StreamLinePreferences()));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? isPinState = prefs.getInt('isPinState');
      // print('isPinState: $isPinState');
      // print('PinSwitchOn: $PinSwitchOn');
      //
      // PinSwitchOn = prefs.getInt('PinSwitchOn')!;
      bool isLoggedIn =
          prefs.containsKey('token') && prefs.getString('token') != null;
      print('token');
      //print('isStreamLine: $isStreamLine');
      if (isPinState == 1) {
        print('User has a pin set. Navigating to EnterPin.');
        navigateEnterPin(context); // Assuming this function exists
      } else if (isLoggedIn) {
        print('User is logged in. Navigating to BottomNavigation.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
      } else {
        print(
            'User is not logged in and does not have a pin set. Navigating to WelcomePage.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
        );
      }
    }
  }
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    //SetPinAuthenticationInfo();
    getValidationData().whenComplete(() {
      // Call welcomeNavigation asynchronously
      welcomeNavigation(context);
    });
  }

  // Here will get shared preference from login screen
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // Token from api will be stored in obtainedToken variable.
    var obtainedToken = sharedPreferences.get('token');
    setState(() {
      finalToken = obtainedToken;
    });
    print(finalToken);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isStreamLine = await preferences.getInt('StreamLine');
    print(isStreamLine);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //height: 700.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white, width: 7),
                //borderRadius: BorderRadius.circular(30),
                borderRadius: BorderRadius.all(Radius.elliptical(30.r, 30.r))),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        //color: const Color(0xff333366),
                        //borderRadius: BorderRadius.circular(30)
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(20.r, 20.r))),
                    constraints:
                        const BoxConstraints(maxWidth: 420, maxHeight: 350),
                  ),
                ),
                Positioned(
                  top: 13.h,
                  height: 390.h,
                  //height: MediaQuery.of(context).size.height / 1.9,
                  child: ClipRRect(
                    child: Image.asset("assets/Dio-02 1.png"),
                  ),
                ),
                Positioned(
                  top: 370.h,
                  //top: MediaQuery.of(context).size.height / 1.9,
                  height: 200.0.h,
                  child: Container(
                    //height: 210.0.h,
                    width: 420.0.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 26.0.h,
                          ),
                          Text('C-Res Application',
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF37304A))),
                          SizedBox(
                            height: 16.0.h,
                          ),
                          Text(
                            'C-Recs is a healthcare app that helps users manage and track their health and wellness.',
                            style: TextStyle(
                                fontSize: 17.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9896A1)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 47, right: 47, bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 4),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pushReplacement(
                                    context,
                                    CustomPageRoute(child: RegisterPage())),
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFB2A0FB),

                                    //padding: EdgeInsets.symmetric(vertical: 40),
                                    //minimumSize: Size(10, 100),
                                    fixedSize: Size.fromHeight(65),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                              ),
                            ),
                            Expanded(
                                child: SizedBox(
                              height: 60.0.h,
                              child: TextButton(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          WidgetStateProperty.all(
                                              Colors.black),
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.white),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ))),
                                  onPressed: () {
                                    //setLoggedInStatus(false);
                                    Navigator.pushReplacement(context,
                                        CustomPageRoute(child: LoginScreen()));
                                  }),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
