import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/Screens/NewUsername.dart';
import 'package:Seerecs/network/API_Services.dart';
import '../Assets/CustomPageRoute.dart';
import '../Assets/Messages.dart' as message;
import '../Assets/UserModel.dart' as user;
import '../network/response_AlterBox.dart';

class ForgotUsername extends StatefulWidget {
  ForgotUsername({super.key, required this.Mail});

  final String Mail;

  @override
  State<ForgotUsername> createState() => _ForgotUsernameState();
}

class _ForgotUsernameState extends State<ForgotUsername> {
  final _form = GlobalKey<FormState>(); //for storing form state.
  late TextEditingController _email = TextEditingController();

  // bool _validate = false;

  final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
  final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);



  Map<String, dynamic> toJson() {
    return {(user.email): (_email.text.toLowerCase())};
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
          leading: BackButton(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  PrimaryColor,
                  SecondaryColor,
                ],
              ),
            ),
          ),
          title: Text(
            message.forgotUsername,
            style: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          bottom: true,
          right: true,
          left: true,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(45.0.w, 10.0.h, 45.0.w, 10.0.h),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Forget_password.png",
                          height: 280.0.h,
                          // width: 300.0.w,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "No worries! We’re here to help you out.",
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            color: SecondaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Please enter your email id to know your username",
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            color: SecondaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 25.h,
                            ),
                            Container(
                              height: 100.h,
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
                                borderRadius: BorderRadius.circular(15.r),
                                // color: SecondaryColor,
                              ),
                              child: Card(
                                margin: EdgeInsets.all(3),
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: ListTile(
                                      leading: Stack(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.blue[50],
                                            radius: 35.r,
                                            child: Icon(
                                              Icons.email,
                                              size: 30,
                                              color: Color.fromRGBO(
                                                  24, 125, 203, 100),
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                        message.viaEmail,
                                        style: TextStyle(
                                            color: SecondaryColor,
                                            fontSize: 20.sp,
                                            fontFamily: 'Roboto-Regular',
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: TextFormField(
                                        controller: _email,
                                        // initialValue: widget.Mail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          hintStyle: TextStyle(
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.grey[400]),
                                          hintText: message.email,
                                          // filled: true,
                                          // fillColor: Colors.grey[200],
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        InkWell(
                          onTap: () async {
                            // _saveForm();
                            final isValid = _form.currentState!.validate();
                            if (isValid == true) {
                              final api = ApiServices(Dio(), "/forgotUsername");
                              final response =
                                  await api.ApiUser(toJson(), context);
                              print('response? status: ${response.statusCode}');
                              print('response? body: ${response}');

                              String decode = response.toString();
                              Map<String, dynamic> res = jsonDecode(decode);
                              print(res['success']);
                              var check = res['success'];
                              if (check == true) {
                                CustomSnackBar(context, 'Username reset link send to your mail');
                                Navigator.push(context,
                                    CustomPageRoute(child: NewUsername()));
                              } else {}
                              print(
                                  "Forgot username request send to api with user info: ");
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
                                    fontFamily: 'Roboto-Regular',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
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
