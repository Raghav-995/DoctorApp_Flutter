import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Screens/BottomNavigation.dart';
import 'package:Seerecs/Screens/EmailOtpVerification.dart';
import 'package:Seerecs/Screens/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/Screens/AppPreferences.dart';
import '../network/API_Services.dart';
import '../Assets/CustomPageRoute.dart';
import '../network/response_AlterBox.dart';
import 'RegisterPage.dart';
import '../Assets/UserModel.dart' as user;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// late var finalToken; // variable to store token which will get from api in login page
// int? OnboardingInt;
// int? isStreamLine;
// Future respectiveNavigation(context) {
//   return isStreamLine == 1
//       ? Navigator.pushReplacement(
//           context, CustomPageRoute(child: (StreamLinePreferences())))
//       : Navigator.pushReplacement(
//           context,
//           CustomPageRoute(
//               child:
//                   (finalToken == null ? LoginScreen() : BottomNavigation())));
// }

class LoginScreen extends StatefulWidget {
  late final String? email;

  LoginScreen({super.key, this.email});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final form = GlobalKey<FormState>(); //for storing form state.

  TextEditingController emailController =
      TextEditingController(); // Email Controller
  TextEditingController passwordController =
      TextEditingController(); //Password controller
  final textFieldFocusNode = FocusNode(); // Password field Obscure focus check
  bool _isObscure = false; //Boolean to check if eye icon tapped or not

  final primaryColor = Color(0xFFB5B4BD); // Color
  final secondaryColor = Color(0xFF393939);

