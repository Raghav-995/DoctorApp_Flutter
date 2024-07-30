import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Seerecs/Screens/CareTeam/GetCareTeam.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Assets/CustomPageRoute.dart';
import '../../network/Response_AlterBox.dart';

class UpdateCareTeam extends StatefulWidget {
  //const UpdateCareTeam({super.key, this.careTeamName, this.careTeamId});
  const UpdateCareTeam({Key? key, required this.careTeamName, required this.careTeamId}) : super(key: key);
  final String careTeamName;
  final String careTeamId;
  @override
  State<UpdateCareTeam> createState() => _UpdateCareTeamState();
}

class _UpdateCareTeamState extends State<UpdateCareTeam> {
  final ImagePicker _picker = ImagePicker();
  // String? careImagePath = '';
  // PickedFile? imageFile;
  // String? loadImagePath;
  bool imageSelected = false;
  PickedFile? profilePicture;
//String careTeamId = "";

// Map<String, dynamic> updateCareTeamData() {
//     var formData = {
//       care.careTeamId: careTeamId.toString(),
//       care.profilePicture:'',
//     };
//     return formData;
//   }
  void updateCareTeamApi(PickedFile profilePicture) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String? obtainedToken = sharedPreferences.getString('token');
    // obtainedToken converted to string
    obtainedToken.toString();
    print(obtainedToken);
    // Create Dio instance
    Dio dio = Dio();
    try {
      // Create FormData object
      // FormData formData = FormData();
      //  formData.fromMap({'careTeamId': careTeamId});
      // var formData = FormData.from({
      //   'careTeamId': careTeamId,
      // });
      FormData formData = FormData();


      // formData.fields.addAll({
      //   for (var entry in {'careTeamId': careTeamId}.entries) MapEntry(entry.key, entry.value)
      // });


      //formData.fields.add(MapEntry('careTeamId', widget.careTeamId));
      formData.fields.add(MapEntry('careTeamId', widget.careTeamId));
          // Add careteamid and provider as a field
      //  formData.fields.add(MapEntry({
      //   'careTeamId': (care.careTeamId),
      // //   'providers': 'dummyValueForProviders'),
      // });
     //formData.fields.add(MapEntry('careTeamId', careTeamId));
      //formData.fields.add(MapEntry('careTeamId', ''));
     //  formData.add(
     //      'careTeamId',
     //      careTeamId
     //  );

      // Add careTeamId as a field
      // formData.fields.add(MapEntry('careTeamId', careTeamId.toString()));
//FormData.fromMap('careTeamId');
      // Add profile picture
      //final profilePicture = this.profilePicture;
      formData.files.add(MapEntry(
        'profilePicture',
        await MultipartFile.fromFile(
          profilePicture.path,
          filename: path.basename(profilePicture
              .path),
        ),
      ));
          Response response = await dio.request('https://seerecs.org/user/updateCareTeam',
        options: Options(
          method: 'POST',
          headers: {'Authorization': 'Bearer $obtainedToken'},
        ),
        data: formData,
      );
      // Map<String, dynamic> responseData = response.data;
      //
      // // Extract the careTeamId from the parsed data
      // String careTeamId = responseData['careTeamId'];
      if (response.statusCode == 200 || response.statusCode == 201) {

        CustomSnackBar(context, 'Updated added successfully');
        //Timer(Duration(milliseconds: 1500), () => Navigator.pop(context));
        // Timer(Duration(milliseconds: 1500), () => Navigator.push(
        //     context,
        //     CustomPageRoute(
        //         child: GetCareteam(careTeamId: widget.careTeamId,
        //         ))));
        String profileImagePath = response.data['careTeam']['profileImagePath'];
        String careTeamName = response.data['careTeam']['careTeamName'];
        // Navigate to the next screen with the extracted data
        navigateToNextScreen(context, profileImagePath, careTeamName);
        // Handle response
        print(response.data);
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }
  void navigateToNextScreen(BuildContext context, String profileImagePath, String careTeamName) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GetCareteam(
          profileImagePath: profileImagePath,
          careTeamName: careTeamName,
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    loadImagePath(widget.careTeamId).then((path) {
      if (path != null) {
        setState(() {
          profilePicture = PickedFile(path);
        });
      }
    });
  }

  late TextEditingController nameController = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    bool isButtonPressed = false;
    return Form(
      key: form,
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
            context,CustomPageRoute(child: GetCareteam())),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xFFB2A0FB),
            ),
          ),
          title: Text(
            'Edit Care Team',
            style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37304A)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageProfile(widget.careTeamId),
              SizedBox(
                height: 50,
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     "Add Personalized Care Team",
              //     style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.w700,
              //         color: Color(0xFF02486A)),
              //   ),
              // ),
              // SizedBox(
              //   height: 15.h,
              // ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Care Team Name",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF02486A)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              TextFormField(
                keyboardType: TextInputType.text,
                initialValue: widget.careTeamName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    color: Color(0xFFB5B4BD),
                  ),
                  hintText: 'Please enter care team name',
                ),
                validator: (value) {
                  // Uncomment this block for validation logic
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid name";
                  }
                  // Additional validation logic can be added here
                  return null; // Return null if input is valid
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 55),
              //   child: Text("A care team is a group of healthcare professionals working collaboratively to "
              //       "provide comprehensive and coordinated care to meet the diverse needs of a you.",style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       color: Color(0xFF737081)),textAlign: TextAlign.center,),
              // ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                            isButtonPressed = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isButtonPressed = false;
                          });
                        },
                        onTap: () async {


                          final isValid = form.currentState!.validate();
                          if(isValid == true){
                            updateCareTeamApi(profilePicture!);
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: 45.h,
                          //width: 220.w,
                          decoration: BoxDecoration(
                            color: isButtonPressed
                                ? Colors.white
                                : Color(0xFFB2A0FB),
                            border: Border.all(color: Colors.white, width: 3),
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
              Center(
                  child: Image.asset(
                "assets/editCare.png",
                height: 230.h,
              )),
            ],
          ),
        ),
      ),
    );
  }

  // Widget imageProfile() {
  //   return Center(
  //     child: InkWell(
  //       onTap: () {
  //         if (!imageSelected) {
  //           showModalBottomSheet(
  //             context: context,
  //             builder: ((builder) => bottomSheet()),
  //           );
  //         }
  //       },
  //       child: Stack(children: <Widget>[
  //         CircleAvatar(
  //           radius: 65.r,
  //           foregroundImage: profilePicture != null
  //               ? FileImage(File(profilePicture!.path))
  //               : Image.asset(
  //                   "assets/Group 30.png",
  //                   height: 40.h,
  //                 ).image,
  //         ),
  //         Positioned(
  //           bottom: 0.0,
  //           right: 5.0,
  //           child: CircleAvatar(
  //             backgroundColor: Colors.white,
  //             child: Icon(
  //               Icons.camera_alt_outlined,
  //               color: Colors.black,
  //               size: 25.0,
  //             ),
  //           ),
  //         ),
  //       ]),
  //     ),
  //   );
  // }
  Widget imageProfile(String careTeamId) {
    return FutureBuilder(
      future: loadImagePath(careTeamId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(); // Or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String? imagePath = snapshot.data;
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
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 65.r,
                    foregroundImage: imagePath != null
                        ? FileImage(File(imagePath))
                        : Image.asset(
                      "assets/Group 30.png",
                      height: 40.h,
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
                ],
              ),
            ),
          );
        }
      },
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
                    if (profilePicture != null) {
                      setState(() {
                        profilePicture = null;
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
  void saveImagePath(String careTeamId, String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String?> imagePathMap = Map<String, String>.from(jsonDecode(prefs.getString('profileImagePathMap') ?? '{}'));
    imagePathMap[careTeamId] = imagePath;
    await prefs.setString('profileImagePathMap', jsonEncode(imagePathMap));
  }



  Future<String?> loadImagePath(String careTeamId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> imagePathMap = jsonDecode(prefs.getString('profileImagePathMap') ?? '{}');
    return imagePathMap[careTeamId];
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
              toolbarColor: Colors.deepOrange,
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
          profilePicture = PickedFile(croppedFile.path);
          saveImagePath(widget.careTeamId, profilePicture!.path);
          Navigator.of(context).pop();

          // _setImagePath(croppedFile.path);
          //_setImagePath(CroppedFile?.path);

          // else {
          //   // Handle the case where pickedFile is null
          // }
        });
      }
    }


    // setState(() {
    //   //_imageFile = PickedFile(pickedFile.path);
    //   _setImagePath(pickedFile!.path);
    //   //_setImagePath(CroppedFile?.path);

    //   // else {
    //   //   // Handle the case where pickedFile is null
    //   // }
    // });
  }
}
