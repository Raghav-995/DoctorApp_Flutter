// import 'dart:async';
// import 'package:Seerecs/main.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:Seerecs/network/DioExceptions.dart';
// import 'package:Seerecs/network/EndPoints.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Assets/CustomPageRoute.dart';
// import '../Screens/EnterPin.dart';
// import 'Response_AlterBox.dart';
//
// // Api services
// class ApiServices {
//   // Dio client
//   final Dio _dio;
//
//   // Constant connection time
//   static const int CONNECT_TIMEOUT = 10;
//
//   // Api endpoint
//   final String api;
//
//   ApiServices(this._dio, this.api);
//
//   // Api requests
//   Future<Response> ApiUser(
//       Map<String, dynamic> userData, BuildContext context) async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
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
//         final response =
//             await _dio.post('${EndPoints.baseUrl}$api', data: userData).timeout(
//           Duration(seconds: CONNECT_TIMEOUT),
//           // if connection time out Dialog box will appear
//           onTimeout: () {
//             return showCustomDialog(
//                 context, 'Error', "Timeout, please check your connection");
//           },
//         );
//         // Circular progress indicator stops
//         setLoading(false, context);
//         // Response print
//         print('Response : ${response.statusCode}');
//         print('Response body: ${response.data}');
//         return response;
//       } else {
//         final response = await _dio
//             .post('${EndPoints.baseUrl}$api',
//                 data: userData,
//                 options: Options(headers: {
//                   'Authorization': 'Bearer $obtainedToken',
//                 }))
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
//         // Response print
//         print('Response : ${response.statusCode}');
//         print('Response body: ${response.data}');
//         return response;
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
//             await SharedPreferences.getInstance();
//         // Token from api will be stored in obtainedToken variable.
//         sharedPreferences.setString('token', token);
//         // obtainedToken converted to string
//         obtainedToken.toString();
//         print(obtainedToken);
//
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setInt('Unauthorized', 1);
//         Navigator.pushReplacement(context, CustomPageRoute(child: EnterPin()));
//       } else {
//         // Error message will be given to showCustomDialog() function
//         showCustomDialog(context, 'Error', errorMessage);
//       }
//       throw (e);
//     }
//   }
// }
// // Api request
//

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Assets/CustomPageRoute.dart';
import '../Screens/EnterPin.dart';
import '../Screens/LoginScreen.dart';
import 'DioExceptions.dart';
import 'EndPoints.dart';
import 'Response_AlterBox.dart';

// Api services
class ApiServices {
  // Dio client
  final Dio _dio;

  // Constant connection time
  static const int CONNECT_TIMEOUT = 10;

  // Api endpoint
  final String api;

  ApiServices(this._dio, this.api);

