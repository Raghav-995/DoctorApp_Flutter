import 'package:Seerecs/Assets/UserModel.dart';
import 'package:Seerecs/iconform_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';


class PasswordRecovery extends StatefulWidget {
  PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final passwordController = TextEditingController();
  bool isChecked = false;
  bool _pri_isObscure = false;
  bool _sec_isObscure = false;

  final AppBarColor1 = Color.fromRGBO(52, 145, 184, 90);
  final AppBarColor2 = Color.fromRGBO(38, 90, 112, 60);

  late TextEditingController _password = TextEditingController();
  late TextEditingController _reTypePassword = TextEditingController();

  Map<String, dynamic> toJson() {
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

  Future<bool> _onWillPopHome(BuildContext context) async {
    Navigator.pop(context);

    return canBack;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                        borderRadius: BorderRadius.circular(30)),
                    constraints:
                        const BoxConstraints(maxWidth: 410, maxHeight: 350),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 15,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 40,
                  //height: 440,
                  height: MediaQuery.of(context).size.height / 2.4,
                  child: ClipRRect(
                    child: Image.asset("assets/Dio-01 1.png"),
                  ),
                ),
                Positioned(
                  //top: 480,
                  top: MediaQuery.of(context).size.height / 2.1,
                  //height: 100.0.h,
                  child: Container(
                    //height: 190.0.h,
                    width: 430.0.w,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: const Text(
                              "Password Recovery",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF37304A)),
                            ),
                          ),
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 20,
                        //     vertical: 10,
                        //   ),
                        //   child: Text(
                        //     "Your new password must be unique from those previously used.",
                        //     style: TextStyle(
                        //       color: Color(0xFF8391A1),
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        //password
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F8F9),
                              border: Border.all(
                                color: const Color(0xFFE8ECF4),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FormTextField(
                              controller: passwordController,
                              hintText: 'New Password',
                              obscureText: false,
                              suffixIcon: Icon(
                                Iconform.lock,
                                color: Colors.grey,
                              ),
                              validator: (Value) {
                                RegExp regex = RegExp(
                                    (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'));
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
                          ),
                        ),

                        const SizedBox(height: 15),
                        //confirm password
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F8F9),
                              border: Border.all(
                                color: const Color(0xFFE8ECF4),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FormTextField(
                              controller: passwordController,
                              hintText: 'Confirm Password',
                              obscureText: false,
                              suffixIcon: Icon(
                                Iconform.lock,
                                color: Colors.grey,
                              ),
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please Re-Enter New Password";
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
                          ),
                        ),

                        const SizedBox(height: 20),
                        //register button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  color: Color(0xFFB2A0FB),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Colors.white, width: 2)),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => HomePage()));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
