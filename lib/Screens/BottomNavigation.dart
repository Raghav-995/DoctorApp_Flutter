import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/custom_icons_icons.dart';
import 'package:Seerecs/network/API_Services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:Seerecs/Screens/navigation/HomePage.dart';
import 'package:Seerecs/Screens/BottomNavigation/Profile.dart';
import 'package:Seerecs/Screens/BottomNavigation/Records.dart';
import 'package:Seerecs/Screens/BottomNavigation/Visit.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assets/CareTeamModel.dart';
//import 'BottomNavigation/care.dart';
import 'BottomNavigation/careTeam.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

// StoreSetPinInfo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   PinSwitchOn = prefs.getInt('PinSwitchOn')!;
// }
storeSetPinInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pinSwitchOn = prefs.getInt('pinSwitchOn')!;
}

// Making Json to be send to API
Map<String, dynamic> toJson() {
  return {};
}

class _BottomNavigationState extends State<BottomNavigation> {
  getRecordApiCall() async {
    // Call your API here and pass `_verificationCode` as a parameter
    final api = ApiServices(Dio(), "/getRecord");
    // Api response? will get
    final response = await api.ApiUser(toJson(), context);
    //Print response? here
    print('response? status: ${response.statusCode}');
    print('response? body: ${response}');
    print(
        'response? headers: ${response.headers[HttpHeaders.authorizationHeader]}');
    // New token will be saved here
    String decodeResponse = response.toString();
    Map<String, dynamic> res = jsonDecode(decodeResponse);
    res['token'] = '${response.headers[HttpHeaders.authorizationHeader]}';
    late var token = res['token'];
    token = token.substring(1, token.length - 1);

    print(token);
    // Shared preferences used here so we can store token which will get from api.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }

    print("Get Record request send to api");
    // print(otpData());
  }

