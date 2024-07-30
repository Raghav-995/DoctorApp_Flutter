import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

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
          fit: StackFit.passthrough,
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(160),
                  bottomRight: Radius.circular(160),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  //width: double.maxFinite,
                  //height: 670.0.h,
                  height: MediaQuery.of(context).size.height * 0.99,
                  //height: MediaQuery.of(context).size.height * 0.98,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: const Radius.circular(160),
                      //   bottomRight: const Radius.circular(160),
                      // ),
                      image: DecorationImage(
                    image: AssetImage("assets/Doc-02 1.png"),

                    fit: BoxFit.fill,
                    //fit: BoxFit.contain,
                    //fit: BoxFit.fitHeight,
                  )),
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
                      Text("Care Team",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        height: 16.0.h,
                      ),
                      Center(
                        child: Text(
                          "The easiest way to track your medical personnel, stay in touch, and help them be efficient, even on the go.",
                          style: TextStyle(
                              fontSize: 17.sp,
                              height: 1.5,
                              color: Colors.white,fontWeight: FontWeight.w500,),
                          textAlign: TextAlign.center,
                        ),
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
