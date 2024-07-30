import 'dart:convert';
import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/ProfilePinSet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Assets/CustomPageRoute.dart';
import '../network/API_Services.dart';
import '../network/response_AlterBox.dart';
import 'BottomNavigation Screens/BottomNavigationContentScreens/ChangePin.dart';
import '../../../Assets/Messages.dart' as message;
import 'BottomNavigation/Profile.dart';

class EnterPassword extends StatefulWidget {
  EnterPassword({super.key});

  // Email will get from register page it will be stored in OtpEmail string

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

int? setPinAuth;

setPinAuthenticationInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setPinAuth = prefs.getInt('setPinAuth');
}

storeSetPinInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pinSwitchOn = prefs.getInt('pinSwitchOn')!;
}
// int? SetPinAuth;
//
// SetPinAuthenticationInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   SetPinAuth = prefs.getInt('SetPinAuth');
// }

// final EnterPinColor1 = Color.fromRGBO(52, 145, 184, 90); // Color
// final EnterPinColor2 = Color.fromRGBO(38, 90, 112, 60); //Color

class _EnterPasswordState extends State<EnterPassword> {
  final form = GlobalKey<FormState>();

  TextEditingController passwordController =
      TextEditingController(); //Password controller
  final textFieldFocusNode = FocusNode(); // Password field Obscure focus check
  bool _isObscure = false; //Boolean to check if eye icon tapped or not