  // final PrimaryColor = Color.fromRGBO(52, 145, 184, 90);
  // final SecondaryColor = Color.fromRGBO(38, 90, 112, 60);
  String? firstName;
  String? lastName;
  String? city;
  String? email;
  String? zipcode;
  String? dob;
  String? address;
  String? phone;
  String? gender;
  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use the correct key to retrieve firstName from SharedPreferences
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? city = prefs.getString('city');
    String? email = prefs.getString('email');
    String? zipcode = prefs.getString('zipcode');
    String? dob = prefs.getString('dob');
    String? address = prefs.getString('address');
    String? phone = prefs.getString('phone');
    String? gender = prefs.getString('gender');
    print('Debug: FirstName1: $firstName');
    print('Debug: LastName1: $lastName');
    print('Debug: Email1: $email');
    print('Debug: City: $city');
    print('Debug: Zipcode: $zipcode');
    print('Debug: Date of Birth: $dob');
    print('Debug: Address: $address');
    print('Debug: Phone: $phone');
    print('Debug: gender: $gender');
    if (firstName != null) {
      setState(() {
        firstName = firstName;
        lastName = lastName;
        city = city;
        email = email;
        zipcode = zipcode;
        dob = dob;
        address = address;
        phone = phone;
        gender = gender;
      });
      //print('Fetched firstName: $_firstName');
    } else {
      print('Failed to fetch firstName from SharedPreferences.');
      print('Keys in SharedPreferences: ${prefs.getKeys()}');
    }
  }
  Map<String, dynamic> careTeamData() {
    return {
      ('careTeamName'): (careTeamName.toString()),
    };
  }
  ListQueue<int> navigationQueue = ListQueue();
  int selectedIndex = 0;
  bool canBack = false;

  /// Controller to handle PageView and also handles initial page
  var pageController = PageController(initialPage: 0);
  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.paste,
      "",
      Color(0xFFB2A0FB),
      circleStrokeColor: Colors.white,
    ),
    TabItem(
      CustomIcons.material_symbols_nest_doorbell_visitor_outline,
      "",
      Color(0xFFB2A0FB),
      circleStrokeColor: Colors.white,
    ),
    TabItem(Icons.headphones, "", Color(0xFFB2A0FB),
        circleStrokeColor: Colors.white),
    TabItem(Icons.person_outlined, "", Color(0xFFB2A0FB),
        circleStrokeColor: Colors.white),
  ]);

  /// Controller to handle bottom nav bar and also handles initial page
  //final _controller = NotchBottomBarController(index: 0);
  final contoller = CircularBottomNavigationController(0);

  int maxCount = 4;
  int selectedPos = 0;
  double bottomNavBarHeight = 60;
  //late List<Widget> bottomBarPages;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    storeSetPinInfo();
    getUserInfo();
    // bottomBarPages = [
    //   Records(),
    //   Visit(),
    //   _displayCareWidget(), // Call the function to get the widget
    //   Profile(),
    // ];
    //getRecordApiCall();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// widget list
 final List<Widget> bottomBarPages = [Records(), Visit(), CareTeam(), Profile()];

  Future<bool> onWillPopHome() async {
    if (selectedIndex != 0) {
      // Navigator.pop(context);
      setState(() {
        selectedIndex = 0;
        //using this page controller you can make beautiful animation effects
        pageController.animateToPage(selectedIndex,
            duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        navigationQueue.removeLast();
      });
    } else if (selectedIndex == 0) {
      canBack = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFFB2A0FB),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
          title: new Text(
            'Are you sure?',
            style: TextStyle(color: Colors.white),
          ),
          content: new Text(
            'Do you want to exit an app',
            style: TextStyle(color: Colors.white),
          ),
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
              onPressed: () {
                exit(0); // Exit the app
              },
              child: new Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
    return canBack;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final showPop = await onWillPopHome();
          return showPop;
        },
        child: Scaffold(
          //backgroundColor: Colors.white,
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() => selectedIndex = index);
              contoller.value = index;
              //index == 0 ? GetRecordApiCall() : null;
            },

            physics: const NeverScrollableScrollPhysics(),
            //children: bottomBarPages,
            children: List.generate(
                bottomBarPages.length, (index) => bottomBarPages[index]),
          ),

          extendBody: true,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(60.r, 60.r),
              bottomRight: Radius.elliptical(60.r, 60.r),
            ),
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              padding: EdgeInsets.fromLTRB(7, 0, 7, 7),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    // bottom: BorderSide(color: Colors.white, width: 8.0),
                    // right: BorderSide(color: Colors.white, width: 7.0),
                    // left: BorderSide(color: Colors.white, width: 7.0))
                    ),
              ),

              child: CircularBottomNavigation(
                controller: contoller,
                tabItems,
                barHeight: bottomNavBarHeight,
                normalIconColor: Colors.white,
                selectedIconColor: Colors.black,
                iconsSize: 30,
                circleStrokeWidth: 5,
                circleSize: 60,
                barBackgroundColor: Color(0xFFB2A0FB),
                animationDuration: Duration(milliseconds: 300),
                selectedCallback: (selectedPos) {
                  setState(() {
                    selectedIndex = selectedPos!;
                    pageController.jumpToPage(selectedPos);
                  });
                },
              ),
            ),
          ),
        ));
  }
  // Widget _displayCareWidget() {
  //   // Perform asynchronous operation here
  //   ApiServices(Dio(), "/getCareTeams").ApiUser(careTeamData(), context).then((response) {
  //     print('Response body: ${response.data}');
  //     print('Status code : ${response.statusCode}');
  //
  //     if (response.statusCode == 200) {
  //       var responseData = response.data;
  //       print('res: ${responseData}');
  //
  //       if (responseData == null) {
  //         // If response data is null, navigate to AddFamily
  //         Navigator.pushReplacement(
  //           context,
  //           CustomPageRoute(child: AddCare()),
  //         );
  //       } else if (responseData['careTeams'] is List) {
  //         List<dynamic> careTeams = responseData['careTeams'];
  //         if (careTeams.isEmpty) {
  //           // If 'careTeams' list is empty, navigate to AddFamily
  //           Navigator.pushReplacement(
  //             context,
  //             CustomPageRoute(child: AddCare()),
  //           );
  //         } else {
  //           // If 'careTeams' list is not empty, navigate to FamilyMembers
  //           Navigator.pushReplacement(
  //             context,
  //             CustomPageRoute(child: getCareteam()),
  //           );
  //         }
  //       } else {
  //         // Handle other cases where response data is not as expected
  //         print("Error: Unexpected response data format");
  //       }
  //     } else {
  //       // Handle other status codes if needed
  //       print("Error: Non-200 status code received");
  //     }
  //   }).catchError((error) {
  //     // Handle errors if any
  //     print("Error: $error");
  //   });
  //
  //   // Return a placeholder widget or null since the widget will be replaced by navigation
  //   return SizedBox();
  // }

}

