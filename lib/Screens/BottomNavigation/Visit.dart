import 'package:Seerecs/Screens/BottomNavigation%20Screens/Records_BottomNavigation.dart';
import 'package:Seerecs/Screens/BottomNavigation/Records.dart';
import 'package:Seerecs/onboarding/OnBoard.dart';
import 'package:flutter/material.dart';

class Visit extends StatefulWidget {
  const Visit({super.key});

  @override
  State<Visit> createState() => _VisitState();
}

class _VisitState extends State<Visit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: BackButton(color: Colors.black,onPressed: (){
    Navigator.pop(context);
  },),
        title: Text('Visits',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Color(0xFFECEFFC),
      // body: Container(
      //   color: Colors.amber,
      // ),
      body: Stack(
             alignment: AlignmentDirectional.topCenter,
            // fit: StackFit.loose,
            children: [
              Positioned(child: Container(
                height: 370.0,
                decoration: BoxDecoration(
                    color: Color(0xFFB2A0FB),
                    border: Border.all(color: Colors.white,width: 4),
                    //borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              )),
              Positioned(
                top: 5.0,
                height: 430.0,
                child: Image.asset(
                  "assets/Visit.png",
                  //alignment: Alignment.bottomRight,
                  height: 250.0,
                  // width: 300.w,
                ),
              ),

          Positioned(
            //height: 150.h,
            top: 410.0,
            //bottom: 80.h,
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  Text("No Visits ", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF02486A)),),
                  
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 40),
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

            ],
          )
    );
  }
}
