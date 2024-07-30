import 'dart:convert';
import 'package:Seerecs/Screens/LoginScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/network/API_Services.dart';
import '../Assets/CustomPageRoute.dart';
import '../network/response_AlterBox.dart';
import '../Assets/UserModel.dart' as user;

class ForgotPasswordPg extends StatefulWidget {
  ForgotPasswordPg({super.key, required this.Mail});

  final String Mail;

  @override
  State<ForgotPasswordPg> createState() => _ForgotPasswordPgState();
}

class _ForgotPasswordPgState extends State<ForgotPasswordPg> {
  final _form = GlobalKey<FormState>(); //for storing form state.
  late TextEditingController _email = TextEditingController();

  // final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
  // final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);
  final PrimaryColor = Color(0xFFB5B4BD); // Color
  final SecondaryColor = Color(0xFF393939);

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
  }
  bool _isButtonPressed = false;
  Map<String, dynamic> passwordData() {
    return {(user.email): (_email.text.toLowerCase())};
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _form,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: true,
          right: true,
          left: true,
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.94,
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
                //alignment: Alignment.topCenter,
                children: [

                  Positioned(
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          //color: const Color(0xff333366),
                          //borderRadius:BorderRadius.all(Radius.elliptical(30, 30))
                          borderRadius: BorderRadius.all(Radius.circular(30.0.r)),
                          ),
                      constraints:
                          BoxConstraints(maxWidth: width*0.96, maxHeight: 350),
                    ),
                  ),


                  // Positioned(
                  //   top: 20,
                  //   left: 15,
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.arrow_back,
                  //       color: Colors.white,
                  //       size: 35,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.of(context).pop(LoginScreen());
                  //     }
                  //   ),
                  // ),
                  Positioned(
                    top: 5,
                    left: 40,
                    //height: 440,
                    height: MediaQuery.of(context).size.height / 2.6,
                    child: ClipRRect(
                      child: Image.asset("assets/dio-04 1.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context,
                        CustomPageRoute(child: LoginScreen())),
                    // onTap: () {
                    //   //Navigator.pop(context);
                    //   Navigator.pushReplacement(context, newRoute)
                    //   //_showAlertDialog(context);
                    // },
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
                    top: MediaQuery.of(context).size.height / 2.1,
                    //height: 100.0.h,

                    child: Container(
                      width: 430.0.w,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset(
                            //   "assets/Forget_password.png",
                            //   height: 280.0.h,
                            //   // width: 300.0.w,
                            // ),
                            // SizedBox(
                            //   height: 0.h,
                            // ),
                            Text(
                              'Forgot your password?',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF37304A)),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 25.0.h,
                            ),
                            // Text(
                            //   'Email',
                            //   style: const TextStyle(
                            //       fontSize: 17,
                            //       height: 1.5,
                            //       fontWeight: FontWeight.w500,
                            //       color: Color(0xFF393939)),
                            //   textAlign: TextAlign.left,
                            // ),

                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            // Column(
                            //   children: [
                            //     SizedBox(
                            //       height: 25.h,
                            //     ),
                            // Container(
                            //   height: 100.h,
                            //   width: double.infinity,
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       begin: Alignment.topRight,
                            //       end: Alignment.bottomLeft,
                            //       colors: [
                            //         PrimaryColor,
                            //         SecondaryColor,
                            //       ],
                            //     ),
                            //     borderRadius: BorderRadius.circular(15.r),
                            //     // color: Color.fromRGBO(24, 125, 203, 100),
                            //   ),
                            //   child: Card(
                            //     margin: EdgeInsets.all(3),
                            //     semanticContainer: true,
                            //     elevation: 15,
                            //     clipBehavior: Clip.antiAliasWithSaveLayer,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(15.r),
                            //     ),
                            //     child: Align(
                            //       alignment: Alignment.centerLeft,
                            //       child: Padding(
                            //         padding: EdgeInsets.all(0.0),
                            //         child: ListTile(
                            //           leading: Stack(
                            //             children: [
                            //               CircleAvatar(
                            //                 backgroundColor:
                            //                     Colors.blue[50],
                            //                 radius: 35.r,
                            //                 child: Icon(
                            //                   Icons.email,
                            //                   size: 30,
                            //                   color: Color.fromRGBO(
                            //                       24, 125, 203, 100),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),

                            TextFormField(
                              controller: _email,
                              // initialValue: widget.Mail,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    color: Color(0xFFB5B4BD),
                                ),
                                hintText: "Please enter email address",
                                labelStyle: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                    color: SecondaryColor),
                                labelText: 'Email(Username)',
                              ),
                              validator: (value) {
                                // add your custom validation here.
                                if ((value.toString().isEmpty)) {
                                  return 'Please enter valid email';
                                }
                                if (!RegExp(
                                    //r'^(?!.*\s)(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$'
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$'
                                        //"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]"
                                )
                                    .hasMatch(value!)) {
                                  return 'Please a valid Email';
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 40.h,
                            ),
                            InkWell(
                              onTapDown: (_) {
                                setState(() {
                                  _isButtonPressed = true;
                                });
                              },
                              onTapUp: (_) {
                                setState(() {
                                  _isButtonPressed = false;
                                });
                              },
                              onTap: () async {
                                _saveForm();
                                final isValid = _form.currentState!.validate();
                                if (isValid == true) {
                                  final api = ApiServices(Dio(), "/forgotPassword");
                                  final response =
                                      await api.ApiUser(passwordData(), context);
                                  print('response? status: ${response.statusCode}');
                                  print('response? body: ${response}');
                                  String decode = response.toString();
                                  Map<String, dynamic> res = jsonDecode(decode);
                                  print(res['success']);
                                  var check = res['success'];
                                  if (check == true) {
                                    CustomSnackBar(context,
                                        'Password reset link send to your mail');
                                  } else {}
                                  print(
                                      "Forgot password request send to api with user info: ");
                                  print(passwordData());
                                } else {}
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                //height: 45.h,
                                //width: double.infinity,
                                decoration: BoxDecoration(
                                  color: _isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                                  border: Border.all(color: Colors.white, width: 3),
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
                                      color: _isButtonPressed ? Color(0xFFB2A0FB) : Colors.white,
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
    );
  }
}
