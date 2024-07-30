import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Assets/CustomPageRoute.dart';
import '../../../Assets/UserModel.dart' as user;
import '../../../network/API_Services.dart';
import '../../../network/response_AlterBox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Seerecs/Screens/BottomNavigation/Profile.dart';

import '../../../network/imageservices.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({
    super.key,
    // required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.zipcode,
    required this.dob,
    required this.address,
    // required this.alternatePhone,
    // required this.alternateMail,
    required this.phone,
    required this.gender,
    // required String alternatePhone,
    // required String alternateMail
  });

  // final String id;
  final String? firstName;
  final String? lastName;
  String? email;
  final String? city;
  final String? zipcode;
  final String? dob;
  final String? address;
  final String? phone;
  final String? gender;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final form = GlobalKey<FormState>(); //for storing form state.
  //final String imagePath = 'assets/Vector (3).png';
  //Image.asset(imagePath);
//late File _imageFile;
  PickedFile? imageFile;
  ImageUploadService uploadService = ImageUploadService();


  late TextEditingController _firstName =
      TextEditingController(); // First name text field controller
  late TextEditingController _lastName =
      TextEditingController(); // Last name text field controller
  late TextEditingController _dateOfBirth =
      TextEditingController(); // Dob  text field controller
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
  late TextEditingController _gender = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  var Stringresponse;
  String? imagepath;
  //String _gender ="";

  // init state used for date picker
  @override
  void initState() {
    //GetUserApi();
    super.initState();
    loadImage();
    _initPrefs();

    //_gender = TextEditingController(text: widget.gender);
    //getUserInfo();

    _dateOfBirth.text = ""; //set the initial value of text field.
    _firstName.text = widget.firstName!;
    _lastName.text = widget.lastName!;
    _email.text = widget.email!;
    _mobileNo.text = widget.phone!;
    // _alternateMobileNo.text = widget.alternatePhone;
    // _alternateMail.text = widget.alternateMail;
    _city.text = widget.city!;
    _zipCode.text = widget.zipcode!;
    _dateOfBirth.text = widget.dob!;
    _address.text = widget.address!;
    _gender.text = "";
    _gender.text = widget.gender!;
  }

  @override
  void dispose() {
    //_gender.dispose();
    super.dispose();
  }

  // Making Json to be send to API
  Map<String, dynamic> updateProfileData() {
    return {
      (user.firstName): (_firstName.text),
      (user.lastName): (_lastName.text),
      (user.email): (_email.text.toLowerCase()),
      //(user.AlternateEmail): (_alternateMail.text.toLowerCase()),
      (user.mobile): (_mobileNo.text),
      //(user.AlternateMobile): (_alternateMobileNo.text),
      (user.address): (_address.text),
      (user.city): (_city.text),
      (user.zipCode): (_zipCode.text),
      (user.dob): (_dateOfBirth.text),
      (user.gender): (_gender.text),
      (user.profilePicture): '',
    };

  }
  Future<void> loadImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        imageFile = PickedFile(imagePath);
      });
    }
  }

  Future<void> saveImage(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', imagePath);
  }

  // Other attributes here...

  // Map<String, dynamic> updateProfileData() {
  //   var formData = {
  //     user.firstName: _firstName.text,
  //     user.lastName: _lastName.text,
  //     user.email: _email.text.toLowerCase(),
  //     // Add other fields here...
  //     (user.mobile): (_mobileNo.text),
  //     //(user.AlternateMobile): (_alternateMobileNo.text),
  //     (user.address): (_address.text),
  //     (user.city): (_city.text),
  //     (user.zipCode): (_zipCode.text),
  //     (user.dob): (_dateOfBirth.text),
  //     (user.gender): (_gender.text),
  //
  //     // Profile picture as form data
  //     user.profilePicture:'',
  //       //contentType: MediaType('image', 'png'),
  //     ),
  //   };
  //   return formData;
  // }

  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> jsonData = {
  //     user.FirstName: _firstName.text,
  //     user.LastName: _lastName.text,
  //     user.Email: _email.text.toLowerCase(),
  //     user.Mobile: _mobileNo.text,
  //     user.Address: _address.text,
  //     user.City: _city.text,
  //     user.Zipcode: _zipCode.text,
  //     user.Dob: _dateOfBirth.text,
  //     user.Gender: _gender.text,
  //   };
  //
  //   if (_imagePath.isNotEmpty) {
  //     jsonData[user.ProfilePicture] = _imagePath;
  //   }
  //
  //   return jsonData;
  // }

  //late String? _imagePath;
  String? FirstName;
  String? LastName;
  String? City;
  String? Email;
  String? Zipcode;
  String? Dob;
  String? Address;
  String? Phone;
  String? Gender;
  bool circular = false;

  bool isButtonPressed = false;
  late String val;
  bool _imageSelected = false;
  @override
  Widget build(BuildContext context) {
    //String _gender = "Select";
    return Form(
        key: form,
        child: Scaffold(
            backgroundColor: Color(0xFFECEFFC),
            appBar: AppBar(
              //automaticallyImplyLeading: true,
              leading: BackButton(
                //onPressed: () => _showAlertDialog(context),
                onPressed: () =>
                    Navigator.push(context, CustomPageRoute(child: Profile())),
                color: Color(0xff02486A), // <-- SEE HERE
              ),
              elevation: 0,
              backgroundColor: Color(0xFFECF0FD),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //color: Color(0xFFB2A0FB),
                ),
              ),
              title: Text(
                'Update Profile',
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff02486A)),
              ),
            ),
            body: SafeArea(
              // top: true,
              // bottom: true,
              // right: true,
              // left: true,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white, width: 7),
                  //borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Color(0xFFE6E5EE), Color(0xFFEEF0F7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SingleChildScrollView(
                    child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: IconButton(
                          //       onPressed: () {},
                          //       icon: Icon(
                          //         Icons.edit_square,
                          //         color: Colors.black,
                          //       )),
                          // ),
                          SizedBox(
                            height: 5.h,
                          ),
                          imageProfile(),
                          //uploadImage(),
                          // Stack(
                          //   clipBehavior: Clip.none,
                          //   //fit: StackFit.expand,
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 60.r,
                          //       backgroundImage: AssetImage("assets/Vector (3).png"),
                          //     ),
                          //     Positioned(
                          //         right: -16,
                          //         bottom: 0,
                          //         child: SizedBox(
                          //             // height: 46,
                          //             // width: 46,
                          //             child: TextButton(
                          //                 style: TextButton.styleFrom(
                          //                   shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(50),
                          //                     side: BorderSide(color: Colors.white),
                          //                   ),
                          //                   backgroundColor: Color(0xFFF5F6F9),
                          //               
                          //             ), onPressed: () {  }, child: Center(child: Icon(Icons.camera_alt_outlined)),
                          //         )))
                          //   ],
                          //
                          // ),
                          // CircleAvatar(
                          //   backgroundColor: Color(0xFFB2A0FB),
                          //   radius: 60.r,
                          //   child: Image.asset(
                          //     "assets/Vector (3).png",
                          //     height: 25.h,
                          //     //color: Colors.black,
                          //   ),
                          // ),
                          SizedBox(
                            height: 5.h,
                          ),
                          // Text('Please fill the following details correctly',
                          //   style: TextStyle(color: Color(0xFF02486A),fontWeight: FontWeight.w600, fontSize: 18.sp),),
                          // SizedBox(
                          //   height: 10,
                          // ),
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
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
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
                                    // validator: (value) {
                                    //   if (value.toString().isEmpty) {
                                    //     return "Please enter first name";
                                    //   }
                                    //   // if (nameRegExp.hasMatch(value!)) {
                                    //   //   return 'Please enter valid name';
                                    //   // }
                                    //   return null;
                                    // },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30),
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r"[a-zA-Z]+|\s"),
                                      ),
                                    ],
                                    controller: _firstName,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // onChanged: (value) {
                                    //   if (RegExp(r'\d').hasMatch(value)) {
                                    //     _firstNameHasError = true;
                                    //   } else {
                                    //     _firstNameHasError = false;
                                    //   }
                                    // },
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return 'Please enter your first name.';
                                      }
                                      if (RegExp(r'\d').hasMatch(value!)) {
                                        return 'Numbers are not allowed.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              Expanded(
                                child: ListTile(
                                  title: Text('Last Name'),
                                  subtitle: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(9),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
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
                                    controller: _lastName,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30),
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[a-zA-Z]+|\s")),
                                    ],
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
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
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text('Date of Birth'),
                                  subtitle: TextFormField(
                                    controller: _dateOfBirth,
                                    readOnly: true,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.go,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(9),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      hintText: 'DD/MM/YY',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        color: Color(0xFFB5B4BD),
                                        fontSize: 16.sp,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            color: Colors.grey[250],
                                            Icons.calendar_month_outlined),
                                        // On tap calendar will open
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime(1990),
                                                  firstDate: DateTime(1930),
                                                  lastDate: DateTime.now());

                                          String birthDate =
                                              DateFormat('MM-dd-yyyy')
                                                  .format(pickedDate!);
                                          print(birthDate);

                                          setState(
                                              () => pickedDate = pickedDate);
                                          // Picked date will be displayed on text form field
                                          print(pickedDate
                                              .toString()
                                              .substring(0, 4));
                                          int birthYear = int.parse(pickedDate
                                              .toString()
                                              .substring(0, 4));
                                          // var compareDate = DateTimeRange(start: DateTime(1930), end: DateTime(2002));
                                          if (pickedDate != null &&
                                              birthYear <= 2005) {
                                            _dateOfBirth.text = birthDate
                                                .toString()
                                                .substring(0, 10);
                                          } else {
                                            CustomSnackBar(context,
                                                'User must be 18 year old');
                                          }
                                        },
                                      ),
                                    ),
                                    // On tap calendar will open
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime(1990),
                                              firstDate: DateTime(1930),
                                              lastDate: DateTime.now());

                                      String birthDate =
                                          DateFormat('MM-dd-yyyy')
                                              .format(pickedDate!);
                                      print(birthDate);

                                      setState(() => pickedDate = pickedDate);
                                      // Picked date will be displayed on text form field
                                      // (_dateOfBirth.toString().substring(0,3) >= 2019)
                                      int birthYear = int.parse(pickedDate
                                          .toString()
                                          .substring(0, 4));
                                      // var compareDate = DateTimeRange(start: DateTime(1930), end: DateTime(2002));
                                      if (pickedDate != null &&
                                          birthYear <= 2005) {
                                        _dateOfBirth.text = birthDate
                                            .toString()
                                            .substring(0, 10);
                                      } else {
                                        CustomSnackBar(context,
                                            'User must be 18 year old');
                                      }
                                    },
                                    // Validation will be done here
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please enter date of birth";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 0,
                              // ),
                              Expanded(
                                child: ListTile(
                                  title: Text('Gender'),

                                  subtitle: DropdownButtonFormField<String>(
                                    //value: _gender.text,
                                    value: _gender.text.isNotEmpty
                                        ? _gender.text
                                        : 'Select Gender',
                                    //value: _gender.text.isEmpty ? 'Select': _gender.text ,

                                    dropdownColor: Colors.white,
                                    onChanged: (String? val) {
                                      //if (val != null) {
                                      setState(() {
                                        _gender.text = val!;
                                        print(_gender.text);
                                      });
                                      // }
                                    },
                                    items: <String>[
                                      'Select Gender',
                                      'Male',
                                      'Female',
                                      'Others'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Roboto-Regular',
                                            //fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    // value: _gender.text.isNotEmpty && items.contains(_gender.text)
                                    //     ? _gender.text
                                    //     : items.first,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(9),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      //hintText: 'Gender',
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                  //validator: (value) => value == null ? "Select" : null,
                                ),
                              ),
                            ],
                          ),
                          ListTile(
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
                              controller: _mobileNo,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.go,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.go,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // Validation will be done here
                                    // validator: (value) {
                                    //   if (value.toString().isEmpty) {
                                    //     return "Field can't be empty!";
                                    //   }
                                    //   return null;
                                    // },
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
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      hintText: 'Zip code',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        color: Color(0xFFB5B4BD),
                                        fontSize: 16.sp,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    controller: _zipCode,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
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
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, right: 8),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
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
                                    onTap: () {
                                      //final isValid =
                                      form.currentState!.reset();
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     CustomPageRoute(child: AddMember()));
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: 45.h,
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                        color: isButtonPressed
                                            ? Colors.white
                                            : Color(0xFFDFDFDF),
                                        border: Border.all(
                                            color: Colors.white, width: 3),
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
                                    // getUserInfo();
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

                                    onTap: () async {
                                      final isValid =
                                          form.currentState!.validate();
                                      if (isValid == true) {
                                        // Api call here
                                        final api = ApiServices(
                                            Dio(), "/updateProfile");
                                        final response = await api.ApiUser(
                                            updateProfileData(), context);
                                        String decodeResponse =
                                            response.toString();
                                        jsonDecode(decodeResponse);
                                        // Check if API call is successful
                                        if (response.statusCode == 200) {
                                          //_initPrefs();
                                          Map<String, dynamic> responseData =
                                              jsonDecode(response.toString());
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString('firstName',
                                              responseData['firstName'] ?? '');
                                          prefs.setString('lastName',
                                              responseData['lastName'] ?? '');
                                          prefs.setString('city',
                                              responseData['city'] ?? '');
                                          prefs.setString('zipcode',
                                              responseData['zipcode'] ?? '');
                                          prefs.setString('email',
                                              responseData['email'] ?? '');
                                          prefs.setString(
                                              'dob', responseData['dob'] ?? '');
                                          prefs.setString('address',
                                              responseData['address'] ?? '');
                                          prefs.setString('phone',
                                              responseData['phone'] ?? '');
                                          prefs.setString('gender',
                                              responseData['gender'] ?? '');
                                          setState(() {
                                            FirstName =
                                                responseData['firstName'] ?? '';
                                            LastName =
                                                responseData['lastName'] ?? '';
                                            City = responseData['city'] ?? '';
                                            Email = responseData['email'] ?? '';
                                            Zipcode =
                                                responseData['zipcode'] ?? '';
                                            Dob = responseData['dob'] ?? '';
                                            Address =
                                                responseData['address'] ?? '';
                                            Phone = responseData['phone'] ?? '';
                                            Gender =
                                                responseData['gender'] ?? '';
                                          });
                                          print('Debug: gender: $Gender');
                                          uploadService.uploadImage(imageFile);
                                          //saveImage(_imageFile!.path);
                                          // if (imageFile != null) {
                                          //   saveImage(imageFile!.path);
                                          // }

                                          CustomSnackBar(context,
                                              'Profile Updated Successfully');
                                          Navigator.push(
                                              context,
                                              CustomPageRoute(
                                                  child: Profile()));
                                          //Navigator.pop(context,Profile(FirstName: FirstName, LastName: LastName, City: City, Imagepath: '',));

                                          print('user called');
                                        } else {
                                          print(
                                              'Failed to update profile. Status code: ${response.statusCode}');
                                          print(
                                              'Error: ${response.statusCode} - ${response.data}');
                                        }
                                      }
                                    },
                                    // on DioError catch (e) {
                                    //     // Handle Dio errors
                                    //     print('DioError: $e');
                                    //   } catch (e) {
                                    //     // Handle other errors
                                    //     print('Error: $e');
                                    //   }
                                    //},
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: 45.h,
                                      width: 180.w,
                                      decoration: BoxDecoration(
                                        color: isButtonPressed
                                            ? Colors.white
                                            : Color(0xFFB2A0FB),
                                        border: Border.all(
                                            color: Colors.white, width: 3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Update",
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
                        ]),
                  ),
                ),
              ),
            )));
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
            radius: 75.r,
            // foregroundImage: _imagePath != null && _imagePath.isNotEmpty
            //     ? FileImage(File(_imagePath!))
            //     : Image.asset(
            //         "assets/Group 30.png",
            //         height: 40.h,
            //         //width: 0.w,
            //         //fit: BoxFit.contain,
            //       ).image,
            foregroundImage: imageFile != null
                ? FileImage(File(imageFile!.path))
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
        borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                    if (imageFile != null) {
                      setState(() {
                        imageFile = null;
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

  // Future<void> selectImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(source: source);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = pickedFile;
  //     });
  //     await cropImage(_imageFile!.path);
  //   }
  // }

  // Future<void> cropImage(String imagePath) async {
  //   final croppedFile = await ImageCropper().cropImage(
  //     sourcePath: imagePath,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Crop Profile Image',
  //           toolbarColor: Color(0xffB2A0FB),
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Crop Profile Image',
  //       ),
  //       WebUiSettings(
  //         context: context,
  //       ),
  //     ],
  //   );
  //   if (croppedFile != null) {
  //     _imageFile = croppedFile as PickedFile?;
  //   }
  // }

  // Future<void> uploadImage() async {
  //   if (_imageFile != null) {
  //     try {
  //       Dio dio = Dio();
  //       String apiUrl = 'YOUR_UPLOAD_ENDPOINT_HERE';
  //
  //       FormData formData = FormData.fromMap({
  //         'profilePicture': await MultipartFile.fromFile(_imageFile!.path),
  //       });
  //
  //       await dio.post(apiUrl, data: formData);
  //
  //       // Handle success
  //     } catch (error) {
  //       print('Error uploading image: $error');
  //       // Handle error
  //     }
  //   } else {
  //     print('No image selected.');
  //     // Handle no image selected
  //   }
  // }

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
      if (croppedFile != null) {
        setState(() {
          //_imageFile = PickedFile(pickedFile.path);
          imageFile = PickedFile(croppedFile.path);
        });
        uploadService.uploadImage(imageFile);
        saveImage(croppedFile.path);
        Navigator.of(context).pop();
      }
      //   try {
      //     FormData formData = FormData.fromMap({
      //       'profilePicture': await MultipartFile.fromFile(croppedFile!.path),
      //     });
      //     // FormData formData = FormData.fromMap({
      //     //   'files': [
      //     //     await MultipartFile.fromFile(_imagePath, filename: _imagePath.split('/').last),
      //     //   ],
      //     // });
      //     var dio = Dio();
      //     final response? = await dio.post('https://seerecs.org/user/updateprofile', data: formData);
      //
      //     // Handle response? here
      //     // Example:
      //     if (response?.statusCode == 200) {
      //       // Image uploaded successfully
      //       print('Image uploaded successfully');
      //     } else {
      //       // Handle error
      //       print('Failed to upload image: ${response?.data}');
      //     }
      //   } catch (e) {
      //     print('Error uploading image: $e');
      //   }
    }
  }
  Future<void> _initPrefs() async {

    setState(() {
    });
  }

  Future<void> _setImagePath(String _imageFile) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
    });
    await _prefs.setString('imagePath', _imageFile);
  }

  // void saveImage(String path) async {
  //   SharedPreferences imgsave = await SharedPreferences.getInstance();
  //   imgsave.setString("imagepath", path);
  // }
  //
  // void loadImage() async {
  //   SharedPreferences imgsave = await SharedPreferences.getInstance();
  //   setState(() {
  //     _imageFile = imgsave.getString("imagepath")!;
  //   });
  // }

  Future<void> uploadImage() async {
    try {
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(imageFile!.path),
      });
      // FormData formData = FormData.fromMap({
      //   'files': [
      //     await MultipartFile.fromFile(_imagePath, filename: _imagePath.split('/').last),
      //   ],
      // });
      var dio = Dio();
      final response = await dio.post('/updateprofile', data: formData);

      // Handle response? here
      // Example:
      if (response.statusCode == 200) {
        // Image uploaded successfully
        print('Image uploaded successfully');
      } else {
        // Handle error
        print('Failed to upload image: ${response.data}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Map<String, dynamic> formDataToMap(FormData formData) {
    Map<String, dynamic> formDataMap = {};
    for (MapEntry<String, dynamic> entry in formData.fields) {
      formDataMap[entry.key] = entry.value.toString();
    }
    return formDataMap;
  }
}
// void saveImage(String path) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('imagePath', path);
//   }

