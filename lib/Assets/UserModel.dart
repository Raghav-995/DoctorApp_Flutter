import 'package:flutter/material.dart';
const firstName = "firstName";
const lastName = "lastName";
const email = "email";
const alternateEmail = "alternateEmail";
const confirmPassword = "password";
const mobile = "phone";
const alternateMobile = "alternatePhone";
const address = "address";
const city = "city";
const zipCode = "zipcode";
const dob = "dob";
const verificationCode = "verificationCode";
const gender = "gender";
const relation = "relation";
const profilePicture = "profilePicture";
const deviceName = 'deviceName';
const os ='os';
const osVersion = 'osVersion';
const appVersion = 'appVersion';

class FormTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function? onChanged;

  const FormTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
    required String? Function(dynamic value) validator,
    TextInputType? keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // return TextFormField(
    //   controller: controller,
    //   obscureText: obscureText,
    //   decoration: InputDecoration(
    //     fillColor: Colors.white,
    //     filled: true,
    //     hintText: hintText,
    //     hintStyle: ,
    //     suffixIcon: ,

    //     contentPadding: EdgeInsets.all(4),
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.white),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.grey),
    //     ),
    //   ),
    // );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          suffixIcon: suffixIcon,
          //suffixStyle: TextStyle(color: Colors.grey)
        ),
      ),
    );
  }
}
