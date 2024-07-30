import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Seerecs/Screens/EmailOtpVerification.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:intl/intl.dart';
import '../Assets/CustomPageRoute.dart';
import '../Assets/Messages.dart' as message;
import '../Assets/UserModel.dart' as user;
import 'package:dio/dio.dart';
//import 'package:email_validator/email_validator.dart';

import '../network/response_AlterBox.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //late AnimationController _controller;
  final _form = GlobalKey<FormState>(); //for storing form state.
  bool isChecked =
      false; // Boolean used to check if check box is checked or not
  bool _pri_isObscure = false; //Boolean to check if eye icon tapped or not
  bool _sec_isObscure = false; //Boolean to check if eye icon tapped or not
  // late String value;

  final PrimaryColor = Color.fromRGBO(103, 145, 133, 90); // Color
  final SecondaryColor = Color.fromRGBO(27, 73, 78, 60); // Color

  late TextEditingController _firstName =
      TextEditingController(); // First name text field controller
  late TextEditingController _lastName =
      TextEditingController(); // Last name text field controller
  late TextEditingController _dateOfBirth =
      TextEditingController(); // Dob  text field controller
  late TextEditingController _email =
      TextEditingController(); // Email text field controller
  // late TextEditingController _alternateMail =
  //     TextEditingController(); // Alternate mail text field controller
  late TextEditingController _mobileNo =
      TextEditingController(); // Mobile no. text field controller
  // late TextEditingController _alternateMobileNo =
  //     TextEditingController(); // Alternate mobile no. text field controller
  late TextEditingController _password =
      TextEditingController(); // Password text field controller
  late TextEditingController _confirmPassword =
      TextEditingController(); // Confirm password text field controller
  late TextEditingController _address =
      TextEditingController(); // Address text field controller
  late TextEditingController _city =
      TextEditingController(); // City text field controller
  late TextEditingController _zipCode =
      TextEditingController(); // Zip code text field controller

  // init state used for date picker
  @override
  void initState() {
    _dateOfBirth.text = ""; //set the initial value of text field
    super.initState();
    // _controller = AnimationController(
    //   duration: Duration(milliseconds: 150),
    //   vsync: this,
    //
    // );
    // _controller.addListener(() {
    //   setState(() {});
    // });

  }
  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }
  bool isButtonPressed = false;

  // Making Json to be send to API
  Map<String, dynamic> registerData() {
    return {
      (user.firstName): (_firstName.text),
      (user.lastName): (_lastName.text),
      (user.email): (_email.text.toLowerCase()),
      //(user.AlternateEmail): (_alternateMail.text.toLowerCase()),
      (user.confirmPassword): (_confirmPassword.text),
      (user.mobile): (_mobileNo.text),
      //(user.AlternateMobile): (_alternateMobileNo.text),
      (user.address): (_address.text),
      (user.city): (_city.text),
      (user.zipCode): (_zipCode.text),
      (user.dob): (_dateOfBirth.text),
    };
  }

  static final RegExp nameRegExp = RegExp(r"^[_A-zA-Z]*((-|\s)*[_A-zA-Z])*$/g");
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

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;
    //final double itemHeight = (size.height) / 5;
    // Form widget used for validation purpose.
    return WillPopScope(
      onWillPop: () => _backButton(context),
      child: Padding(
        padding: devicePadding,
        child: Form(
          key: _form,
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
                // Padding provided to all widgets.
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0.w, 0.0.h, 20.0.w, 0.0.h),
                  // All widgets will bw in list view.
                  child: ListView(
                    children: [
                      // Column used to align all widgets in vertical format
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Color(0xFF37304A),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.sp),
                            ),
                          ),

                          Center(
                            child: Text(
                              'Create a new account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF737081),
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20.0.h,
                          ),
                          //TextFormField used to get first name text input from user.
                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s")),
                            ],
                            controller: _firstName,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
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
                                color: PrimaryColor,
                              ),
                              hintText: 'Please enter first name',
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'First Name',
                            ),
                            // Validation will be done here
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please enter first name";
                              }
                              if (nameRegExp.hasMatch(value!)) {
                                return 'Please enter valid name';
                              }
                              return null;
                            },
                            // validator: (value) {
                            //   if (value!.isNotEmpty && value.length > 2) {
                            //     return null;
                            //   } else{
                            //     return 'Please enter valid name';
                            //   }
                            // },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to last name get text input from user.
                          TextFormField(
                            controller: _lastName,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s")),
                            ],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
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
                                  color: PrimaryColor),
                              hintText: message.lastName,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'Last Name',
                            ),
                            // Validation will be done here
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please enter last name";
                              }
                              // if (RegExp(r"[a-zA-Z]+|\s").hasMatch(value!)) {
                              //   return 'Please enter valid email';
                              // }
                              else if ('${_firstName.text}' ==
                                  '${_lastName.text}') {
                                return 'First name and last name must not be same';
                              }
                              return null;
                            },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get dob text input  from user.
                          TextFormField(
                            controller: _dateOfBirth,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
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
                                  color: PrimaryColor),
                              hintText: message.dob,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'Date of Birth',
                              suffixIcon: IconButton(
                                icon: Icon(
                                    color: Colors.grey[250],
                                    Icons.calendar_month_outlined),
                                // On tap calendar will open
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(1990),
                                      firstDate: DateTime(1930),
                                      lastDate: DateTime.now());

                                  String birthDate = DateFormat('MM-dd-yyyy')
                                      .format(pickedDate!);
                                  print(birthDate);

                                  setState(() => pickedDate = pickedDate);
                                  // Picked date will be displayed on text form field
                                  print(pickedDate.toString().substring(0, 4));
                                  int birthYear = int.parse(
                                      pickedDate.toString().substring(0, 4));
                                  // var compareDate = DateTimeRange(start: DateTime(1930), end: DateTime(2002));
                                  if (pickedDate != null && birthYear <= 2005) {
                                    _dateOfBirth.text =
                                        birthDate.toString().substring(0, 10);
                                  } else {
                                    CustomSnackBar(
                                        context, 'User must be 18 year old');
                                  }
                                },
                              ),
                            ),
                            // On tap calendar will open
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(1990),
                                  firstDate: DateTime(1930),
                                  lastDate: DateTime.now());

                              String birthDate =
                                  DateFormat('MM-dd-yyyy').format(pickedDate!);
                              print(birthDate);

                              setState(() => pickedDate = pickedDate);
                              // Picked date will be displayed on text form field
                              // (_dateOfBirth.toString().substring(0,3) >= 2019)
                              int birthYear = int.parse(
                                  pickedDate.toString().substring(0, 4));
                              // var compareDate = DateTimeRange(start: DateTime(1930), end: DateTime(2002));
                              if (pickedDate != null && birthYear <= 2005) {
                                _dateOfBirth.text =
                                    birthDate.toString().substring(0, 10);
                              } else {
                                CustomSnackBar(
                                    context, 'User must be 18 year old');
                              }
                            },
                            // Validation will be done here
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please enter date of birth";
                              }
                              return null;
                            },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get email text input from user.
                          TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
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
                                  color: PrimaryColor),
                              hintText: message.email,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'Email(Username)',
                            ),
                            // Validation will be done here
                            validator: (value) {
                              // add your custom validation here.
                              if ((value.toString().isEmpty)) {
                                return 'Please enter email(username)';
                              }
                              if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$'
                              )
                                  .hasMatch(value!)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get alternate email text input from user.
                          // TextFormField(
                          //   controller: _alternateMail,
                          //   keyboardType: TextInputType.emailAddress,
                          //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          //   decoration: InputDecoration(
                          //     enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: Colors.white),
                          //         borderRadius: BorderRadius.circular(10)),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //     ),
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //     hintStyle: TextStyle(
                          //         fontFamily: 'Roboto-Regular',
                          //         color: PrimaryColor),
                          //     hintText:
                          //         '${message.alternateEmail}' " " '(Optional)',
                          //     labelStyle: TextStyle(
                          //         fontFamily: 'Roboto-Regular',
                          //         color: SecondaryColor),
                          //     labelText: 'Alternate email (Optional)',
                          //   ),
                          //   // Validation will be done here
                          //   validator: (value) {
                          //     if ('${_alternateMail.text}'.isEmpty) {
                          //       return null;
                          //     } else if ('${_email.text}' ==
                          //         '${_alternateMail.text}') {
                          //       return 'Please enter alternate email';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // // Sized Box used for vertical & horizontal padding between widgets
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          //TextFormField used to get mobile no. text input from user.
                          TextFormField(
                            controller: _mobileNo,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                  color: PrimaryColor),
                              hintText: message.mobileNo,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'Mobile Number',
                            ),
                            // Validation will be done here
                            validator: (value) {
                              final isDigitsOnly = int.tryParse(value!);

                              if ((isDigitsOnly == null) ||
                                  (value.toString().length < 10) ||
                                  (value.toString().length > 10) ||
                                  value.toString().isEmpty) {
                                return "Please enter mobile number";
                              }
                              return null;
                            },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get alternate mob. no. text input from user.
                          // TextFormField(
                          //   controller: _alternateMobileNo,
                          //   keyboardType: TextInputType.number,
                          //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          //   inputFormatters: [
                          //     FilteringTextInputFormatter.digitsOnly
                          //   ],
                          //   decoration: InputDecoration(
                          //     enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(color: Colors.white),
                          //         borderRadius: BorderRadius.circular(10)),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //     ),
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //     hintStyle: TextStyle(
                          //         fontFamily: 'Roboto-Regular',
                          //         color: PrimaryColor),
                          //     hintText:
                          //         '${message.alternateMobileNo}' " " '(Optional)',
                          //     labelStyle: TextStyle(
                          //         fontFamily: 'Roboto-Regular',
                          //         color: SecondaryColor),
                          //     labelText: 'Alternate mobile no.(Optional)',
                          //   ),
                          //   // Validation will be done here
                          //   validator: (value) {
                          //     if ('${_alternateMobileNo.text}'.isEmpty) {
                          //       return null;
                          //     } else if ('${_mobileNo.text}' ==
                          //         '${_alternateMobileNo.text}') {
                          //       return "Mobile number and alternate mobile "
                          //           "\n"
                          //           " number must not be same";
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // // Sized Box used for vertical & horizontal padding between widgets
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          //TextFormField used to get zip code text input from user.
                          TextFormField(
                            controller: _zipCode,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
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
                                  color: PrimaryColor),
                              hintText: message.zipCode,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: "Zip Code",
                            ),
                            // Validation will be done here
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Please enter zip code';
                              }
                              // Regular expression pattern for US zip code (5 digits)
                              if (!RegExp(
                              r'^\s*\d{5,10}\s*$'

                                //r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$"
                                  //r'^\d{6}$'
                              ).hasMatch(value!)) {
                                return 'Please enter valid zip code';
                              }
                              return null; // Return null if the input is valid
                            },

                            // validator: (value) {
                            //   final isDigitsOnly = int.tryParse(value!);
                            //   if ((isDigitsOnly == null) ||
                            //       (value.toString().length < 5) ||
                            //       value.toString().isEmpty) {
                            //     return "Please enter zip code";
                            //   }
                            //   return null;
                            // },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get address text input from user.
                          TextFormField(
                            controller: _address,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                                  color: PrimaryColor),
                              hintText: '${message.address}' " " '',
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'Address',
                            ),
                            //Validation will be done here
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please enter address";
                              }
                              return null;
                            },

                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get city text input from user.
                          TextFormField(
                            controller: _city,
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
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
                                  color: PrimaryColor),
                              hintText: '${message.city}' " " '',
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'City ',
                            ),
                            // Validation will be done here
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Please enter city";
                              }
                              return null;
                            },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get password text input from user.
                          TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.visiblePassword,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
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
                                  color: PrimaryColor),
                              hintText: message.password,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'Password',
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
                                      //r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$'
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
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 10.h,
                          ),
                          //TextFormField used to get confirm password text input from user.
                          TextFormField(
                            controller: _confirmPassword,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  color: PrimaryColor),
                              hintText: message.confirmPassword,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: SecondaryColor),
                              labelText: 'Confirm Password',
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
                                return "Please re-enter confirm password";
                              } else if (value.toString().length < 6) {
                                return "Password must be more than 5 characters";
                              } else if (_confirmPassword.text !=
                                  _password.text) {
                                return "Password must be same as above";
                              } else {
                                return null;
                              }
                            },
                          ),
                          // Sized Box used for vertical & horizontal padding between widgets
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),

                      // Sized Box used for vertical & horizontal padding between widgets
                      SizedBox(
                        height: 10.h,
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
                        //   // Checking if all validation is done or not.
                        //   final isValid = _form.currentState!.validate();
                        //   if (isValid == true) {
                        //     // Api call here
                        //     final api = ApiServices(Dio(), "/register");
                        //     // Will get response? of api.
                        //     final response? = await api.ApiUser(
                        //         toJson(), context);
                        //
                        //     // Printing response? and status code here
                        //     print('response? status: ${response?.statusCode}');
                        //     print('response? body: ${response?}');
                        //
                        //     // Converting api json response? to string.
                        //     String decode = response?.toString();
                        //     Map<String, dynamic> res = jsonDecode(decode);
                        //     print(res['success']);
                        //     var check = res['success'];
                        //
                        //     //If message from api is true then will navigate to Email Otp page.
                        //     if (check == true) {
                        //       Navigator.pushReplacement(
                        //           context,
                        //           CustomPageRoute(
                        //               child: EmailOtpVerification(
                        //                   Email: _email.text)));
                        //     }
                        //     //else {}
                        //     // Printing json data which is provided to api
                        //     print(
                        //         "register request send to api with user info: ");
                        //     print(toJson());
                        //   }
                        //   //else {}
                        // },
                        onTap: () async {
                          // Checking if all validation is done or not.
                          final isValid = _form.currentState!.validate();
                          if (isValid == true) {
                            // Api call here
                            final api = ApiServices(Dio(), "/register");
                            // Will get response? of api.
                            final response =
                            await api.ApiUser(registerData(), context);

                            // Printing response? and status code here
                            print('response? status: ${response.statusCode}');
                            print('response? body: ${response}');

                            // Converting api json response? to string.
                            String decode = response.toString();
                            Map<String, dynamic> res = jsonDecode(decode);
                            print(res['success']);
                            var check = res['success'];

                            //If message from api is true then will navigate to Email Otp page.
                            if (check == true) {
                              Navigator.pushReplacement(
                                  context,
                                  CustomPageRoute(
                                      child: EmailOtpVerification(
                                          email: _email.text)));
                            } else {}
                            // Printing json data which is provided to api
                            print(
                                "register request send to api with user info: ");
                            print(registerData());
                          } else {}
                        },
                        //   Future.delayed(Duration(milliseconds: 60), () {
                        //     _controller.reverse();
                        //   });
                        //   print('Shrink');
                        //
                        // },
                        // child: ScaleTransition(
                        //   scale: Tween<double>(
                        //     begin: 1.0,
                        //     end: 0.3,
                        //   ).animate(_controller),

                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: 45.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    //height: 4.5,
                                    color: isButtonPressed ? Color(0xFFB2A0FB) : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ),

                      SizedBox(
                        height: 20.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
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
                              border: Border.all(color: Colors.white, width: 3),
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
                              border: Border.all(color: Colors.white, width: 3),
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
                      SizedBox(height: 10.0.h),

                      // not a member? register now
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4.0.w),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                    context, CustomPageRoute(child: LoginScreen())),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Color(0xFF2A77DB),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _backButton(BuildContext context) async{
    bool exitApp = await showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
          backgroundColor: Color(0xFFB2A0FB),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
          title: new Text('Are you sure?',style: TextStyle(color: Colors.white),),
          content: new Text('Do you want to exit an app',style: TextStyle(color: Colors.white, fontSize: 15),),
          actions: <Widget>[
          TextButton(
          onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
                'No',
                style: TextStyle(color: Colors.white),
                ),
                ),
            TextButton(
                //onPressed: () => Navigator.of(context).pop(true),
                onPressed: (){
                exit(0); // Exit the app
                },
                child: new Text(
                'Yes',
                style: TextStyle(color: Colors.white),
                ),
            ),
          ]
        // backgroundColor: Color(0xFFB2A0FB),
        // //title: Text("Really"),
        // content: Text("Do you want to close the app",style: TextStyle(color: Colors.white, fontSize: 20.sp),),
        // actions: [
        //   TextButton(onPressed: (){
        //     Navigator.of(context).pop(false);
        //   }, child: Text("No",style: TextStyle(color: Colors.white, fontSize: 20.sp),)),
        //   TextButton(onPressed: (){
        //     //Navigator.of(context).pop(true);
        //     exit(0);
        //   }, child: Text("Yes",style: TextStyle(color: Colors.white, fontSize: 20.sp),))
        // ],
      );
    });
    return exitApp;
  }
}
