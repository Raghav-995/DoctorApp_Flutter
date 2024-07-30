import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Assets/Messages.dart' as message;
import '../../../network/API_Services.dart';
import '../../../network/response_AlterBox.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final form = GlobalKey<FormState>(); //for storing form state.
  bool isChecked = false;
  bool _pri_isObscure = false;
  bool _sec_isObscure = false;

  // final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
  // final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);

  late TextEditingController _password = TextEditingController();
  late TextEditingController _reTypePassword = TextEditingController();

  Map<String, dynamic> changePasswordData() {
    return {
      ('newPassword'): (_reTypePassword.text),
    };
  }

  final _pri_textFieldFocusNode =
      FocusNode(); // Password field Obscure focus check
  final _sec_textFieldFocusNode =
      FocusNode(); // Password field Obscure focus check

  // Checking if eye icon on password field is tapped and making field obscure on condition.
  void _pri_toggleObscured() {
    setState(() {
      _pri_isObscure = !_pri_isObscure;
      if (_pri_textFieldFocusNode.hasPrimaryFocus) return;
      _pri_textFieldFocusNode.canRequestFocus = false;
    });
  }

  // Checking if eye icon on confirm password field is tapped and making field obscure on condition.
  void _sec_toggleObscured() {
    setState(() {
      _sec_isObscure = !_sec_isObscure;
      if (_sec_textFieldFocusNode.hasPrimaryFocus) return;
      _sec_textFieldFocusNode.canRequestFocus = false;
    });
  }

  bool canBack = false;
  bool isButtonPressed = false;

  Future<bool> _onWillPopHome(BuildContext context) async {
    Navigator.pop(context);

    return canBack;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        final showPop = await _onWillPopHome(context);
        return showPop;
      },
      child: Form(
        key: form,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                height: MediaQuery.of(context).size.height*0.94,
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
                child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            //color: const Color(0xff333366),
                            borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                          //borderRadius: BorderRadius.circular(30)
                        ),
                        //constraints: BoxConstraints.expand(),
                        constraints: BoxConstraints(maxWidth: width, maxHeight: 350),
                      ),
                      InkWell(
                        onTap: () {
                          //_showAlertDialog(context);
                          Navigator.pop(context);
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
                        left: 30,
                        //bottom: 5,
                        height: 260.0.h,
                        //height: MediaQuery.of(context).size.height * 0.49,
                        child: ClipRRect(
                          child: Image.asset("assets/Dio-01 1.png"),
                        ),
                      ),

                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.46,

                      child: Container(
                        width: 430.0.w,

                        child: Padding(
                          //padding: const EdgeInsets.all(8.0),
                          padding: EdgeInsets.fromLTRB(20.0.w, 0.0.h, 0.0.w, 0.0.h),

                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image.asset(
                              //   "assets/ChangePasswordDyno.png",
                              //   height: 250.0.h,
                              // ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                //textAlign: TextAlign.left,
                                "Create your new password",
                                style: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  //color: Colors.black,
                                    color: Color(0xff37304A),
                                    //fontWeight: FontWeight.w500
                                  ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _password,
                                keyboardType: TextInputType.visiblePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: !_pri_isObscure,
                                focusNode: _pri_textFieldFocusNode,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                      color: Color(0xFFB5B4BD)
                                  ),
                                  hintText: message.password,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                    color: Color(0xFFB5B4BD)
                                  ),
                                  labelText: 'Password',
                                  //fillColor: Colors.grey[200],
                                  suffixIcon: GestureDetector(
                                    onTap: _pri_toggleObscured,
                                    child: Icon(
                                      _pri_isObscure
                                          ? Icons.visibility_off_rounded // Eye icon
                                          : Icons.visibility_rounded, // Eye icon
                                      size: 25.sp,
                                      // Color will be change if icon is tapped
                                      color: (_pri_isObscure == false)
                                          ? Colors.grey[400]
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                // Validation will be done here
                                validator: (Value) {
                                  RegExp regex = RegExp(
                                      (
                                          r'^(?!.*\s)(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$'
                                          //r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
                                      ));
                                  var passNonNullValue = Value ?? "";
                                  if (passNonNullValue.isEmpty) {
                                    return ("Please enter password");
                                  } else if (passNonNullValue.length < 6) {
                                    return ("Password should contain 6 character with capital,"
                                        '\n'
                                        "small letter & number & special");
                                  } else if (!regex.hasMatch(passNonNullValue)) {
                                    return ("Password should contain 6 character with capital,"
                                        '\n'
                                        "small letter & number & special");
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              //TextFormField used to get confirm password text input from user.
                              TextFormField(
                                controller: _reTypePassword,
                                keyboardType: TextInputType.visiblePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: !_sec_isObscure,
                                focusNode: _sec_textFieldFocusNode,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                      color: Color(0xFFB5B4BD)
                                  ),
                                  hintText: message.confirmPassword,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                      color: Color(0xFFB5B4BD)
                                  ),
                                  labelText: 'Confirm Password',
                                  //fillColor: Colors.grey[200],
                                  suffixIcon: GestureDetector(
                                    onTap: _sec_toggleObscured,
                                    child: Icon(
                                      _sec_isObscure
                                          ? Icons.visibility_off_rounded // Eye icon
                                          : Icons.visibility_rounded, // Eye icon
                                      size: 25.sp,
                                      // Color will be change if icon is tapped
                                      color: (_sec_isObscure == false)
                                          ? Colors.grey[400]
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                // Validation will be done here
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please re-enter new password";
                                  } else if (value.toString().length < 6) {
                                    return "Password must be at least 6 characters long";
                                  } else if (_reTypePassword.text !=
                                      _password.text) {
                                    return "Password must be same as above";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 25.h,
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
                                  final isValid = form.currentState!.validate();
                                  if (isValid == true) {
                                    // Api call here
                                    final api =
                                        ApiServices(Dio(), "/updatePassword");
                                    // Will get response? of api.
                                    final response =
                                        await api.ApiUser(changePasswordData(), context);

                                    // Printing response? and status code here
                                    print(
                                        'response status: ${response.statusCode}');
                                    print('response body: ${response}');

                                    // Converting api json response? to string.
                                    String decode = response.toString();
                                    Map<String, dynamic> res = jsonDecode(decode);
                                    print(res['message']);
                                    //If message from api is true then will navigate to Email Otp page.
                                    if (response.statusCode == 200) {
                                      CustomSnackBar(
                                          context, 'Password updated successfully');
                                      Timer(Duration(milliseconds: 1500),
                                          () => Navigator.pop(context));
                                    }
                                  } else {}
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: 45.h,
                                  //width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                                    border: Border.all(color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    // Text widget used to display any text on screen
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        //height: 2.5.h,
                                        fontFamily: 'Roboto-Regular',
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: isButtonPressed ? Color(0xFFB2A0FB) : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
