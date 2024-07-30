import 'dart:io';
import 'package:Seerecs/Screens/CareTeam/AddProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Provider extends StatefulWidget {
  const Provider({super.key, this.careTeamName});
  final String? careTeamName;
  @override
  State<Provider> createState() => _ProviderState();
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

class _ProviderState extends State<Provider> {
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
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
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
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                    //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                  ),
                )),
                Positioned(
                  top: 15.h,
                  height: 240.h,
                  child: Image.asset(
                    "assets/18-removebg-preview 1.png",
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
                Text("Your Care Team Has Been Created", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF02486A)),),
                SizedBox(height: 10.h,),
                Text("Add Your First Provider", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF02486A)),),
                SizedBox(height: 30.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text("A provider is a doctor which you access directly through this app",style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF737081)),textAlign: TextAlign.center,),
                ),
                SizedBox(height: 30.h,),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return AddProvider();}
                    ));
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
                      child: Text("Add Provider",style: TextStyle(
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
                // backgroundColor: Color(0xFFB2A0FB),
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
}