  // Checking if eye icon on password field is tapped and making field obscure on condition.
  void _toggleObscured() {
    setState(() {
      _isObscure = !_isObscure;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  // Function will call api
  // PasswordVerifyApiCall(String password) async {
  //   // Call your API here and pass `_verificationCode` as a parameter
  //   final api = ApiServices(Dio(), "/validatePassword");
  //   dynamic otpData = json.encode({"password": "${password}"});
  //   // verification code will be converted to json body
  //   Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
  //   // Api response? will get here
  //   final response? = await api.ApiUser(jsonOtpData, context);
  //   //Print response? here
  //   print('response? status: ${response?
  //       .statusCode}');
  //   print('response? body: ${response?}');
  //   print(
  //       'response? headers: ${response?
  //           .headers[HttpHeaders
  //           .authorizationHeader]}');
  //   // Converting api json response? to Map string.
  //   String decoderesponse? = response?.toString();
  //   Map<String, dynamic> res =
  //   jsonDecode(decoderesponse?);
  //   res['token'] =
  //   '${response?.headers[HttpHeaders
  //       .authorizationHeader]}';
  //   late var token = res['token'];
  //   token = token.substring(1, token.length - 1);
  //
  //   print(token);
  //   // Shared preferences used here so we can store token which will get from api.
  //   SharedPreferences sharedPreferences =
  //   await SharedPreferences.getInstance();
  //   sharedPreferences.setString('token', token);
  //   // Shared preferences used here so we can store token which will get from api.
  //   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // sharedPreferences.setString('token', token);
  //   print(res['message']);
  //
  //   // If api response? is true for success then will show dialog box
  //   if (response?.statusCode == 200) {
  //     CustomSnackBar(context, 'Password validated successfully');
  //     //($setPinAuth);
  //     print('SetPinAuth: $SetPinAuth');
  //     SetPinAuth == 1
  //         ? Navigator.pushReplacement(context, CustomPageRoute(child: ProfilePin()))
  //         : Navigator.pushReplacement(
  //             context, CustomPageRoute(child: ChangePin()));
  //
  //   }
  //
  //   else {}
  //   // Printing print('SetPinAuth: $SetPinAuth'); data which is provided to api
  //   print("Enter Pin request send to api with user info: ");
  //   // print(toJson());
  // }

  PasswordVerifyApiCall(String password) async {
    // Call your API here and pass `_verificationCode` as a parameter
    final api = ApiServices(Dio(), "/validatePassword");
    dynamic otpData = json.encode({"password": "${password}"});
    // verification code will be converted to json body
    Map<String, dynamic> jsonOtpData = jsonDecode(otpData);
    // Api response? will get here
    final response = await api.ApiUser(jsonOtpData, context);
    //Print response? here
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');

    //response? decoding from json to Map string
    String decode = response.toString();
    Map<String, dynamic> responseData = jsonDecode(decode);
    print(responseData['message']);
    // If api response? is true for success then will show dialog box
    if (response.statusCode == 200) {
      CustomSnackBar(context, 'Password validated successfully');
      print('setpinauth: $setPinAuth');
      print('pinSwitchOn: $pinSwitchOn');
      setPinAuth == 1
          ? Navigator.pushReplacement(
              context, CustomPageRoute(child: ProfilePin()))
          : Navigator.pushReplacement(
              context, CustomPageRoute(child: ChangePin()));
    } else {}
    // Printing json data which is provided to api
    print("Enter Pin request send to api with user info: ");
    // print(toJson());
  }

  bool isButtonPressed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPinAuthenticationInfo();
  }

  @override
  Widget build(BuildContext context) {
    // Form widget used for validation purpose.
    return Form(
        key: form,
        //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: Colors.white,
          //   flexibleSpace: Container(
          //     decoration: BoxDecoration(
          //       color: Color(0xFFB2A0FB),
          //       // gradient: LinearGradient(
          //       //   begin: Alignment.bottomLeft,
          //       //   end: Alignment.topRight,
          //       //   colors: [
          //       //     EnterPinColor1,
          //       //     EnterPinColor2,
          //       //   ],
          //       // ),
          //     ),
          //   ),
          //   centerTitle: true,
          //   leading: BackButton(
          //     color: Colors.white,
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   title: Text(
          //     'Authentication Required',
          //     style: TextStyle(
          //         fontFamily: 'Roboto-Regular',
          //         fontSize: 35.sp,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white),
          //   ),
          // ),
          // Safe area will keep screen under notification panel
          body: SafeArea(
            // Container used to take whole screen size with media query.
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                //height: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height * 0.94,
                width: MediaQuery.of(context).size.width,
                //color: Colors.white,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white, width: 7),
                  borderRadius: BorderRadius.circular(30),
                ),
                // All widgets will bw in list view.
                child:
                    Stack(alignment: AlignmentDirectional.topStart, children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          //color: const Color(0xff333366),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(20, 20))
                          //borderRadius: BorderRadius.circular(30)
                          ),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width,
                          maxHeight: 350),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      //_showAlertDialog(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    //right: 0,
                    left: 50,
                    //bottom: 5,
                    height: 260.0.h,
                    //height: MediaQuery.of(context).size.height * 0.49,
                    //alignment: AlignmentDirectional.topCenter,
                    child: ClipRRect(
                      child: Image.asset("assets/dio-04 1.png"),
                    ),
                  ),

                  //top: MediaQuery.of(context).size.height * 0.46,
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.46,
                    child: Container(
                        width: 430.0.w,
                        child: Padding(
                            //padding: const EdgeInsets.all(8.0),
                            padding: EdgeInsets.fromLTRB(
                                25.0.w, 0.0.h, 5.0.w, 0.0.h),
                            child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.asset(
                                  //   "assets/ChangePasswordDyno.png",
                                  //   height: 250.0.h,
                                  // ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Text(
                                    //textAlign: TextAlign.center,
                                    " Validate your password",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 26.sp,
                                        color: Color(0xff37304A)),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: !_isObscure,
                                    autofocus: false,
                                    focusNode: textFieldFocusNode,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          fontFamily: 'Roboto-Regular',
                                          color: Color(0xFFB5B4BD)),
                                      hintText: message.password,
                                      labelStyle: TextStyle(
                                          fontFamily: 'Roboto-Regular',
                                          color: Color(0xFFB5B4BD)),
                                      labelText: 'Password',
                                      suffixIcon: GestureDetector(
                                        onTap: _toggleObscured,
                                        child: Icon(
                                          _isObscure
                                              ? Icons.visibility_off_rounded
                                              : Icons.visibility_rounded,
                                          size: 25.sp,
                                          color: (_isObscure == false)
                                              ? Colors.grey[400]
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    // Validation of password.
                                    validator: (Value) {
                                      // Conditions used for password validation.
                                      RegExp regex = RegExp(
                                          (r'^(?!.*\s)(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$'
                                          //r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
                                          ));
                                      var passNonNullValue = Value ?? "";
                                      if (passNonNullValue.isEmpty) {
                                        return ("Password is required");
                                      } else if (passNonNullValue.length < 6) {
                                        return ("Password must be more than 5 characters");
                                      } else if (!regex
                                          .hasMatch(passNonNullValue)) {
                                        return ("Password should contain upper,lower "
                                            '\n'
                                            "digit and special character ");
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  // InkWell widget used to make any widget clickable so we can perform task on them
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
                                    onTap: () {
                                      // Checking if all validation is done or not.
                                      final isValid =
                                          form.currentState!.validate();
                                      // If all fields validated then it will call api
                                      if (isValid == true) {
                                        PasswordVerifyApiCall(
                                            passwordController.text);
                                      } else {
                                        CustomSnackBar(
                                            context, 'Input password field');
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      //height: 45.h,
                                      //width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: isButtonPressed
                                            ? Colors.white
                                            : Color(0xFFB2A0FB),
                                        border: Border.all(
                                            color: Colors.white, width: 3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        // Text widget used to display any text on screen
                                        child: Text(
                                          "Continue",
                                          style: TextStyle(
                                            height: 3.h,
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
                                ]))),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}

