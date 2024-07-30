// import 'package:Seerecs/Screens/ForgotPassword/VerificationCode.dart';
// import 'package:Seerecs/Screens/Home_Page.dart';
// import 'package:Seerecs/Screens/SignInScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:Seerecs/Assets/UserModel.dart';
// import 'package:Seerecs/iconform_icons.dart';
// import 'package:iconsax/iconsax.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:Seerecs/Screens/EmailOtpVerification.dart';
// import 'package:Seerecs/network/API_Services.dart';
// import 'package:intl/intl.dart';
// import '../Assets/CustomPageRoute.dart';
// import '../Assets/Messages.dart' as message;
// import '../Assets/UserModel.dart' as user;
// import 'package:dio/dio.dart';

// import '../network/response?_AlterBox.dart';

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _form = GlobalKey<FormState>(); //for storing form state.
//   bool isChecked =
//       false; // Boolean used to check if check box is checked or not
//   bool _pri_isObscure = false; //Boolean to check if eye icon tapped or not
//   bool _sec_isObscure = false; //Boolean to check if eye icon tapped or not
//   // late String value;

//   final PrimaryColor = Color.fromRGBO(103, 145, 133, 90); // Color
//   final SecondaryColor = Color.fromRGBO(27, 73, 78, 60); // Color

//   late TextEditingController _firstName =
//       TextEditingController(); // First name text field controller
//   late TextEditingController _lastName =
//       TextEditingController(); // Last name text field controller
//   late TextEditingController _dateOfBirth =
//       TextEditingController(); // Dob  text field controller
//   late TextEditingController _email =
//       TextEditingController(); // Email text field controller
//   late TextEditingController _alternateMail =
//       TextEditingController(); // Alternate mail text field controller
//   late TextEditingController _mobileNo =
//       TextEditingController(); // Mobile no. text field controller
//   late TextEditingController _alternateMobileNo =
//       TextEditingController(); // Alternate mobile no. text field controller
//   late TextEditingController _password =
//       TextEditingController(); // Password text field controller
//   late TextEditingController _confirmPassword =
//       TextEditingController(); // Confirm password text field controller
//   late TextEditingController _address =
//       TextEditingController(); // Address text field controller
//   late TextEditingController _city =
//       TextEditingController(); // City text field controller
//   late TextEditingController _zipCode =
//       TextEditingController(); // Zip code text field controller

//   // init state used for date picker
//   @override
//   void initState() {
//     _dateOfBirth.text = ""; //set the initial value of text field
//     super.initState();
//   }

//   // Making Json to be send to API
//   Map<String, dynamic> toJson() {
//     return {
//       (user.FirstName): (_firstName.text),
//       (user.LastName): (_lastName.text),
//       (user.Email): (_email.text.toLowerCase()),
//       (user.AlternateEmail): (_alternateMail.text.toLowerCase()),
//       (user.confirmPassword): (_confirmPassword.text),
//       (user.Mobile): (_mobileNo.text),
//       (user.AlternateMobile): (_alternateMobileNo.text),
//       (user.Address): (_address.text),
//       (user.City): (_city.text),
//       (user.Zipcode): (_zipCode.text),
//       (user.Dob): (_dateOfBirth.text),
//     };
//   }

//   final _pri_textFieldFocusNode =
//       FocusNode(); // Password field Obscure focus check
//   final _sec_textFieldFocusNode =
//       FocusNode(); // Password field Obscure focus check

//   // Checking if eye icon on password field is tapped and making field obscure on condition.
//   void _pri_toggleObscured() {
//     setState(() {
//       _pri_isObscure = !_pri_isObscure;
//       if (_pri_textFieldFocusNode.hasPrimaryFocus) return;
//       _pri_textFieldFocusNode.canRequestFocus = false;
//     });
//   }