//   Future<void> _initPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _imagePath = prefs.getString('imagePath') ?? '';
//     });
//   }

//   void uploadImage(String imagePath) async {
//     try {
//       FormData formData = FormData.fromMap({
//         'files': [
//           await MultipartFile.fromFile(imagePath,
//               filename: imagePath.split('/').last),
//         ],
//       });
//       var dio = Dio();
//       final api = ApiServices(Dio(), "/updateprofile");
//
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
// }
// Future<void> _showAlertDialog(BuildContext context) async {
//    return showDialog(
//   context: context,
//   builder: (context) {
//     return Dialog(
//       backgroundColor: Colors.transparent, // Set transparent background color for the dialog
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white, // Set desired background color here
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Color(0xFFB1A0FB),width: 3)
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(height: 30),
//                   Text(
//                     "Congratulations!",
//                     style: TextStyle(
//                       fontFamily: 'Roboto-Regular',
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff02486A),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     "Account has been created.\nTo rule your health records kindly Sign in.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'Roboto-Regular',
//                       fontSize: 16.sp,
//                       color: Color(0xff02486A),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).popUntil((route) => route.isFirst);
//                     },
//                     child: Container(
//                       height: 40.h,
//                       width: 120.w,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFB1A0FB),
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.white, width: 2),
//                         boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2), // Set shadow color here
//                     spreadRadius: 2, // Set spread radius here
//                     blurRadius: 4, // Set blur radius here
//                     offset: Offset(0, 2), // Set offset here
//                   ),
//                 ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Sign in",
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             top: 0,
//             child: Image.asset(
//               "assets/Group 4.png",
//               height: 50,
//               width: 50,
//             ),
//           ),
//           Positioned(
//             right: 0,
//             bottom: 0,
//             child: Image.asset(
//               "assets/Group 5.png",
//               height: 50,
//               width: 50,
//             ),
//           ),
//         ],
//       ),
//     );
//   },
// );

// }
