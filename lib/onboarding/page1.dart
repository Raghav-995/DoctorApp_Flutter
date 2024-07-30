import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 7),
        ),
        child: Stack(
          //alignment: Alignment.bottomCenter,
          //fit: StackFit.passthrough,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              //bottom: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),
                bottomLeft: Radius.circular(210),
                  bottomRight: Radius.circular(210),),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width ,  // 50% of screen width
                  height: MediaQuery.of(context).size.height,  // 30% of screen height
                  // width: double.maxFinite,
                  //height: 670.0.h,
                  //height: MediaQuery.of(context).size.height,
                   decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        //bottomLeft: Radius.elliptical(30.r, 30.r),
                        //bottomLeft: const Radius.circular(100),
                        //bottomRight: const Radius.circular(100),
                      ),
                      image: DecorationImage(
                       // alignment: Alignment.center,
                        image: AssetImage("assets/Doc-03 1.png"),

                        fit: BoxFit.fill,
                        //fit: BoxFit.cover,
                        //fit: BoxFit.contain,
                      )),
                  //transform: Matrix4.diagonal3Values(scaleFactor, scaleFactor, 1),
                ),
              ),
            ),
            Positioned(
              //top: 590,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                //height: MediaQuery.of(context).size.height / 3.5,
                height: 180.0.h,
                width: 430.0.w,
                decoration: BoxDecoration(
                  color: Color(0xffB2A0FB),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 26.0.h,
                      ),
                      Text("View Health Records",
                          style:  TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        height: 16.0.h,
                      ),
                      Text(
                        "C-Recs is a healthcare app that helps users manage and track their health and wellness.",
                        style: TextStyle(
                            fontSize: 17.sp, height: 1.5, color: Colors.white,fontWeight: FontWeight.w500,),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
