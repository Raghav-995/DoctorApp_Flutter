import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Assets/Messages.dart' as message;

class NewUsername extends StatefulWidget {
  const NewUsername({super.key});

  @override
  State<NewUsername> createState() => _NewUsernameState();
}

class _NewUsernameState extends State<NewUsername> {
  bool isChecked = false;
  bool _pri_isObscure = false;
  bool _sec_isObscure = false;

  final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
  final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);

  late TextEditingController _password = TextEditingController();
  late TextEditingController _reTypePassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.grey[700]),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          message.newUsername,
          style: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700]),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/NewPassword.png",
                        height: 250.0.h,
                        // width: 250.0,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        "Create your new username ",
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 25.sp,
                            color: SecondaryColor,fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      TextFormField(
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _pri_isObscure,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto-Regular', color: SecondaryColor),
                          labelText: message.newUsername,
                          hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular', color: PrimaryColor),
                          hintText: message.newUsername,
                          suffixIcon: IconButton(
                              icon: Icon(
                                  color: (_pri_isObscure == false)
                                      ? SecondaryColor
                                      : PrimaryColor,
                                  _pri_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _pri_isObscure = !_pri_isObscure;
                                });
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      TextFormField(
                        controller: _reTypePassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _sec_isObscure,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto-Regular', color: SecondaryColor),
                          labelText: 'Re-type your username',
                          hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular', color: PrimaryColor),
                          hintText: 'Re-type your username',
                          suffixIcon: IconButton(
                              icon: Icon(
                                  color: (_sec_isObscure == false)
                                      ? SecondaryColor
                                      : PrimaryColor,
                                  _sec_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _sec_isObscure = !_sec_isObscure;
                                });
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                      Container(
                        height: 30.h,
                        width: double.infinity,
                        decoration: BoxDecoration( gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            PrimaryColor,
                            SecondaryColor,
                          ],
                        ),
                          // color: Color.fromRGBO(24, 125, 203, 100),
                          borderRadius:
                          BorderRadius.all(Radius.circular(21.0.r)),
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
    );
  }
}