//   // Checking if eye icon on confirm password field is tapped and making field obscure on condition.
//   void _sec_toggleObscured() {
//     setState(() {
//       _sec_isObscure = !_sec_isObscure;
//       if (_sec_textFieldFocusNode.hasPrimaryFocus) return;
//       _sec_textFieldFocusNode.canRequestFocus = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Form(
//         key: _form,
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: SafeArea(
//               child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 7),
//               borderRadius: BorderRadius.circular(30),
//               gradient: LinearGradient(
//                 colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(0.0.w, 0.0.h, 0.0.w, 0.0.h),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 20.0.h,
//                     ),
//                     Text(
//                       'Register Now',
//                       style: TextStyle(
//                           color: Color(0xFF37304A),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 25),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 60),
//                       child: Text(
//                         'Create a new account',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xFF737081),
//                           fontWeight: FontWeight.w500,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0.h,
//                     ),
//                     // FormTextField(
//                     //   controller: _email,
//                     //   hintText: 'username',
//                     //   keyboardType: TextInputType.emailAddress,
//                     //   obscureText: false,
//                     //   suffixIcon: Icon(
//                     //     Icons.person_outlined,
//                     //     color: Colors.grey,
//                     //   ),
//                     //   validator: (value) {
//                     //     if (value.toString().isEmpty) {
//                     //       return "Please enter Username";
//                     //     }
//                     //     return null;
//                     //   },
//                     // ),
//                     TextFormField(
//                       controller: _firstName,
//                       keyboardType: TextInputType.text,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: 'Username',
//                         hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
//                       ),
//                       // Validation will be done here
//                       validator: (value) {
//                         if (value.toString().isEmpty) {
//                           return "Please enter first name";
//                         }
//                         return null;
//                       },
//                     ),

//                     SizedBox(
//                       height: 10.0.h,
//                     ),
//                     // FormTextField(
//                     //   controller: _email,
//                     //   hintText: 'Email',
//                     //   keyboardType: TextInputType.emailAddress,
//                     //   obscureText: false,
//                     //   suffixIcon: Icon(
//                     //     Icons.mark_email_unread_outlined,
//                     //     color: Colors.grey,
//                     //   ),
//                     //   validator: (value) {
//                     //     // add your custom validation here.
//                     //     if ((value.toString().isEmpty)) {
//                     //       return 'Please enter email';
//                     //     }
//                     //     if (!RegExp(
//                     //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                     //         .hasMatch(value!)) {
//                     //       return 'Please enter valid email';
//                     //     }
//                     //     return null;
//                     //   },
//                     // ),

//                     TextFormField(
//                       controller: _email,
//                       keyboardType: TextInputType.emailAddress,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: 'Email',
//                         hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
//                       ),
//                       // Validation will be done here
//                       validator: (value) {
//                         // add your custom validation here.
//                         if ((value.toString().isEmpty)) {
//                           return 'Please enter email';
//                         }
//                         if (!RegExp(
//                                 r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                             .hasMatch(value!)) {
//                           return 'Please enter valid email';
//                         }
//                         return null;
//                       },
//                     ),

//                     SizedBox(
//                       height: 10.0.h,
//                     ),
//                     TextFormField(
//                       controller: _password,
//                       keyboardType: TextInputType.visiblePassword,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       obscureText: !_pri_isObscure,
//                       focusNode: _pri_textFieldFocusNode,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: 'Email',
//                         hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
//                         suffixIcon: GestureDetector(
//                           onTap: _pri_toggleObscured,
//                           child: Icon(
//                             _pri_isObscure
//                                 ? Icons.visibility_off_rounded // Eye icon
//                                 : Icons.visibility_rounded, // Eye icon
//                             size: 25.sp,
//                             // Color will be change if icon is tapped
//                             color: (_pri_isObscure == false)
//                                 ? PrimaryColor
//                                 : SecondaryColor,
//                           ),
//                         ),
//                       ),
//                       // Validation will be done here
//                       validator: (Value) {
//                         RegExp regex = RegExp(
//                             (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'));
//                         var passNonNullValue = Value ?? "";
//                         if (passNonNullValue.isEmpty) {
//                           return ("Please enter password");
//                         } else if (passNonNullValue.length < 6) {
//                           return ("Password should contain 6 character with capital,"
//                               '\n'
//                               "small letter & number & special");
//                         } else if (!regex.hasMatch(passNonNullValue)) {
//                           return ("Password should contain 6 character with capital,"
//                               '\n'
//                               "small letter & number & special");
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(
//                       height: 10.0.h,
//                     ),
//                     TextFormField(
//                       controller: _confirmPassword,
//                       keyboardType: TextInputType.visiblePassword,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       obscureText: !_sec_isObscure,
//                       focusNode: _sec_textFieldFocusNode,
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: 'Email',
//                         hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
//                         suffixIcon: GestureDetector(
//                           onTap: _sec_toggleObscured,
//                           child: Icon(
//                             _sec_isObscure
//                                 ? Icons.visibility_off_rounded // Eye icon
//                                 : Icons.visibility_rounded, // Eye icon
//                             size: 25.sp,
//                             // Color will be change if icon is tapped
//                             color: (_sec_isObscure == false)
//                                 ? PrimaryColor
//                                 : SecondaryColor,
//                           ),
//                         ),
//                       ),
//                       // Validation will be done here
//                       validator: (value) {
//                         if (value.toString().isEmpty) {
//                           return "Please re-enter password";
//                         } else if (value.toString().length < 6) {
//                           return "Password must be more than 5 characters";
//                         } else if (_confirmPassword.text != _password.text) {
//                           return "Password must be same as above";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: 15.0.h,
//                     ),

//                     InkWell(
//                       onTap: () async {
//                         // Checking if all validation is done or not.
//                         final isValid = _form.currentState!.validate();
//                         if (isValid == true && isChecked == true) {
//                           // Api call here
//                           final api = ApiServices(Dio(), "/register");
//                           // Will get response? of api.
//                           final response? = await api.ApiUser(toJson(), context);

//                           // Printing response? and status code here
//                           print('response? status: ${response?.statusCode}');
//                           print('response? body: ${response?}');

//                           // Converting api json response? to string.
//                           String decode = response?.toString();
//                           Map<String, dynamic> res = jsonDecode(decode);
//                           print(res['success']);
//                           var check = res['success'];

//                           //If message from api is true then will navigate to Email Otp page.
//                           if (check == true) {
//                             Navigator.pushReplacement(
//                                 context,
//                                 CustomPageRoute(
//                                     child: EmailOtpVerification(
//                                         Email: _email.text)));
//                           } else {}
//                           // Printing json data which is provided to api
//                           print("register request send to api with user info: ");
//                           print(toJson());
//                         } else {}
//                       },
//                       child: Container(
//                         //padding: EdgeInsets.all(20),
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 15,
//                         ),
//                         decoration: BoxDecoration(
//                             color: Color(0xFFB2A0FB),
//                             border: Border.all(color: Colors.white, width: 3),
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Center(
//                           child: Text(
//                             'Sign In',
//                             style: TextStyle(
//                                 height: 3,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 10.0.h,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white, width: 3),
//                             borderRadius: BorderRadius.circular(8),
//                             color: Color(0xFFEEF0F7),
//                           ),
//                           child: Image.asset(
//                             'assets/google.png',
//                             height: 25.0.h,
//                             width: 50.0.w,
//                           ),
//                         ),
//                         SizedBox(width: 25),
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white, width: 3),
//                             borderRadius: BorderRadius.circular(8),
//                             color: Color(0xFFEEF0F7),
//                           ),
//                           child: Image.asset(
//                             'assets/apple.png',
//                             height: 25.0.h,
//                             width: 50.0.w,
//                           ),
//                         ),
//                         SizedBox(width: 25.0.h),
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white, width: 3),
//                             borderRadius: BorderRadius.circular(8),
//                             color: Color(0xFFEEF0F7),
//                           ),
//                           child: Image.asset(
//                             'assets/facebook.png',
//                             height: 25.0.h,
//                             width: 50.0.w,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0.h),

//                     // not a member? register now
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Already have an account?',
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(width: 4.0.w),
//                         const Text(
//                           'Login',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:Seerecs/Assets/CustomPageRoute.dart';
// import 'package:Seerecs/Screens/EmailOtpVerification.dart';
// import 'package:Seerecs/network/API_Services.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../Assets/Messages.dart' as message;
// import '../Assets/UserModel.dart' as user;
// import 'package:Seerecs/network/response?_AlterBox.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _form = GlobalKey<FormState>();
//   bool _pri_isObscure = false;
//   bool _sec_isObscure = false;

//   final primaryColor = Color.fromRGBO(23, 34, 22, 90);

//   late TextEditingController _firstName =
//       TextEditingController(); // First name text field controller
//   late TextEditingController _lastName =
//       TextEditingController(); // Last name text field controller
//   late TextEditingController _dateOfBirth =
//       TextEditingController(); // Dob  text field controller
//   late TextEditingController _email =
//       TextEditingController(); // Email text field controller
//   late TextEditingController _alternateMail =
//       TextEditingController(); // Alternate mail text field controller
//   late TextEditingController _mobileNo =
//       TextEditingController(); // Mobile no. text field controller
//   late TextEditingController _alternateMobileNo =
//       TextEditingController(); // Alternate mobile no. text field controller
//   late TextEditingController _password =
//       TextEditingController(); // Password text field controller
//   late TextEditingController _confirmPassword =
//       TextEditingController(); // Confirm password text field controller
//   late TextEditingController _address =
//       TextEditingController(); // Address text field controller
//   late TextEditingController _city =
//       TextEditingController(); // City text field controller
//   late TextEditingController _zipCode =
//       TextEditingController();

//   Map<String, dynamic> toJson() {
//     return {
//       (user.FirstName): (_firstName.text),
//       (user.LastName): (_lastName.text),
//       (user.Email): (_email.text.toLowerCase()),
//       (user.AlternateEmail): (_alternateMail.text.toLowerCase()),
//       (user.confirmPassword): (_confirmPassword.text),
//       (user.Mobile): (_mobileNo.text),
//       (user.AlternateMobile): (_alternateMobileNo.text),
//       (user.Address): (_address.text),
//       (user.City): (_city.text),
//       (user.Zipcode): (_zipCode.text),
//       (user.Dob): (_dateOfBirth.text),
//     };
//   }

//   final _pri_textFieldFocusNode = FocusNode();
//   final _sec_textFieldFocusNode = FocusNode();

//   void _pri_toggleObscured() {
//     setState(() {
//       _pri_isObscure = !_pri_isObscure;
//       if (_pri_textFieldFocusNode.hasPrimaryFocus) return;
//       _pri_textFieldFocusNode.canRequestFocus = false;
//     });
//   }

//   void _sec_toggleObscured() {
//     setState(() {
//       _sec_isObscure = !_sec_isObscure;
//       if (_sec_textFieldFocusNode.hasPrimaryFocus) return;
//       _sec_textFieldFocusNode.canRequestFocus = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _form,
//         child: Scaffold(
//           body: SafeArea(
//               child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 7),
//               borderRadius: BorderRadius.circular(30),
//               gradient: LinearGradient(
//                 colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(15.0.w, 0.0.h, 15.0.w, 0.0.h),
//                 child: ListView(
//                   children: [
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Sized Box used for vertical & horizontal padding between widgets
//                           SizedBox(
//                             height: 20.0.h,
//                           ),
//                           Center(
//                             child: Text(
//                               'Register Now',
//                               style: TextStyle(
//                                   color: Color(0xFF37304A),
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 25),
//                             ),
//                           ),

