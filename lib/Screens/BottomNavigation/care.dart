import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Assets/CareTeamModel.dart';
import '../../Assets/CustomPageRoute.dart';
import '../../network/API_Services.dart';
import '../CareTeam/AddCare.dart';
import '../CareTeam/GetCareTeam.dart';

class Care extends StatefulWidget {
  const Care({super.key});

  @override
  State<Care> createState() => _CareState();
}
bool canBack = false;


Future<bool> _onWillPopHome(context) async {
  canBack = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xFFB2A0FB),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
      title: new Text('Are you sure?',style: TextStyle(color: Colors.white),),
      content: new Text('Do you want to exit an app',style: TextStyle(color: Colors.white),),
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
      ],
    ),
  );
  return canBack;
}

Map<String, dynamic> careTeamData() {
  return {
    ('careTeamName'): (careTeamName.toString()),
  };
}


class _CareState extends State<Care> {
  bool _isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECEFFC),
        appBar: AppBar(
          elevation: 0,
          //backgroundColor: Color(0xFFECF0FD),
          automaticallyImplyLeading: false,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xFFB2A0FB),
            ),
          ),
          title: Text(
            'Add Care Team',
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37304A)),
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.view_compact_alt,
          //         color: Colors.black,
          //       )),
          // ],
        ),
        body: Column(
          children: [
            Stack(
              //overflow: Overflow.clip,
              alignment: AlignmentDirectional.bottomCenter,
              fit: StackFit.loose,
              children: [

                Positioned(child: Container(
                  height: 240.h,
                  decoration: BoxDecoration(
                      color: Color(0xFFB2A0FB),
                      // gradient: LinearGradient(
                      //   colors: [Color(0xFF9397EF), Color(0xFFDA97FC)],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
                      border: Border.all(color: Colors.white,width: 4),
                      //borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                  ),
                )),
                Positioned(
                  top: 15.h,
                  height: 280.h,
                  child: Image.asset(
                    "assets/caredyno.png",
                    //alignment: Alignment.bottomRight,
                    height: 250.h,
                    // width: 300.w,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20.h,),
                Text("No Care Team Added", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF02486A)),),
                SizedBox(height: 10.h,),
                Text("Add Your First Provider", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF02486A)),),
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text("A care team is a group of healthcare professionals working collaboratively to "
                      "provide comprehensive and coordinated care to meet the diverse needs of a you.",style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF737081)),textAlign: TextAlign.center,),
                ),
                SizedBox(height: 10.h,),
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
                  onTap: (){
                    fetchDataFromAPI();
                    //               Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //                 return AddCare();}
                    // ));
                  },
                  // Navigator.pushReplacement(
                  //     context,
                  //     CustomPageRoute(child: AddCare()));

                  child: AnimatedContainer(duration: Duration(milliseconds: 200),
                    height: 40.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      color: _isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                      //border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text("Create Team",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
            // Image.asset(
            //   "assets/64-removebg-preview (1) 1.png",
            //   height: 250.h,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                // child: FloatingActionButton(
                //   onPressed: null,
                //   backgroundColor: Color(0xFFB2A0FB),
                //   shape: CircleBorder(),
                //   child: const Icon(Icons.add, size: 40,),
                // ),
              ),
            ),
            //FloatingActionButtonLocation.centerDocked,

            // FloatingActionButtonLocation.endFloat,
            // floatingActionButton: FloatingActionButton(
            //   //onPressed: _incrementCounter,
            //   //tooltip: 'Increment',
            //   child: const Icon(Icons.add),
            // ),,


          ],
        )

    );
  }
  Future<void> fetchDataFromAPI() async {
    final api = ApiServices(Dio(), "/getCareTeams");
    final response = await api.ApiUser(careTeamData(), context);

    print('Response body: ${response.data}');
    print('Status code : ${response.statusCode}');

    if (response.statusCode == 200) {
      setState(() {
        var responseData = response.data;
        print('res: ${responseData}');

        if (responseData == null) {
          // If response data is null, navigate to AddFamily
          Navigator.pushReplacement(
            context,
            CustomPageRoute(child: AddCare()),
          );
        } else if (responseData['careTeams'] is List) {
          List<dynamic> careTeams = responseData['careTeams'];
          if (careTeams.isEmpty) {
            // If 'careTeams' list is empty, navigate to AddFamily
            Navigator.pushReplacement(
              context,
              CustomPageRoute(child: AddCare()),
            );
          } else {
            // If 'careTeams' list is not empty, navigate to FamilyMembers
            Navigator.pushReplacement(
              context,
              CustomPageRoute(child: GetCareteam()),
            );
          }
        } else {
          // Handle other cases where response data is not as expected
          print("Error: Unexpected response data format");
        }
      });
    } else {
      // Handle other status codes if needed
      print("Error: Non-200 status code received");
    }
  }
}
