import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../../Assets/CustomPageRoute.dart';
import '../../network/response_AlterBox.dart';
import '../LoginScreen.dart';
import '../AppPreferences.dart';

class CareTeamBottomNavigation extends StatefulWidget {
  const CareTeamBottomNavigation({super.key});

  @override
  State<CareTeamBottomNavigation> createState() =>
      _CareTeamBottomNavigationState();
}

class _CareTeamBottomNavigationState extends State<CareTeamBottomNavigation> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
  final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);

  void handleClick(String value) async {
    switch (value) {
      case 'App Preferences':
        int backButton = 1;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('backButton', backButton);
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
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(_scaffoldKey.currentContext!).hideCurrentSnackBar();
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: BackButton(
            onPressed: () {
              //Navigator.push(context, CustomPageRoute(child: HomePage()));
            },
            color: Colors.white,
          ),
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
            'Care Team',
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
              radius: 130.0.r,
              // Image assets used for to get image from assets folder.
              child: Image.asset(
                "assets/CareTeamsDyno.png",
                height: 155.h,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Welcome to C-Recs!'
                "\n"
                'Once you connect to your patient portals you can create networks to rule your health',
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
                // final scaffold = ScaffoldMessenger.of(context);
                // scaffold.showSnackBar(
                //   SnackBar(
                //     content: Center(child: const Text('Coming soon...')),
                //     behavior: SnackBarBehavior.floating,
                //     margin: EdgeInsets.only(
                //         left: 90.0.w, top: 0.0, right: 90.0.w, bottom: 10.0),
                //     shape: StadiumBorder(),
                //     backgroundColor: Colors.black54,
                //   ),
                // );
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
      ),
    );
  }
}
