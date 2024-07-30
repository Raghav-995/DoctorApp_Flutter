import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool isLoading = false;

//For all types of Exception this dialog box will appear.
showCustomDialog(BuildContext ctx, String title, String description) {
  showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xFFB2A0FB),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(20.r, 20.r))),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      content: Text(
        description,
        style: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 20.sp,
            // fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      actions: [
        Center(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                //color: Color(0xFFB2A0FB),
                //color: Color(0xFFB2A0FB),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
              ),
              child: Center(
                child: Text(
                  "Ok",
                  style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// This dialog box will appear when user will get Timeout Exception.
TimeOutException(BuildContext context, String title, String description) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xFFB2A0FB),
      title: Text(title,style: TextStyle(color: Colors.white),),
      content: Text(description,style: TextStyle(color: Colors.white),),
      actions: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: 30.h,
            width: 70.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
            ),
            child: Center(
              child: Text(
                "Ok",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Loading will appear while api is called and will be disappear after getting api response? or exception.
// setLoading will get value (true) when api is called and (false) when response? or exception will be get
setLoading(value, context) {
  isLoading = value;
  print('set Loading is called');
  // If value is is true then circular progress indicator will appear
  if (isLoading == true) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return AbsorbPointer(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // padding: EdgeInsets.all(20),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4.0,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Just a moment. Loading...",
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      color: Colors.white, // Set text color to white
                      fontSize: 16,
                      decoration: TextDecoration.none, // Set font size to 16 (or any desired size)
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  // If value is is false then circular progress indicator will disappear
  else {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> CustomSnackBar(
    BuildContext context, SnackText) {
  final scaffold = ScaffoldMessenger.of(context);
  return scaffold.showSnackBar(SnackBar(
    content: Center(
        child: Text(SnackText,
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 19.sp,
                color: Colors.white))),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1000),
    margin:
        EdgeInsets.only(left: 80.0.w, top: 0.0, right: 80.0.w, bottom: 10.0),
    backgroundColor: Colors.black54,
    shape: StadiumBorder(),
  ));
}

// Widget ProfileChangePin(BuildContext context){
//   return Row(
//     children: [
//       InkWell(
//         onTap: () async {
//           int SetPinAuth = 0;
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setInt('SetPinAuth', SetPinAuth);
//           Navigator.push(
//               context,
//               CustomPageRoute(
//                   child: EnterPassword()));
//         },
//         child: ProfileContents(
//             ChangePinColor1,
//             ChangePinColor2,
//             'Change Pin',
//             "assets/ChangePin.svg.png"),
//       ),
//     ],
//   );
// }
//
// Widget ProfileSetPin(BuildContext context){
//   return Row(
//     children: [
//       InkWell(
//         onTap: () async {
//           int SetPinAuth = 0;
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setInt('SetPinAuth', SetPinAuth);
//           Navigator.push(
//               context,
//               CustomPageRoute(
//                   child: EnterPassword()));
//         },
//         child: ProfileContents(
//             AppBarColor1,
//             AppBarColor2,
//             'Set Pin',
//             "assets/ChangePin.svg.png"),
//       ),
//     ],
//   );
// }
