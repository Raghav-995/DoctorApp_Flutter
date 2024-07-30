// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Grid"),
//       ),
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: GridView(
//             children: [
//               InkWell(
//                 onTap: () {
//                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.red,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       //Icon(Icons.home,size: 50,color: Colors.white,),
//                       Image.asset(
//                         "assets/transaction 1.png",
//                         height: 40.h,
//                       ),
//                       Text(
//                         "Update Profile",
//                         style: TextStyle(color: Colors.white, fontSize: 30),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.yellow,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/family (1) 1.png",
//                         height: 40.h,
//                       ),
//                       //Icon(Icons.search,size: 50,color: Colors.white,),
//                       Text(
//                         "Add Family Member",
//                         style: TextStyle(color: Colors.white, fontSize: 30),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.green,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/daily-calendar 1.png",
//                         height: 40.h,
//                       ),
//                       //Icon(Icons.settings,size: 50,color: Colors.white,),
//                       Text(
//                         "My Activity",
//                         style: TextStyle(color: Colors.white, fontSize: 30),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/reset-password 1.png",
//                         height: 40.h,
//                       ),
//                       //Icon(Icons.book,size: 50,color: Colors.white,),
//                       Text(
//                         "Change Password",
//                         style: TextStyle(color: Colors.white, fontSize: 30),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/password 1.png",
//                         height: 40.h,
//                       ),
//                       //Icon(Icons.book,size: 50,color: Colors.white,),
//                       Text(
//                         "Set Pin",
//                         style: TextStyle(color: Colors.white, fontSize: 30),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/share.png",
//                         height: 40.h,
//                       ),
//                       //Icon(Icons.book,size: 50,color: Colors.white,),
//                       Text(
//                         "Share Log",
//                         style: TextStyle(color: Colors.white, fontSize: 30),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
//           ),
//         ),
//       ),
//     );
//   }
// }