  // Api request
  Future<Response> ApiUser(
      Map<String, dynamic> userData, BuildContext context) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    // Token from api will be stored in obtainedToken variable.
    String? obtainedToken = sharedPreferences.getString('token');
    // obtainedToken converted to string
    obtainedToken.toString();
    print(obtainedToken);
    // Circular progress indicator start
    setLoading(true, context);
    try {
      if (obtainedToken == null) {
        final response = await _dio.post('${EndPoints.baseUrl}$api', data: userData).timeout(
          Duration(seconds: CONNECT_TIMEOUT),
          onTimeout: () {
            return showCustomDialog(context, 'Error', "Timeout, please check your connection");
          },
        );
        setLoading(false, context);
        print('Response : ${response.statusCode}');
        print('Response body: ${response.data}');
        return response; // Return the response here
      } else {
        // final response = await _dio.post(
        //   '${EndPoints.baseUrl}$api',
        //   data: userData,
        //   options: Options(headers: {'Authorization': 'Bearer $obtainedToken'}),
        final response = await _dio.post(
          '${EndPoints.baseUrl}$api',
          data: userData,
          // ignore: unnecessary_null_comparison
          options: obtainedToken!= null
              ? Options(headers: {'Authorization': 'Bearer $obtainedToken'})
              : null, // Don't include authorization header if token is null
        ).timeout(
          Duration(seconds: CONNECT_TIMEOUT),
          onTimeout: () {
            return showCustomDialog(context, 'Error', "Timeout, please check your connection");
          },
        );
        setLoading(false, context);
        print('Response : ${response.statusCode}');
        print('Response body: ${response.data}');
        return response; // Return the response here
      }
    } catch (e) {
      setLoading(false, context);
      print(e);
      dynamic err = e;
      final errorMessage = DioExceptions.fromDioError(err).toString();
      print(errorMessage);
      // throw e; // Re-throw the exception after handling it
      // showCustomDialog(context, 'Error', errorMessage);
      if (errorMessage == 'Unauthorized!') {
        String token = '';
        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        // Token from api will be stored in obtainedToken variable.
        sharedPreferences.setString('token', token);
        // obtainedToken converted to string
        obtainedToken.toString();
        print(obtainedToken);
        // final SharedPreferences sharedPreferences =
        // await SharedPreferences.getInstance();
        // // Token from api will be stored in obtainedToken variable.
        // Future<bool> obtainedToken = sharedPreferences.setString('token',token);
        // // obtainedToken converted to string
        // obtainedToken.toString();
        // print(obtainedToken);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('Unauthorized', 1);
        Navigator.pushReplacement(context, CustomPageRoute(child: EnterPin()));
        //if (e.response.statusCode == 401) {
          // Unauthorized error
          // Implement token refresh logic here if available
          // For now, let's reset the token and navigate to re-enter pin
          // sharedPreferences.remove('token');
          // Navigator.pushReplacement(context, CustomPageRoute(child: EnterPin()));

      } else if (errorMessage == 'Token expired, Please login again') {
        Navigator.pushReplacement(
            context, CustomPageRoute(child: LoginScreen()));
      } else if (errorMessage == 'Unauthorized!, Please login again') {
        //print('called');
        Navigator.pushReplacement(
            context, CustomPageRoute(child: LoginScreen()));
      } else if (errorMessage == 'Unauthorized!, Please login again' &&
          errorMessage == 'Token expired, Please login again') {
        //print('called');
        Navigator.pushReplacement(
            context, CustomPageRoute(child: LoginScreen()));
      }
      else {
        // Error message will be given to showCustomDialog() function
        showCustomDialog(context, 'Error', errorMessage);
      }
      throw (e);
    }
  }

  // Future<Response> refreshToken() async {
  //   var response = await Dio().post(APIs.refreshToken,
  //       options: Options(
  //           headers: {"Refresh-Token": "refresh-token" }));
  //   // on success response, deserialize the response
  //   if (response.statusCode == 200) {
  //     // LoginRequestResponse requestResponse =
  //     //    LoginRequestResponse.fromJson(response.data);
  //     // UPDATE the STORAGE with new access and refresh-tokens
  //     return response;
  //   }
  // }
  // Future<Response> ApiUser(Map<String, dynamic> userData, BuildContext context) async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? obtainedToken = sharedPreferences.getString('token');
  //   //obtainedToken = obtainedToken.toString(); // Not necessary
  //
  //   setLoading(true, context);
  //
  //   try {
  //     Response response;
  //     if (obtainedToken == null) {
  //       response = await _dio.post('${EndPoints.baseUrl}$api', data: userData).timeout(
  //         Duration(seconds: CONNECT_TIMEOUT),
  //         onTimeout: () {
  //           return showCustomDialog(context, 'Error', "Timeout, please check your connection");
  //         },
  //       );
  //     } else {
  //       response = await _dio.post('${EndPoints.baseUrl}$api',
  //           data: userData,
  //           options: Options(headers: {'Authorization': 'Bearer $obtainedToken'})).timeout(
  //         Duration(seconds: CONNECT_TIMEOUT),
  //         onTimeout: () {
  //           return showCustomDialog(context, 'Error', "Timeout, please check your connection");
  //         },
  //       );
  //     }
  //
  //     setLoading(false, context);
  //     print('Response : ${response.statusCode}');
  //     print('Response body: ${response.data}');
  //     return response;
  //   } catch (e) {
  //     setLoading(false, context);
  //     print(e);
  //     dynamic err = e;
  //     final errorMessage = DioExceptions.fromDioError(err).toString();
  //     print(errorMessage);
  //
  //     if (errorMessage == 'Unauthorized!') {
  //       // Handle unauthorized error
  //     } else if (errorMessage == 'Token expired, Please login again') {
  //       // Handle token expired error
  //     } else {
  //       showCustomDialog(context, 'Error', errorMessage);
  //     }
  //     throw (e);
  //     // Make sure to return a response here
  //     //return response; // You can customize this as needed
  //   }
  // }
}