  // Making Json to be send to API
  Map<String, dynamic> loginData() {
    return {
      (user.email): (emailController.text.toLowerCase()),
      //(user.Email): (widget.Email?.toLowerCase()),
      (user.confirmPassword): (passwordController.text),
      //(user.ProfilePicture): _imagePath.isNotEmpty ? _imagePath : null,
      //(user.profilePicture): _imagePath,
    };
  }
//late final String
  //Email;
  Map<String, dynamic> resendOtpToJson() {
    return {
      //(user.Email): (widget.Email),
      (user.email): (emailController.text.toLowerCase()),
    };
  }

//   late SharedPreferences logindata;
//   late bool emailnew;

//   late bool userIsLoggedIn;

//  getLoggedInState() async {
//    await Helper.getUserLoggedInSharedPreference().then((value) {
//      setState(() {
//        userIsLoggedIn = value!;
//      });
//    });
//  }
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    // getValidationData().whenComplete(() async {
    // Timer(
    //   Duration(milliseconds: 2500),
    //   () => respectiveNavigation(context),
    // );
    // });
    controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
  }

  //@override
  //void initState() {
  // getValidationData().whenComplete(() async {
  // Timer(
  //   Duration(milliseconds: 2500),
  //   () => respectiveNavigation(context),
  // );
  // });
  // _controller = AnimationController(
  //     duration: Duration(milliseconds: 150),
  // vsync: this,
  // );
  // super.initState();

  //  getLoggedInState();
  //  Timer(
  //    Duration(seconds: 3),
  //    () => Navigator.pushReplacement(
  //      context,
  //      MaterialPageRoute(
  //          builder: (context) => userIsLoggedIn != null
  //              ? userIsLoggedIn
  //                  ? BottomNavigation()
  //                  : LoginScreen()
  //              : LoginScreen()),
  //    ),
  //  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // regular expression to check if string
  RegExp pass_valid =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#/$&*~]).{6,20}$');
  double password_strength = 0;

  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  // Checking if eye icon on password field is tapped and making field obscure on condition.
  void _toggleObscured() {
    setState(() {
      _isObscure = !_isObscure;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  // Future getValidationData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   // Token from api will be stored in obtainedToken variable.
  //   var obtainedToken = sharedPreferences.get('token');
  //   setState(() {
  //     finalToken = obtainedToken;
  //   });
  //   print(finalToken);

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   isStreamLine = await preferences.getInt('StreamLine');
  //   print(isStreamLine);
  // }
  bool isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    EdgeInsets devicepadding = MediaQuery.of(context).viewPadding;
    // Form widget used for validation purpose.
    return WillPopScope(
        onWillPop: () => backButton(context),
        child: Padding(
          padding: devicepadding,
          child: Form(
            key: form,
            //Scaffold Contains all the widgets, AppBar, body, bottom navigation bar
            child: Scaffold(
              backgroundColor: Colors.white,
              // Safe area will keep screen under notification panel
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 7),
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                // Center widget used for all widget will appear in center
                child: Center(
                  //Padding to all widgets from all sides
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.0.w, 0.0.h, 15.0.w, 0.0.h),
                    // All widgets will bw in list view.
                    child: ListView(children: [
                      // Colunm used to align all widgets in vertical format
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0.h,
                          ),
                          // Text widget used to display any text on screen
                          Center(
                            child: Text(
                              'Hello Again!',
                              style: TextStyle(
                                  color: Color(0xFF37304A),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.sp),
                            ),
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          Center(
                            child: Text(
                              'Welcome back you’ve \nbeen missed!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF737081),
                                fontWeight: FontWeight.w500,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 30.h,
                          ),
                          // Text widget used to display any text on screen

                          //TextFormField used to get text input from user.
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            //autofocus: false,
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
                                  color: primaryColor),
                              hintText: "Please enter email(username)",
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: secondaryColor),
                              labelText: 'Email(Username)',
                            ),
                            // decoration: InputDecoration(
                            //   enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.white),
                            //       borderRadius: BorderRadius.circular(10)),
                            //   focusedBorder: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.white),
                            //   ),
                            //   fillColor: Colors.white,
                            //   filled: true,
                            //   hintText: 'Email',//email address
                            //   hintStyle:
                            //       TextStyle(color: Colors.grey, fontSize: 15.sp),
                            // ),
                            // Validation process
                            validator: (value) {
                              // add your custom validation here.
                              if ((value.toString().isEmpty)) {
                                return 'Please enter valid email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$'
                                      // "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]"
                                      )
                                  .hasMatch(value!)) {
                                return 'Please enter a valid Email';
                              }
                              return null;
                            },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 20.h,
                          ),
                          // Text widget used to display any text on screen

                          //TextFormField used to get text input from user.
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: !_isObscure,
                            autofocus: false,
                            focusNode: textFieldFocusNode,
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
                                  color: primaryColor),
                              hintText: "Please enter password",
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: secondaryColor),
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
                            onChanged: (value) {
                              form.currentState!.validate();
                            },
                            // Validation of password.
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              } else if (value.length < 6) {
                                return ("Password should contain 6 character with capital,"
                                    '\n'
                                    "small letter & number & special");
                              } else {
                                //call function to check password
                                bool result = validatePassword(value);
                                if (result) {
                                  // create account event
                                  return null;
                                } else {
                                  return "Password should contain 6 character with capital,"
                                      '\n'
                                      "small letter & number & special";
                                }
                              }
                            },
                          ),

                          SizedBox(
                            height: 10.0.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacement(
                                      context,
                                      CustomPageRoute(
                                          child: ForgotPasswordPg(
                                        Mail: '',
                                      ))),
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
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
                            // onTap: () async {
                            //   //setLoggedInStatus(true);
                            //   // Checking if all validation is done or not.
                            //   final isValid = _form.currentState!.validate();
                            //   // If all fields validated then it will call api
                            //   if (isValid == true) {
                            //     // Api call here
                            //     final api = ApiServices(Dio(), "/login");
                            //     // Will get response? of api.
                            //     final response? =
                            //     await api.ApiUser(toJson(), context);
                            //     // Printing response? and status code here
                            //     print('response? status: ${response?
                            //         .statusCode}');
                            //     print('response? body: ${response?}');
                            //     print(
                            //         'response? headers: ${response?
                            //             .headers[HttpHeaders
                            //             .authorizationHeader]}');
                            //     // Converting api json response? to Map string.
                            //     String decoderesponse? = response?.toString();
                            //     Map<String, dynamic> res =
                            //     jsonDecode(decoderesponse?);
                            //     res['token'] =
                            //     '${response?.headers[HttpHeaders
                            //         .authorizationHeader]}';
                            //     late var token = res['token'];
                            //     token = token.substring(1, token.length - 1);
                            //
                            //     print(token);
                            //     // Shared preferences used here so we can store token which will get from api.
                            //     SharedPreferences sharedPreferences =
                            //     await SharedPreferences.getInstance();
                            //     sharedPreferences.setString('token', token);
                            //
                            //     // Shared preferences used here so we can store date which will get from api.
                            //     res['userMail'] = emailController.text;
                            //     late var userMail = res['userMail'];
                            //     SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            //     prefs.setString('userMail', userMail);
                            //     print(userMail);
                            //     //userdata
                            //     // late var firstName = res['firstName'];
                            //     // await SharedPreferences.getInstance();
                            //     // prefs.setString('firstName', firstName);
                            //     // print(firstName);
                            //     // late var lastName = res['lastName'];
                            //     // await SharedPreferences.getInstance();
                            //     // prefs.setString('lastName', lastName);
                            //     // print(lastName);
                            //     // late var city = res['city'];
                            //     // await SharedPreferences.getInstance();
                            //     // prefs.setString('city', city);
                            //     // print(city);
                            //     //If status code is 200 then will navigate to Welcome page.
                            //     if (response?.statusCode == 200) {
                            //
                            //       // Check if the response? contains a success message
                            //       if (res.containsKey('response?') &&
                            //           res['response?']['success'] == true) {
                            //         // Extract user information from the nested 'user' object
                            //         Map<String, dynamic> userData = res['response?']['user'];
                            //         String firstName = userData['firstName'] ?? '';
                            //         String lastName = userData['lastName'] ?? '';
                            //         String email = userData['email'] ?? '';
                            //         String city = userData['city'] ?? '';
                            //         String zipcode = userData['zipcode'] ?? '';
                            //         String dob = userData['dob'] ?? '';
                            //         String address = userData['address'] ?? '';
                            //         String phone = userData['phone'] ?? '';
                            //         String gender = userData['gender'] ?? '';
                            //         print('Debug: FirstName: $firstName');
                            //         print('Debug: LastName: $lastName');
                            //         print('Debug: Email: $email');
                            //         print('Debug: City: $city');
                            //         print('Debug: Zipcode: $zipcode');
                            //         print('Debug: Date of Birth: $dob');
                            //         print('Debug: Address: $address');
                            //         print('Debug: Phone: $phone');
                            //         print('Debug: gender: $gender');
                            //         // Store user data in SharedPreferences
                            //         SharedPreferences prefs = await SharedPreferences
                            //             .getInstance();
                            //         prefs.setString('firstName', firstName);
                            //         prefs.setString('lastName', lastName);
                            //         prefs.setString('city', city);
                            //         prefs.setString('zipcode', zipcode);
                            //         prefs.setString('email', email);
                            //         prefs.setString('dob', dob);
                            //         prefs.setString('address', address);
                            //         prefs.setString('phone', phone);
                            //         prefs.setString('gender', gender);
                            //
                            //
                            //         CustomSnackBar(
                            //             context, 'User Sign In Successfully');
                            //         int StreamLine = 1;
                            //         SharedPreferences preferences =
                            //         await SharedPreferences.getInstance();
                            //         await preferences.setInt(
                            //             'StreamLine', StreamLine);
                            //
                            //         int? isStreamLine;
                            //         // SharedPreferences prefs =
                            //         // await SharedPreferences.getInstance();
                            //         isStreamLine =
                            //         await prefs.getInt("streamLine");
                            //         await prefs.setInt("streamLine", 1);
                            //         print('streamLine : ${isStreamLine}');
                            //
                            //         //hhhh
                            //
                            //
                            //         if (isStreamLine == 1) {
                            //           Navigator.of(context).pushReplacement(
                            //               CustomPageRoute(
                            //                   child: BottomNavigation()));
                            //         }
                            //         else {
                            //           await prefs.setInt('streamLine', 0);
                            //           Navigator.of(context).pushReplacement(
                            //               CustomPageRoute(
                            //                   child: StreamLinePreferences()));
                            //         }
                            //       }
                            //       else if (response?.statusCode == 203) {
                            //         _showAlertDialog(context);
                            //         // print('Resend button pressed');
                            //         // ResendOtpApiCall(); // Resend otp api call here
                            //         // print('OTP sent to following mail');
                            //         // print(widget.Email);
                            //       }
                            //       //else if(response?.statusCode == 401 && )
                            //
                            //       // Printing json data which is provided to api
                            //       print(
                            //           "login request send to api with user info: ");
                            //       print(toJson());
                            //     }
                            //   }
                            //
                            // },
                            onTap: () async {
                              // Checking if all validation is done or not.
                              final isValid = form.currentState!.validate();
                              // If all fields validated then it will call api
                              if (isValid == true) {
                                // Api call here
                                final api = ApiServices(Dio(), "/login");
                                // Will get response? of api.
                                final response =
                                await api.ApiUser(loginData(), context);
                                // Printing response? and status code here
                                print(
                                    'response? status: ${response.statusCode}');
                                print('response? body: ${response}');
                                print(
                                    'response? headers: ${response.headers[HttpHeaders.authorizationHeader]}');
                                // Converting api json response? to Map string.
                                String decoderesponse = response.toString();
                                Map<String, dynamic> res =
                                jsonDecode(decoderesponse);
                                res['token'] =
                                '${response.headers[HttpHeaders.authorizationHeader]}';
                                late var token = res['token'];
                                token = token.substring(1, token.length - 1);
                                print("the token is $token");
                                // Shared preferences used here so we can store token which will get from api.
                                SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                                sharedPreferences.setString('token', token);

                                // Shared preferences used here so we can store date which will get from api.
                                res['userMail'] = emailController.text;
                                late var userMail = res['userMail'];
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.setString('userMail', userMail);
                                print(userMail);

                                //If status code is 200 then will navigate to Welcome page.
                                if (response.statusCode == 200) {
                                  if (res.containsKey('response') &&
                                      res['response']['success'] == true) {
                                    // Extract user information from the nested 'user' object
                                    Map<String,
                                        dynamic> userData = res['response']['user'];
                                    String firstName = userData['firstName'] ??
                                        '';
                                    String lastName = userData['lastName'] ??
                                        '';
                                    String email = userData['email'] ?? '';
                                    String city = userData['city'] ?? '';
                                    String zipcode = userData['zipcode'] ?? '';
                                    String dob = userData['dob'] ?? '';
                                    String address = userData['address'] ?? '';
                                    String phone = userData['phone'] ?? '';
                                    String gender = userData['gender'] ?? '';
                                    print('Debug: FirstName: $firstName');
                                    print('Debug: LastName: $lastName');
                                    print('Debug: Email: $email');
                                    print('Debug: City: $city');
                                    print('Debug: Zipcode: $zipcode');
                                    print('Debug: Date of Birth: $dob');
                                    print('Debug: Address: $address');
                                    print('Debug: Phone: $phone');
                                    print('Debug: gender: $gender');
                                    // Store user data in SharedPreferences
                                    SharedPreferences prefs = await SharedPreferences
                                        .getInstance();
                                    prefs.setString('firstName', firstName);
                                    prefs.setString('lastName', lastName);
                                    prefs.setString('city', city);
                                    prefs.setString('zipcode', zipcode);
                                    prefs.setString('email', email);
                                    prefs.setString('dob', dob);
                                    prefs.setString('address', address);
                                    prefs.setString('phone', phone);
                                    prefs.setString('gender', gender);
                                    CustomSnackBar(
                                        context, 'User Sign In Successfully');
                                    int StreamLine = 1;
                                    SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                    await preferences.setInt(
                                        'StreamLine', StreamLine);

                                    int? isStreamLine;
                                    // SharedPreferences prefs =
                                    //     await SharedPreferences.getInstance();
                                    isStreamLine =
                                    await prefs.getInt("streamLine");
                                    await prefs.setInt("streamLine", 1);
                                    print('streamLine : ${isStreamLine}');
                                    if (isStreamLine == 1) {
                                      Navigator.of(context).pushReplacement(
                                          CustomPageRoute(
                                              child: BottomNavigation()));
                                    } else {
                                      await prefs.setInt('streamLine', 0);
                                      Navigator.of(context).pushReplacement(
                                          CustomPageRoute(
                                              child: StreamLinePreferences()));
                                    }
                                  }
                                }
                                  else if (response.statusCode == 203) {
                                    showAlertDialog(context);
                                    // print('Resend button pressed');
                                    // ResendOtpApiCall(); // Resend otp api call here
                                    // print('OTP sent to following mail');
                                    // print(widget.Email);
                                  }
                                  //       else {}
                                  // Printing json data which is provided to api
                                  print(
                                      "login request send to api with user info: ");
                                  print(loginData());
                                }

                            },
                            //tryAutoLogin();
                            //_controller.forward();
                            //     Future.delayed(Duration(milliseconds: 60), () {
                            //       _controller.reverse();
                            //     });
                            //     print('Shrink');
                            //
                            //   },
                            //   // here Container is used to make a button.
                            // child: ScaleTransition(
                            //   scale: Tween<double>(
                            //     begin: 1.0,
                            //     end: 0.3,
                            //   ).animate(_controller),

                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              height: 45.h,
                              //width: double.infinity,
                              decoration: BoxDecoration(
                                color: isButtonPressed
                                    ? Colors.white
                                    : Color(0xFFB2A0FB),
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                // Text widget used to display any text on screen
                                child: Text(
                                  "Sign In",
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
                              )
                            )
                          ),

                          SizedBox(
                            height: 25.0.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 2.0.h,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                            Color(0xFFEEF0F7),
                                            Colors.grey
                                          ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'or continue with',
                                    style: TextStyle(
                                      color: Color(0xFF737081),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 2.0.h,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFEEF0F7),
                                          Colors.grey
                                        ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFEEF0F7),
                                ),
                                child: Image.asset(
                                  'assets/google.png',
                                  height: 25.0.h,
                                  width: 50.0.w,
                                ),
                              ),
                              SizedBox(width: 25),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFEEF0F7),
                                ),
                                child: Image.asset(
                                  'assets/apple.png',
                                  height: 25.0.h,
                                  width: 50.0.w,
                                ),
                              ),
                              SizedBox(width: 25.0.h),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFEEF0F7),
                                ),
                                child: Image.asset(
                                  'assets/facebook.png',
                                  height: 25.0.h,
                                  width: 50.0.w,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0.h),

                          // not a member? register now
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Not a member?',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.0.w),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacement(context,
                                    CustomPageRoute(child: RegisterPage())),
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(
                                    color: Color(0xFF2A77DB),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

//Unhandled Exception: DioError [DioErrorType.response?]: Http status error [401]
  resendOtpApiCall() async {
    // Api call here
    final api = ApiServices(Dio(), "/resendOTP");
    //Will get api response? here
    final response = await api.ApiUser(resendOtpToJson(), context);
    // response? and status code will be print
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');
    //Decoding response? from json to mao string
    String decode = response.toString();
    Map<String, dynamic> res = jsonDecode(decode);
    print(res['success']);
    // if success message is true then dialog box will pop
    // Dialog box with message "OTP sent to your mail".
    var check = res['success'];
    if (check == true) {
      showCustomDialog(context, 'Message', res['message']);
      Navigator.pushReplacement(
          context,
          CustomPageRoute(
              child: EmailOtpVerification(email: emailController.text)));
    }
  }

  Future<bool> tryAutoLogin() async {
    var any = await SharedPreferences.getInstance();
    if (!any.containsKey('userMail')) {
      return false;
    } else {
      // final extractedUserData =
      //     json.decode(any.getString('userData').toString());

      // print(extractedUserData['user_id']);
      // print(extractedUserData['user_token']);

      return true;
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("User Not Verified,Please Verify Now"),
            backgroundColor: Color(0xFFB2A0FB),
            actions: [
              TextButton(
                onPressed: () {
                  print('Resend button pressed');
                  resendOtpApiCall(); // Resend otp api call here
                  print('OTP sent to following mail');
                  //print(widget.Email);
                  print(emailController.text.toLowerCase());
                },
                child: Text(
                  'verify',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              )
            ],
          );
        });
  }

  Future<bool> backButton(BuildContext context) async {
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFB2A0FB),
            //title: Text("Really"),
            content: Text(
              "Do you want to close the app",
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ))
            ],
          );
        });
    return exitApp;
  }
}

