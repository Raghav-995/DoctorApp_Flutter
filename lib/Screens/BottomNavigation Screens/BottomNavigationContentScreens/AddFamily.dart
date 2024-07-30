import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/AddMember.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import '../../BottomNavigation/Profile.dart';


class AddFamily extends StatefulWidget {
  const AddFamily({super.key});

  @override
  State<AddFamily> createState() => _AddFamilyState();
}

class _AddFamilyState extends State<AddFamily> {
  @override
  Widget build(BuildContext context) {
    bool isButtonPressed = false;
      return Scaffold(
          backgroundColor: Color(0xFFECEFFC),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFECF0FD),
            leading: BackButton(
              //color: Color(0xFF02486A),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //color: Color(0xFFB2A0FB),
              ),
            ),
            title: Text(
              'Add Family member',
              style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          body: Stack(
             alignment: AlignmentDirectional.topCenter,
            // fit: StackFit.loose,
            children: [
              Positioned(child: Container(
                height: 270.h,
                decoration: BoxDecoration(
                    color: Color(0xFFB2A0FB),
                    border: Border.all(color: Colors.white,width: 4),
                    //borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
              )),
              Positioned(
                top: 5.h,
                height: 280.h,
                child: Image.asset(
                  "assets/Leonardo_Diffusion_XL_white_background_colourful_dinosaur_fami_2-removebg-preview (1) 1.png",
                  //alignment: Alignment.bottomRight,
                  height: 250.h,
                  // width: 300.w,
                ),
              ),

          Positioned(
            //height: 150.h,
            top: 280.h,
            //bottom: 80.h,
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  Text("No Family Member Added ", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF02486A)),),
                  SizedBox(height: 10.h,),
                  Text("Add Your Member", style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF02486A)),),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40),
                    child: Text("Add your family member to manage healthcare easily",style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF737081)),textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 50.h,),
                  InkWell(
                    onTapDown: (_) {
                      setState(() {
                        isButtonPressed = true;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        isButtonPressed = false;
                      });
                    },
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){return AddMember();}));
                    },
                    child: AnimatedContainer(duration: Duration(milliseconds: 200),
                      height: 40.h,
                      width: 220.w,
                      decoration: BoxDecoration(
                        // ignore: dead_code
                        color: isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
                        //border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text("Add Member",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),),
                      ),
                    ),
                  ),
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