//                           Center(
//                             child: Text(
//                               'Create a new account',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Color(0xFF737081),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),

//                           SizedBox(
//                             height: 10.0.h,
//                           ),

//                           TextFormField(
//                             controller: _username,
//                             keyboardType: TextInputType.text,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                   borderRadius: BorderRadius.circular(10)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               fillColor: Colors.white,
//                               filled: true,
//                               hintStyle: TextStyle(
//                                 fontFamily: 'Roboto-Regular',
//                                 color: primaryColor,
//                               ),
//                               hintText: 'Username',
//                               labelStyle: TextStyle(
//                                   fontFamily: 'Roboto-Regular',
//                                   color: primaryColor),
//                             ),
//                             validator: (value) {
//                               if (value.toString().isEmpty) {
//                                 return "Please enter first name";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),

//                           TextFormField(
//                             controller: _email,
//                             keyboardType: TextInputType.emailAddress,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                   borderRadius: BorderRadius.circular(10)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               fillColor: Colors.white,
//                               filled: true,
//                               hintStyle: TextStyle(
//                                 fontFamily: 'Roboto-Regular',
//                                 color: primaryColor,
//                               ),
//                               hintText: message.email,
//                               labelStyle: TextStyle(
//                                   fontFamily: 'Roboto-Regular',
//                                   color: primaryColor),
//                             ),
//                             validator: (value) {
//                               // add your custom validation here.
//                               if ((value.toString().isEmpty)) {
//                                 return 'Please enter email';
//                               }
//                               if (!RegExp(
//                                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                   .hasMatch(value!)) {
//                                 return 'Please enter valid email';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),

