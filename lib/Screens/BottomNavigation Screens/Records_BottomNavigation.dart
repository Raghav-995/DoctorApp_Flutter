import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Assets/CustomPageRoute.dart';
import '../../network/response_AlterBox.dart';
import '../LoginScreen.dart';
import '../AppPreferences.dart';

class RecordsBottomNavigation extends StatefulWidget {
  const RecordsBottomNavigation({super.key});

  @override
  State<RecordsBottomNavigation> createState() =>
      _RecordsBottomNavigationState();
}

class _RecordsBottomNavigationState extends State<RecordsBottomNavigation> {

  final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
  final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);


  void handleClick(String value) async {
    switch (value) {
      case 'App Preferences':
        int BackButton = 1;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('BackButton', BackButton);
        Navigator.push(
            context, CustomPageRoute(child: StreamLinePreferences()));
        break;
      case 'Share':
        Share.share('Join now to Rule Your Health!! -'"\n"'https://play.google.com/store/apps/details?id=com.example.Seerecs');
        break;
      case 'Terminology':
        CustomSnackBar(context, 'Coming soon...');
        break;
      case 'Terms & Condition':
        CustomSnackBar(context, 'Coming soon...');
        break;
      case 'Privacy Policy':
        CustomSnackBar(context, 'Coming soon...');
        break;
      case 'Logout':
        Navigator.pushReplacement(
            context, CustomPageRoute(child: LoginScreen()));
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
          'Records',
          style: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'App Preferences',
                'Share',
                'Terminology',
                'Terms & Condition',
                'Privacy Policy',
                'Logout',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Color.fromRGBO(27, 73, 78, 200),
            radius: 135.0.r,
            // Image assets used for to get image from assets folder.
            child: Image.asset(
              "assets/RecordsDyno.png",
              height: 145.h,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Welcome to C-Recs!'
              "\n"
              'Please connect to your patient portals to rule your health',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: () {
              CustomSnackBar(context, 'Coming soon...');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(30, 66, 82, 60),
                fixedSize: Size(350.w, 45.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text(
              'Connect to Patient Portal',
              style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
