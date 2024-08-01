import 'dart:async';
import 'dart:io';
import 'package:Seerecs/Screens/CareTeam/GetProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Seerecs/Assets/CareTeamModel.dart' as care;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Assets/CustomPageRoute.dart';
import '../../network/response_AlterBox.dart';

class AddProvider extends StatefulWidget {
  AddProvider({super.key, this.careTeamName, this.careTeamId});

  final String? careTeamName;final String? careTeamId;
  @override
  State<AddProvider> createState() => _AddProviderState();
}

class _AddProviderState extends State<AddProvider> {
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
  TextEditingController(); 
  late TextEditingController _address =
  TextEditingController(); // Address text field controller
  late TextEditingController _city =
  TextEditingController(); // City text field controller
  late TextEditingController _zipCode =
  TextEditingController(); // Zip code text field controller
  //late TextEditingController _relation = TextEditingController();
  late TextEditingController _designation = TextEditingController();
  late TextEditingController _network = TextEditingController();
  //late TextEditingController _state = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void initState() {
    super.initState();
  }

  String? imagePath = " ";
  PickedFile? providerImage;
  String? loadImagePath;
  bool imageSelected = false;
  FormData providerData() {
    FormData formData = FormData();
    formData.fields.addAll([
      MapEntry(care.firstName, _firstName.text),
      MapEntry(care.lastName, _lastName.text),
      MapEntry(care.emailAddress, _email.text.toLowerCase()),
      MapEntry(care.contactNo, _mobileNo.text),
      MapEntry(care.address, _address.text),
      MapEntry(care.city, _city.text),
      MapEntry(care.zipCode, _zipCode.text),
      MapEntry(care.designation, _designation.text),
      MapEntry(care.network, _network.text),
      MapEntry(care.careTeamId, widget.careTeamId ?? ""),
     // MapEntry('profileImagePath', multipartFile),
    ]);
    if (providerImage != null) {
      String fileName = providerImage!.path.split('/').last;
      MultipartFile profilePicture = MultipartFile.fromFileSync(
        providerImage!.path,
        filename: fileName,
      );
      formData.files.add(MapEntry('profilePicture', profilePicture));
    }
    return formData;
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
            onPressed: () => Navigator.pop(
                context
                ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xFFB2A0FB),
            ),
          ),
          title: Text(
            'Add Provider',
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
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
                
                imageProfile(),
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
                        title: Text('Designation'),
                        subtitle: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Designation',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                              fontSize: 16.sp,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z]+|\s")),
                          ],
                          controller: _designation,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Please enter designation";
                            }
                            return null;
                          },
                        ),
                      ),
                     
                    ),
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
                            hintText: '+1(123) 456-7890 | +919876543210',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Color(0xFFB5B4BD),
                              fontSize: 16.sp,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _mobileNo,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // Validation will be done here
                          validator: (value) {
                           // final isDigitsOnly = int.tryParse(value!);
                            // US phone number validation regex
                            final _usPhoneRegex = RegExp(r'^\+1\(\d{3}\) \d{3}-\d{4}$');
                            // India phone number validation regex
                            final _indiaPhoneRegex = RegExp(r'^\+91[6-9]\d{9}$');

                            if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number';
                            }
                            if (_usPhoneRegex.hasMatch(value) || _indiaPhoneRegex.hasMatch(value)) {
                                  return null;
                            }
                                  return 'Enter a valid US or India phone number';
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Network'),
                  subtitle: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(9),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Network',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        color: Color(0xFFB5B4BD),
                        fontSize: 16.sp,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _network,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
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
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
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
                    textInputAction: TextInputAction.next,
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
                          textInputAction: TextInputAction.next,
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
                        child: GestureDetector(
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
                        child: _isButtonPressed? CircularProgressIndicator(): GestureDetector(
                         // onTapDown: (_) {
                           // setState(() {
                             // _isButtonPressed = true;
                            //});
                          //},
                          //onTapUp: (_) {
                            //setState(() {
                             // _isButtonPressed = false;
                            //});
                          //},
                          onTap: () async {
                            setState(() {
                              _isButtonPressed = true;
                            });
                            final isValid = _form.currentState!.validate();
                            print('isValid: $isValid');

                            if (isValid == true) {
                              try {
                                // Api call here
                                final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                                final String? obtainedToken =
                                sharedPreferences.getString('token');

                                if (obtainedToken == null) {
                                  throw Exception('Token not found in SharedPreferences');
                                }

                                final Dio dio = Dio();
                                final response = await dio.request(
                                  'https://seerecs.org/user/addProvider',
                                  options: Options(
                                    method: 'POST',
                                    headers: {'Authorization': 'Bearer $obtainedToken'},
                                  ),
                                  data: providerData(),
                                );
                                String profileImagePath = response.data['provider']['profileImagePath']?? 'kk';
                                print('response status: ${response.statusCode}');
                                print('response body: ${response}');
                                print('response headers: ${response.headers[HttpHeaders.authorizationHeader]}');

                                if (response.statusCode == 200 || response.statusCode == 201) {
                                  CustomSnackBar(context, 'Provider added successfully');
                                      Navigator.push(context, CustomPageRoute(child:
                                      getProvider(careTeamId: widget.careTeamId, careTeamName: widget.careTeamName,profileImagePath:profileImagePath ,)));
                                } else {
                                  // Handle API error here
                                  print('Failed to update: ');
                                }
                              } catch (e) {
                                // Handle any exceptions that occur during the API call
                                print('Error occurred: $e');
                              }setState(() {
                                isLoading = false;
                              });
                            }
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
                                "Add Provider",
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
                ), if(isLoading)
                CircularProgressIndicator()
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
          if (!imageSelected) {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomSheet()),
            );
          }
        },
        child: Stack(children: <Widget>[
          CircleAvatar(
            radius: 55.r,
            backgroundImage: providerImage != null
                ? FileImage(File(providerImage!.path))
                : Image.asset(
              "assets/Group 30.png",
              height: 40.h,
              //width: 0.w,
              //fit: BoxFit.contain,
            ).image,
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
                    if (providerImage != null) {
                      setState(() {
                        providerImage = null;
                        imageSelected = false;
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
        providerImage = PickedFile(croppedFile.path) ;
        //providerImage = PickedFile(pickedFile.path);
        //saveImagePath(widget.careTeamId, profilePicture!.path);
        Navigator.of(context).pop();
      });
    }
    }
  }

}
Future<void> saveImage(String imagePath) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('imagePath', imagePath);
}