//                           TextFormField(
//                             controller: _password,
//                             keyboardType: TextInputType.visiblePassword,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             obscureText: !_pri_isObscure,
//                             focusNode: _pri_textFieldFocusNode,
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                   borderRadius: BorderRadius.circular(10)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               fillColor: Colors.white,
//                               filled: true,
//                               hintStyle: TextStyle(
//                                 fontFamily: 'Roboto-Regular',
//                                 color: primaryColor,
//                               ),
//                               hintText: message.email,
//                               labelStyle: TextStyle(
//                                   fontFamily: 'Roboto-Regular',
//                                   color: primaryColor),
//                               suffixIcon: GestureDetector(
//                                 onTap: _pri_toggleObscured,
//                                 child: Icon(
//                                   _pri_isObscure
//                                       ? Icons.visibility_off_rounded // Eye icon
//                                       : Icons.visibility_rounded, // Eye icon
//                                   size: 25.sp,
//                                   // Color will be change if icon is tapped
//                                   color: (_pri_isObscure == false)
//                                       ? primaryColor
//                                       : primaryColor,
//                                 ),
//                               ),
//                             ),
//                             validator: (Value) {
//                               RegExp regex = RegExp(
//                                   (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'));
//                               var passNonNullValue = Value ?? "";
//                               if (passNonNullValue.isEmpty) {
//                                 return ("Please enter password");
//                               } else if (passNonNullValue.length < 6) {
//                                 return ("Password should contain 6 character with capital,"
//                                     '\n'
//                                     "small letter & number & special");
//                               } else if (!regex.hasMatch(passNonNullValue)) {
//                                 return ("Password should contain 6 character with capital,"
//                                     '\n'
//                                     "small letter & number & special");
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             controller: _confirmpassword,
//                             keyboardType: TextInputType.visiblePassword,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             obscureText: !_sec_isObscure,
//                             focusNode: _sec_textFieldFocusNode,
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                   borderRadius: BorderRadius.circular(10)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               fillColor: Colors.white,
//                               filled: true,
//                               hintStyle: TextStyle(
//                                 fontFamily: 'Roboto-Regular',
//                                 color: primaryColor,
//                               ),
//                               hintText: message.email,
//                               labelStyle: TextStyle(
//                                   fontFamily: 'Roboto-Regular',
//                                   color: primaryColor),
//                               suffixIcon: GestureDetector(
//                                 onTap: _sec_toggleObscured,
//                                 child: Icon(
//                                   _sec_isObscure
//                                       ? Icons.visibility_off_rounded // Eye icon
//                                       : Icons.visibility_rounded, // Eye icon
//                                   size: 25.sp,
//                                   // Color will be change if icon is tapped
//                                   color: (_sec_isObscure == false)
//                                       ? primaryColor
//                                       : primaryColor,
//                                 ),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value.toString().isEmpty) {
//                                 return "Please re-enter password";
//                               } else if (value.toString().length < 6) {
//                                 return "Password must be more than 5 characters";
//                               } else if (_confirmpassword.text !=
//                                   _password.text) {
//                                 return "Password must be same as above";
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),

