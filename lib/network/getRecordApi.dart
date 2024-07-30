// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// //import 'package:Seerecs/Screens/BottomNavigation%20Screens/BottomNavigationContentScreens/MyActivity.dart';
// import 'package:Seerecs/Screens/BottomNavigation.dart';
// import 'package:Seerecs/main.dart';
// import 'package:Seerecs/network/API_Services.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:Seerecs/network/DioExceptions.dart';
// import 'package:Seerecs/network/EndPoints.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Assets/CustomPageRoute.dart';
// import '../Screens/EnterPin.dart';
// import 'response?_AlterBox.dart';

// // Api services
// class GetRecordApi {
//   // Dio client
//   final Dio _dio;

//   // Constant connection time
//   static const int CONNECT_TIMEOUT = 30;

//   // Api endpoint
//   final String api;

//   GetRecordApi(this._dio, this.api);

//   // Api request
//   Future<response?> ApiUser(
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
//       if (obtainedToken == finalToken) {
//         //  Api request send to server
//         final response? = await _dio
//             .post('${EndPoints.baseUrl}$api',
//                 data: userData,
//                 options: Options(
//                     headers: {'Authorization': 'Bearer $obtainedToken'}))
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
//         print('Status Code : ${response?.statusCode}');
//         print('response? body: ${response?.data}');

//         // var data = json.decode(response?.data);
//         // var rest = data["MyActivityLog"] as List;
//         // print(rest);
//         return response?;
//       } else {
//         // Call your API here and pass `_verificationCode` as a parameter
//         final api = ApiServices(Dio(), "/getRecord");
//         // Api response? will get
//         final response? = await api.ApiUser(toJson(), context);
//         //Print response? here
//         print('response? status: ${response?.statusCode}');
//         print('response? body: ${response?}');
//         print(
//             'response? headers: ${response?.headers[HttpHeaders.authorizationHeader]}');
//         // New token will be saved here
//         String decoderesponse? = response?.toString();
//         Map<String, dynamic> res = jsonDecode(decoderesponse?);
//         res['token'] = '${response?.headers[HttpHeaders.authorizationHeader]}';
//         late var token = res['token'];
//         token = token.substring(1, token.length - 1);

//         print(token);
//         // Shared preferences used here so we can store token which will get from api.
//         // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//         // (sharedPreferences.getString('token')?? '');
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setString('token', token);
//         //sharedPreferences.getString('token');

//         //return token;
//         if (response?.statusCode == 200) {
//           print(json.encode(response?.data));
//         } else {
//           print(response?.statusMessage);
//         }

//         print("Get Record request send to api");
//       }
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
//         Navigator.push(context, CustomPageRoute(child: EnterPin()));
//       } else {
//         // Error message will be given to showCustomDialog() function
//         showCustomDialog(context, 'Error', errorMessage);
//       }
//       throw (e);
//     }
//     throw ("exception");
//   }
// }
