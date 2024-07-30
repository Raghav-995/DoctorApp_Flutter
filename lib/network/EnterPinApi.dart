import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Seerecs/network/DioExceptions.dart';
import 'package:Seerecs/network/EndPoints.dart';

import 'response_AlterBox.dart';


// Api services
class EnterPinApiServices {
  // Dio client
  final Dio _dio;

  // Constant connection time
  static const int CONNECT_TIMEOUT = 10;

  // Api endpoint
  final String api;

  EnterPinApiServices(this._dio, this.api);

  // Api request
  Future<Response> ApiUser(
      Map<String, dynamic> userData, BuildContext context) async {
    // Circular progress indicator start
    setLoading(true, context);
    try {
      //  Api request send to server
        final response =
        await _dio.post('${EndPoints.baseUrl}$api', data: userData).timeout(
          Duration(seconds: CONNECT_TIMEOUT),
          // if connection time out Dialog box will appear
          onTimeout: () {
            return showCustomDialog(
                context, 'Error', "Timeout, please check your connection");
          },
        );
        // Circular progress indicator stops
        setLoading(false, context);
        // response? print
        print('response? : ${response.statusCode}');
        print('response? body: ${response.data}');
        return response;
      // Errors / Exceptions will be catch here
    } catch (e) {
      // If exception occurs circular progress indicator stops
      setLoading(false, context);
      // Error / Exceptions will be print in console
      print(e);
      // Exception type will be converted to dynamic
      dynamic err = e;
      // Any exception message will be save in errorMessage
      final errorMessage = DioExceptions.fromDioError(err).toString();
      // errorMessage print
      print(errorMessage);
      showCustomDialog(context, 'Error', errorMessage);
      // if (errorMessage == 'Unauthorized!') {
      //   Navigator.push(context, CustomPageRoute(child: EnterPin()));
      // } else {
      //   // Error message will be given to showCustomDialog() function
      //   showCustomDialog(context, 'Error', errorMessage);
      // }
      throw (e);
    }
  }
}