//                           InkWell(
//                             onTap: () async {
//                               final isValid = _form.currentState!.validate();
//                               if (isValid == true) {
//                                 final api = ApiServices(Dio(), "/register");
//                                 final response? =
//                                     await api.ApiUser(toJson(), context);

//                                 print(
//                                     'response? status: ${response?.statusCode}');
//                                 print('response? body: ${response?}');

//                                 String decode = response?.toString();
//                                 Map<String, dynamic> res = jsonDecode(decode);
//                                 print(res['success']);
//                                 var check = res['success'];

//                                 if (check == true) {
//                                   Navigator.pushReplacement(
//                                       context,
//                                       CustomPageRoute(
//                                           child: EmailOtpVerification(
//                                               Email: _email.text)));
//                                 } else {}

//                                 print(
//                                     "register request send to api with user info: ");
//                                 print(toJson());
//                               } else {}
//                             },
//                             child: Container(
//                               margin: EdgeInsets.symmetric(
//                                 horizontal: 15,
//                               ),
//                               decoration: BoxDecoration(
//                                   color: Color(0xFFB2A0FB),
//                                   border:
//                                       Border.all(color: Colors.white, width: 3),
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: Center(
//                                 child: Text(
//                                   'Sign Up',
//                                   style: TextStyle(
//                                       height: 3,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ])
//                   ],
//                 ),
//               ),
//             ),
//           )),
//         ));
//   }
// }
