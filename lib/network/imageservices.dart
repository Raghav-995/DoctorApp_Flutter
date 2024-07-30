// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:Seerecs/network/DioExceptions.dart';
// import 'package:Seerecs/network/EndPoints.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Assets/CustomPageRoute.dart';
// import '../Screens/EnterPin.dart';
// import '../Screens/LoginScreen.dart';
// import '../Screens/PinAuth.dart';
// import 'response?_AlterBox.dart';
//
// // Api services
// class ImageServices {
//   // Dio client
//   final Dio _dio;
//
//   // Constant connection time
//   static const int CONNECT_TIMEOUT = 10;
//
//   // Api endpoint
//   final String api;
//
//   ImageServices(this._dio, this.api);
//
//   // Api request
//   Future<response> ImageUser(
//       FormData Data, BuildContext context) async {
//     final SharedPreferences sharedPreferences =
//     await SharedPreferences.getInstance();
//     // Token from api will be stored in obtainedToken variable.
//     String? obtainedToken = sharedPreferences.getString('token');
//     // obtainedToken converted to string
//     obtainedToken.toString();
//     print(obtainedToken);
//     // Circular progress indicator start
//     setLoading(true, context);
//     try {
//       //  Api request send to server
//       if (obtainedToken == null) {
//         final response? =
//         await _dio.post('${EndPoints.baseUrl}$api', data: Data).timeout(
//           Duration(seconds: CONNECT_TIMEOUT),
//           // if connection time out Dialog box will appear
//           onTimeout: () {
//             return showCustomDialog(
//                 context, 'Error', "Timeout, please check your connection");
//           },
//         );
//         // Circular progress indicator stops
//         setLoading(false, context);
//         // response? print
//         print('response? : ${response?.statusCode}');
//         print('response? body: ${response?.data}');
//         return response?;
//       } else {
//         final response? = await _dio
//             .post('${EndPoints.baseUrl}$api',
//             data: Data,
//             options: Options(
//                 headers: {'Authorization': 'Bearer $obtainedToken'}))
//             .timeout(
//           Duration(seconds: CONNECT_TIMEOUT),
//           // if connection time out Dialog box will appear
//           onTimeout: () {
//             return showCustomDialog(
//                 context, 'Error', "Timeout, please check your connection");
//           },
//         );
//         // Circular progress indicator stops
//         setLoading(false, context);
//         // response? print
//         print('response? : ${response?.statusCode}');
//         print('response? body: ${response?.data}');
//         return response?;
//       }
//
//       // Errors / Exceptions will be catch here
//     } catch (e) {
//       // If exception occurs circular progress indicator stops
//       setLoading(false, context);
//       // Error / Exceptions will be print in console
//       print(e);
//       // Exception type will be converted to dynamic
//       dynamic err = e;
//       // Any exception message will be save in errorMessage
//       final errorMessage = DioExceptions.fromDioError(err).toString();
//       // errorMessage print
//       print(errorMessage);
//       // showCustomDialog(context, 'Error', errorMessage);
//       if (errorMessage == 'Unauthorized!') {
//         String token = '';
//         final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//         // Token from api will be stored in obtainedToken variable.
//         sharedPreferences.setString('token', token);
//         // obtainedToken converted to string
//         obtainedToken.toString();
//         print(obtainedToken);
//
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setInt('Unauthorized', 1);
//         Navigator.pushReplacement(context, CustomPageRoute(child: EnterPin()));
//       }else if(errorMessage=='Token expired, Please login again'){
//         Navigator.pushReplacement(context, CustomPageRoute(child: LoginScreen()));
//       }
//       // else if (errorMessage == 'Unauthorized!, Please login again'){
//       //   //print('called');
//       //   Navigator.pushReplacement(context, CustomPageRoute(child: LoginScreen()));
//       // }else if (errorMessage == 'Unauthorized!, Please login again' && errorMessage=='Token expired, Please login again'){
//       //   //print('called');
//       //   Navigator.pushReplacement(context, CustomPageRoute(child: LoginScreen()));
//       // }
//       else {
//         // Error message will be given to showCustomDialog() function
//         showCustomDialog(context, 'Error', errorMessage);
//       }
//       throw (e);
//     }
//   }
//   // Map<String, dynamic> formDataToMap(FormData formData) {
//   //   Map<String, dynamic> formDataMap = {};
//   //   for (MapEntry<String, dynamic> entry in formData.fields) {
//   //     formDataMap[entry.key] = entry.value.toString();
//   //   }
//   //   return formDataMap;
//   }

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class ImageUploadService {
  Future<String?> uploadImage(PickedFile? imageFile) async {
    try{
      Dio dio = Dio();
      if(imageFile !=null && imageFile.path.isNotEmpty){
        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        String? obtainedToken = sharedPreferences.getString('token');
        // obtainedToken converted to string
        obtainedToken.toString();
        print(obtainedToken);
        // MultipartFile multipartFile = await MultipartFile.fromFile(
        //   imageFile.path,
        //   filename: path.basename(imageFile.path),
        // );
        // FormData data = FormData.fromMap({
        //   'profilePicture': multipartFile,
        // });
        FormData data = FormData();

        // Callback function to create MultipartFile
        Future<void> addProfilePicture() async {
          MultipartFile multipartFile = await MultipartFile.fromFile(
            imageFile.path,
            filename: path.basename(imageFile.path),
          );
          data.files.add(MapEntry('profilePicture', multipartFile)); // Use FormData.files
        }

        // Call the callback function
        await addProfilePicture();
        Response response = await dio.post('https://seerecs.org/user/updateprofile',
            options: Options(
              method: 'POST',
              headers: {'Authorization': 'Bearer $obtainedToken'},
            ),
            data: data);

        if(response.statusCode == 200){
          print('Image uploaded');

          //saveImagePath(imageFile.path);
          print(response.data);
          saveImageBytes(imageFile);
          //return imageFile.path;
        }else{
          print('Failed Image uploaded. error: ${response.statusCode}');
        }
      }
    }catch(error){
      print('error : $error');
    }
    return null;
  }
  Future<void> saveImageBytes(PickedFile imageFile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> bytes = await imageFile.readAsBytes();
    String imageData = base64Encode(bytes);
    prefs.setString('uploadedImage', imageData);
  }

  Future<Uint8List?> getSavedImageBytes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imageData = prefs.getString('uploadedImage');
    if (imageData != null) {
      return base64Decode(imageData);
    }
    return null;
  }
  // Future<void> saveImagePath(String imagePath) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('uploadedImagePath', imagePath);
  // }
}