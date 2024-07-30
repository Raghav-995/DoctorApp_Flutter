import 'package:Seerecs/Assets/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:Seerecs/network/response_AlterBox.dart';
import 'package:Seerecs/Assets/UserModel.dart' as user;
// import '../Assets/Messages.dart' as message;
// import '../network/response?_AlterBox.dart';
// import '../Assets/UserModel.dart' as user;

class ForgotPasswordex extends StatefulWidget {
  ForgotPasswordex({super.key});

  @override
  State<ForgotPasswordex> createState() => _ForgotPasswordexState();
}

class _ForgotPasswordexState extends State<ForgotPasswordex> {
  //final emailController = TextEditingController();
  final _form = GlobalKey<FormState>(); //for storing form state.
  late TextEditingController _email = TextEditingController();

  final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
  final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
  }

  Map<String, dynamic> toJson() {
    return {(user.email): (_email.text.toLowerCase())};
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
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 35,),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  top: 5,
                  //height: 440,
                  height: MediaQuery.of(context).size.height / 2.35,
                  child: ClipRRect(
                    child: Image.asset("assets/dio-04 1.png"),
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
                        SizedBox(
                          height: 26.0.h,
                        ),
                        Text(
                          'Forgot your password?',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF37304A)),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        Text(
                          'Email',
                          style: const TextStyle(
                              fontSize: 17,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF393939)),
                          textAlign: TextAlign.left,
                        ),

                        //email
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(
                            //   color: Colors.white,
                            // ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FormTextField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'davidsnow@gmail.com',
                            obscureText: false,
                            suffixIcon: Icon(
                              Icons.mark_email_unread_outlined,
                              color: Colors.grey,
                            ),
                            validator: (value) {
                                          // add your custom validation here.
                                          if ((value.toString().isEmpty)) {
                                            return 'Please enter valid email';
                                          }
                                          if (!RegExp(
                                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                              .hasMatch(value!)) {
                                            return 'Please a valid Email';
                                          }
                                          return null;
                                        },
                          ),
                        ),

                        const SizedBox(height: 40),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 10,
                        //     vertical: 3,
                        //   ),
                        InkWell(
                          onTap: () async {
                            _saveForm();
                            final isValid = _form.currentState!.validate();
                            if (isValid == true) {
                              final api = ApiServices(Dio(), "/forgotPassword");
                              final response =
                                  await api.ApiUser(toJson(), context);
                              print('response? status: ${response.statusCode}');
                              print('response? body: ${response}');
                              String decode = response.toString();
                              Map<String, dynamic> res = jsonDecode(decode);
                              print(res['success']);
                              var check = res['success'];
                              if (check == true) {
                                CustomSnackBar(context, 'Password reset link send to your mail');
                              } else {}
                              print(
                                  "Forgot password request send to api with user info: ");
                              print(toJson());
                            } else {}
                          },
                          child: Container(
                            height: 35.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  PrimaryColor,
                                  SecondaryColor,
                                ],
                              ),
                              // color: Color.fromRGBO(24, 125, 203, 100),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0.r)),
                            ),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Roboto-Regular'),
                              ),
                            ),
                          ),
                        ),
                        
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: MaterialButton(
                        //         color: Color(0xFFB2A0FB),
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(15),
                        //             side: BorderSide(
                        //                 color: Colors.white, width: 2)),
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const OTPScreen()));
                        //         },
                        //         child: const Padding(
                        //           padding: EdgeInsets.all(20.0),
                        //           child: Text(
                        //             "Continue",
                        //             style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w600,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
