// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/FamilyMembers.dart';
// import 'package:Seerecs/Screens/BottomNavigation/Profile.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class AddMember extends StatefulWidget {
//   const AddMember({super.key});
//
//   @override
//   State<AddMember> createState() => _AddMemberState();
// }
//
// class _AddMemberState extends State<AddMember> {
//   @override
//   Widget build(BuildContext context) {
//     bool _isButtonPressed = false;
//     var _value = "-1";
//     return Scaffold(
//         backgroundColor: Color(0xFFECEFFC),
//     appBar: AppBar(
//     elevation: 0,
//     backgroundColor: Color(0xFFECF0FD),
//     //automaticallyImplyLeading: false,
//       leading: BackButton(
//         //color: Color(0xFF02486A),
//         onPressed: () => Navigator.pop(context),
//         // onPressed: () => Navigator.push(
//         //     context,
//         //     CustomPageRoute(child: Care
//         //       ())),
//       ),
//     centerTitle: true,
//     flexibleSpace: Container(
//     decoration: BoxDecoration(
//     color: Colors.white,
//     //color: Color(0xFFB2A0FB),
//     ),
//     ),
//     title: Text(
//     'Add Family Member',
//     style: TextStyle(
//     fontFamily: 'Roboto-Regular',
//     fontSize: 32.sp,
//     fontWeight: FontWeight.bold,
//     color: Colors.black),
//     ),
//     // actions: [
//     // IconButton(
//     // onPressed: () {},
//     // icon: Icon(
//     // Icons.view_compact_alt,
//     // color: Colors.black,
//     // )),
//     // ],
//     ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Column(
//             //crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.edit_square,
//                       color: Colors.black,
//                     )),
//               ),
//               // SizedBox(
//               //   height: 5.h,
//               // ),
//               CircleAvatar(
//                 backgroundColor: Color(0xFFB2A0FB),
//                 radius: 40.r,
//                 child: Image.asset(
//                   "assets/Vector (3).png",
//                   height: 25.h,
//                   //color: Colors.black,
//                 ),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               Text('Please fill the following details correctly',
//               style: TextStyle(color: Color(0xFF02486A),fontWeight: FontWeight.w600, fontSize: 18.sp),),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ListTile(
//                       title: Text('First Name', style: TextStyle(fontSize: 15)
//                         ,),
//                       subtitle: TextFormField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(9),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(8)),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           hintText: 'First name',
//                           hintStyle: TextStyle(
//                               fontFamily: 'Roboto-Regular',
//                               color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                           ),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child:ListTile(
//                       title: Text('Last Name'),
//                       subtitle:  TextFormField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(9),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10)),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           hintText: 'Last name',
//                           hintStyle: TextStyle(
//                             fontFamily: 'Roboto-Regular',
//                             color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                           ),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),),
//                   ),
//                 ],
//               ),
//               // SizedBox(
//               //   height: 5,
//               // ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ListTile(
//                       title: Text('Relation'),
//                       subtitle: DropdownButtonFormField(
//                         value: _value,
//                         dropdownColor: Colors.white,
//                         items: [
//                         DropdownMenuItem(child: Text("Select", style: TextStyle(fontSize: 14,color: Color(0xFFB5B4BD), )), value: "-1",),
//                         DropdownMenuItem(child: Text("Father", style: TextStyle(fontSize: 14)),value: "1",),
//                         DropdownMenuItem(child: Text("Mother", style: TextStyle(fontSize: 14)),value: "2",),
//                         DropdownMenuItem(child: Text("Husband", style: TextStyle(fontSize: 14)),value: "3",),
//                         DropdownMenuItem(child: Text("Wife", style: TextStyle(fontSize: 14)),value: "4",),
//                         DropdownMenuItem(child: Text("Son", style: TextStyle(fontSize: 14)),value: "5",),
//                         DropdownMenuItem(child: Text("Daughter", style: TextStyle(fontSize: 14)),value: "6",),
//                         DropdownMenuItem(child: Text("Grand children", style: TextStyle(fontSize: 14)),value: "7",),
//                         DropdownMenuItem(child: Text("Grand father", style: TextStyle(fontSize: 14)),value: "8",),
//                         DropdownMenuItem(child: Text("Grand mother", style: TextStyle(fontSize: 14)),value: "9",),
//                         DropdownMenuItem(child: Text("Other", style: TextStyle(fontSize: 14)),value: "10",),
//                         DropdownMenuItem(child: Text("Rather not say", style: TextStyle(fontSize: 14)),value: "11",),
//                       ],
//                         onChanged: (v){},
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(9),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10)),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                         validator: (value) => value == null ? "Select" : null,
//                       ),
//                       // subtitle: TextFormField(
//                       //   decoration: InputDecoration(
//                       //     contentPadding: EdgeInsets.all(9),
//                       //     enabledBorder: OutlineInputBorder(
//                       //         borderSide: BorderSide(color: Colors.white),
//                       //         borderRadius: BorderRadius.circular(10)),
//                       //     focusedBorder: OutlineInputBorder(
//                       //       borderSide: BorderSide(color: Colors.white),
//                       //     ),
//                       //     hintText: 'Relation',
//                       //     hintStyle: TextStyle(
//                       //       fontFamily: 'Roboto-Regular',
//                       //       color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                       //     ),
//                       //     fillColor: Colors.white,
//                       //     filled: true,
//                       //   ),
//                       // ),
//                       ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child:ListTile(
//                       title: Text('Contact no.'),
//                       subtitle:  TextFormField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(9),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10)),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           hintText: 'Contact no.',
//                           hintStyle: TextStyle(
//                             fontFamily: 'Roboto-Regular',
//                             color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                           ),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),),
//                   ),
//                 ],
//               ),
//               ListTile(
//                 title: Text('Email Address'),
//                 subtitle: TextFormField(
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(9),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10)),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     hintText: 'Email address',
//                     hintStyle: TextStyle(
//                       fontFamily: 'Roboto-Regular',
//                       color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                     ),
//                     fillColor: Colors.white,
//                     filled: true,
//                   ),
//                 ),
//               ),
//               // SizedBox(
//               //   height: 5,
//               // ),
//               ListTile(
//                 title: Text('Address'),
//                 subtitle: TextFormField(
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(9),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(10)),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     hintText: 'Address',
//                     hintStyle: TextStyle(
//                       fontFamily: 'Roboto-Regular',
//                       color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                     ),
//                     fillColor: Colors.white,
//                     filled: true,
//                   ),
//                 ),
//               ),
//               // SizedBox(
//               //   height: 5,
//               // ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ListTile(
//                       title: Text('City'),
//                       subtitle: TextFormField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(9),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10)),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           hintText: 'City',
//                           hintStyle: TextStyle(
//                             fontFamily: 'Roboto-Regular',
//                             color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                           ),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child:ListTile(
//                       title: Text('Zip Code'),
//                       subtitle:  TextFormField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(9),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10)),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           hintText: 'zip code',
//                           hintStyle: TextStyle(
//                             fontFamily: 'Roboto-Regular',
//                             color: Color(0xFFB5B4BD), fontSize: 16.sp,
//                           ),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     Expanded(child:
//                       InkWell(
//                         onTapDown: (_) {
//                           setState(() {
//                             _isButtonPressed = true;
//                           });
//                         },
//                         onTapUp: (_) {
//                           setState(() {
//                             _isButtonPressed = false;
//                           });
//                         },
//                         onTap: (){
//                           // Navigator.pushReplacement(
//                           //     context,
//                           //     CustomPageRoute(child: AddMember()));
//                         },
//                         child: AnimatedContainer(duration: Duration(milliseconds: 200),
//                           height: 45.h,
//                           width: 10.w,
//                           decoration: BoxDecoration(
//                             color: _isButtonPressed ? Colors.white : Color(0xFFDFDFDF),
//                             border: Border.all(color: Colors.white, width: 3),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Center(
//                             child: Text("Cancel",style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF37304A)),),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 45,
//                     ),
//                     Expanded(child:
//                     InkWell(
//                       onTapDown: (_) {
//                         setState(() {
//                           _isButtonPressed = true;
//                         });
//                       },
//                       onTapUp: (_) {
//                         setState(() {
//                           _isButtonPressed = false;
//                         });
//                       },
//                       onTap: (){
//                         // Navigator.pushReplacement(
//                         //     context,
//                         //     CustomPageRoute(child: AddMember()));
//                       },
//                       child: AnimatedContainer(duration: Duration(milliseconds: 200),
//                         height: 45.h,
//                         //width: 220.w,
//                         decoration: BoxDecoration(
//                           color: _isButtonPressed ? Colors.white : Color(0xFFB2A0FB),
//                           border: Border.all(color: Colors.white, width: 3),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Center(
//                           child: Text("Add Member",style: TextStyle(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white),),
//                         ),
//                       ),
//                     ),
//                     ),
//
//                   ],
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Screens/BottomNavigation/Profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Seerecs/Assets/FamilyModel.dart' as family;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Assets/CustomPageRoute.dart';
import '../../../network/API_Services.dart';
import '../../../network/Response_AlterBox.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _form = GlobalKey<FormState>();

  late TextEditingController _firstName =
  TextEditingController(); // First name text field controller
  late TextEditingController _lastName =
  TextEditingController(); // Last name text field controller// Dob  text field controller
  late TextEditingController _email =
  TextEditingController(); // Email text field controller
  // late TextEditingController _alternateMail =
  //     TextEditingController(); // Alternate mail text field controller
  late TextEditingController _mobileNo =
  TextEditingController(); // Mobile no. text field controller
  // late TextEditingController _alternateMobileNo =
  //     TextEditingController(); // Alternate mobile no. text field controller
  late TextEditingController _address =
  TextEditingController(); // Address text field controller
  late TextEditingController _city =
  TextEditingController(); // City text field controller
  late TextEditingController _zipCode =
  TextEditingController(); // Zip code text field controller
  late TextEditingController _relation = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void initState() {
    super.initState();
    // loadingImage();
    // _initPrefs();
    _relation.text = "";
  }

  String? _imagePath = '';
  PickedFile? familyImage;
  String? imagepath;
  bool _imageSelected = false;
  Map<String, dynamic> toJson() {
    return {
      (family.firstName): (_firstName.text ),
      (family.lastName): (_lastName.text),
      (family.email): (_email.text.toLowerCase()),
      (family.contactNo): (_mobileNo.text),
      (family.address): (_address.text),
      (family.city): (_city.text),
      (family.zipCode): (_zipCode.text),
      (family.relation): (_relation.text),
    };
  }

  @override
  Widget build(BuildContext context) {
    bool _isButtonPressed = false;
    
    return Form(
      key: _form,
      child: Scaffold(
        backgroundColor: Color(0xFFECEFFC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFECF0FD),
          //automaticallyImplyLeading: false,
          leading: BackButton(
            //color: Color(0xFF02486A),
            //onPressed: () => Navigator.pop(context),
            onPressed: () => Navigator.push(
                context,
                CustomPageRoute(child: Profile())),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xFFB2A0FB),
            ),
          ),
          title: Text(
            'Add Family Member',
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          // actions: [
          // IconButton(
          // onPressed: () {},
          // icon: Icon(
          // Icons.view_compact_alt,
          // color: Colors.black,
          // )),
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_square,
                        color: Colors.black,
                      )),
                ),
                // SizedBox(
                //   height: 5.h,
                // ),
                imageProfile(),
                // CircleAvatar(
                //   backgroundColor: Color(0xFFB2A0FB),
                //   radius: 40.r,
                //   child: Image.asset(
                //     "assets/allergies 1.png",
                //     height: 25.h,
                //     //color: Colors.black,
                //   ),
                // ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Please fill the following details correctly',
                  style: TextStyle(
                      color: Color(0xFF02486A),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'First Name',
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'First name',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                              fontSize: 16.sp,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Please enter first name";
                            }
                            // if (nameRegExp.hasMatch(value!)) {
                            //   return 'Please enter valid name';
                            // }
                            return null;
                          },
                          controller: _firstName,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z]+|\s")),
                          ],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('Last Name'),
                        subtitle: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Last name',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                              fontSize: 16.sp,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z]+|\s")),
                          ],
                          controller: _lastName,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Please enter last name";
                            }
                            // if (RegExp(r"[a-zA-Z]+|\s").hasMatch(value!)) {
                            //   return 'Please enter valid email';
                            // }
                            else if ('${_firstName.text}' ==
                                '${_lastName.text}') {
                              return 'First name and last name must not be same';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 5,
                // ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('Relation'),
                        subtitle: DropdownButtonFormField<String>(
                          //value: _gender.text,
                          value: _relation.text.isNotEmpty
                              ? _relation.text
                              : 'Select Relation',
                          //value: _gender.text.isEmpty ? 'Select': _gender.text ,

                          dropdownColor: Colors.white,
                          onChanged: (String? val) {
                            //if (val != null) {
                            setState(() {
                              _relation.text = val!;
                              print(_relation.text);
                            });
                            // }
                          },
                          items: <String>[
                            'Select Relation',
                            'Father',
                            'Mother',
                            'Husband',
                            'Wife',
                            'Son',
                            'Grand children',
                            'Grand father',
                            'Grand mother',
                            'Other',
                            'Rather not say'
                          ].map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value!,
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) => value == null ? "Select" : null,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 1,
                    // ),
                    Expanded(
                      child: ListTile(
                        title: Text('Contact no.'),
                        subtitle: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Contact no.',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                              fontSize: 16.sp,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.go,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _mobileNo,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // Validation will be done here
                          validator: (value) {
                            final isDigitsOnly = int.tryParse(value!);

                            if ((isDigitsOnly == null) ||
                                (value.toString().length < 10) ||
                                (value.toString().length > 10) ||
                                value.toString().isEmpty) {
                              return "Please enter mobile number";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Email Address'),
                  subtitle: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(9),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Email address',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        color: Color(0xFFB5B4BD),
                        fontSize: 16.sp,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.go,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _email,
                    // Validation will be done here
                    validator: (value) {
                      // add your custom validation here.
                      if ((value.toString().isEmpty)) {
                        return 'Please enter email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$'
                        // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                      )
                          .hasMatch(value!)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                ListTile(
                  title: Text('Address'),
                  subtitle: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(9),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Address',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        color: Color(0xFFB5B4BD),
                        fontSize: 16.sp,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _address,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                  ),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('City'),
                        subtitle: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'City',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                              fontSize: 16.sp,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          controller: _city,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('Zip Code'),
                        subtitle: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'zip code',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                              fontSize: 16.sp,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          controller: _zipCode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter zip code';
                            }
                            // Regular expression pattern for US zip code (5 digits)
                            if (!RegExp(r'^\s*\d{5,10}\s*$'

                              //r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$"
                              //r'^\d{6}$'
                            )
                                .hasMatch(value!)) {
                              return 'Please enter valid zip code';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
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
                          onTap: () {
                            _form.currentState!.reset();
                            // Navigator.pushReplacement(
                            //     context,
                            //     CustomPageRoute(child: AddMember()));
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: 45.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                              color: _isButtonPressed
                              // ignore: dead_code
                                  ? Colors.white
                                  : Color(0xFFDFDFDF),
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF37304A)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      Expanded(
                        child: InkWell(
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
                          onTap: () async {
                            final isValid = _form.currentState!.validate();
                            print('isValid: $isValid');

                            if (isValid == true) {
                              print('_firstName.text: ${_firstName.text}');
                              print('_lastName.text: ${_lastName.text}');
                              print('_email.text: ${_email.text}');
                              print('_mobileNo.text: ${_mobileNo.text}');
                              print('address.text: ${_address.text}');
                              print('city.text: ${_city.text}');
                              print('zipcode.text: ${_zipCode.text}');
                              print('relation.text: ${_relation.text}');
                              // final dio = Dio();
                              // dio.interceptors.add(LogInterceptor(
                              //     requestBody: true, responseBody: true));
                              // Api call here
                              final api = ApiServices(Dio(), "/addFamilyMembers");
                              // Will get response of api.
                              final response =
                              await api.ApiUser(toJson(), context);
                              // Printing response and status code here
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response}');
                              print(
                                  'Response headers: ${response.headers[HttpHeaders.authorizationHeader]}');
                              print('Response headers: ${response.headers[HttpHeaders.authorizationHeader]}');
                              String? authorizationHeader = response.headers.value(HttpHeaders.authorizationHeader);

                              if (authorizationHeader != null) {
                                // Assuming the token is in the format "Bearer <token>"
                                String token = authorizationHeader.substring(7);
                                print(token);
                              } else {
                                print('Authorization header not found in the response.');
                              }


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
                              // Converting api json response to string.
                              response.toString();

                              //Map<String, dynamic> res = jsonDecode(decode);
                              print('Response content: $res');
                              if (response.statusCode == 201 || response.statusCode == 200) {
                                CustomSnackBar(
                                    context, 'Family member added successfully');
                                Timer(Duration(milliseconds: 1500),
                                        () => Navigator.pushReplacement(context, CustomPageRoute(child: Profile())));
                              } else {
                                // Handle API error here
                                print(
                                    'Failed to update PIN: ${res['message']}');
                              }
                            }

                            // print(res['success']);
                            // var check = res['success'];

                            //If message from api is true then will navigate to Email Otp page.
                            //if (check == true) {}
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: 45.h,
                            //width: 220.w,
                            decoration: BoxDecoration(
                              color: _isButtonPressed
                                  ? Colors.white
                                  : Color(0xFFB2A0FB),
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                "Add Member",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: InkWell(
        onTap: () {
          if (!_imageSelected) {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomSheet()),
            );
          }
        },
        child: Stack(children: <Widget>[
          CircleAvatar(
            radius: 55.r,
            foregroundImage: _imagePath!.isNotEmpty && _imagePath != null
                ? FileImage(File(_imagePath!))
                : Image.asset(
              "assets/Group 30.png",
              height: 40.h,
              //width: 0.w,
              //fit: BoxFit.contain,
            ).image,
            // foregroundImage: _imageFile == null
            //     ?  Image.asset("assets/Group 30.png",height: 40.h,
            //   //width: 0.w,
            //   //fit: BoxFit.contain,
            // ).image
            //     : FileImage(File(_imageFile!.path )),
          ),
          Positioned(
            bottom: 0.0,
            right: 5.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
                size: 25.0,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      //height: 5.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      child: Container(
        height: 120.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFA994FF),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: InkWell(
          onTap: () {
            // Do something when the bottom sheet is clicked
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    takePhoto(ImageSource.camera);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.camera_alt_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Open Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    takePhoto(ImageSource.gallery);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.image_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Choose From Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    if (familyImage != null) {
                      setState(() {
                        familyImage = null;
                        _imageSelected = false;
                      });
                    }
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Delete Current Picture",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Profile Image',
              toolbarColor: Color(0xffB2A0FB),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Profile Image',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if(croppedFile !=null){
        setState(() {
          familyImage = PickedFile(croppedFile.path) ;
          _setImagePath(croppedFile.path);
          Navigator.of(context).pop();
        });
      }
    }

    // setState(() {
    //   familyImage = PickedFile(croppedFile.path);
    //   //_imageFile = PickedFile(pickedFile.path);
    //   _setImagePath(pickedFile!.path);
    //   //_setImagePath(CroppedFile?.path);
    //
    //   // else {
    //   //   // Handle the case where pickedFile is null
    //   // }
    // });
  }

 

  Future<void> _setImagePath(String? imagePath) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = imagePath;
    });
    await _prefs.setString('imagePath', imagePath!);
  }

  void saveImage(String? path) async {
    SharedPreferences imgsave = await SharedPreferences.getInstance();
    imgsave.setString("imagepath", path!);
  }

  void loadingImage() async {
    SharedPreferences imgsave = await SharedPreferences.getInstance();
    setState(() {
      imagepath = imgsave.getString("imagepath");
    });
  }
}