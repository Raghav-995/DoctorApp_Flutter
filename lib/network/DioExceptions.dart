// import 'package:dio/dio.dart';

// // Dio Exceptions class
// class DioExceptions implements Exception {
//   // Exceptions will be sorted by type here
//   DioExceptions.fromDioError(DioError dioError) {
//     // Type wise response? will be pass to errorMessage
//     switch (dioError.type) {
//       // All status code wise exceptions will be in this type
//       case DioErrorType.response?:
//         message = _handleError(
//             dioError.response??.statusCode, dioError.response??.data);
//         break;
//       // All Connection timeout exceptions will be in this type
//       case DioErrorType.connectTimeout:
//         message = "Connection timeout in connection with API server";
//         break;
//       // All receive timeout exceptions will be in this type
//       case DioErrorType.receiveTimeout:
//         message = "Receive timeout in connection with API server";
//         break;
//       // All request to api cancel exceptions will be in this type
//       case DioErrorType.cancel:
//         message = "Request to API server was cancelled";
//         break;
//       // All connection exceptions will be in this type
//       case DioErrorType.other:
//         message = "Connection to API server failed due to internet connection";
//         break;ptio
//       // All Request send timeout excens will be in this type
//       case DioErrorType.sendTimeout:
//         message = "Request send timeout in connection with API server";
//         break;
//     }
//   }

//   late String message; // message String will store in this string

//   // Status code and error will be sort here
//   String _handleError(var statusCode, dynamic error) {
//     // By status code response? will be store in message string
//     switch (statusCode) {
//       case 400:
//         return error['message'];
//       case 401:
//         error['message'].toString();
//         return error['message'];
//       case 403:
//         return error['message'];
//       case 404:
//         return error['message'];
//       case 409:
//         return error['message'];
//       case 429:
//         return error['message'];
//       case 500:
//         return error['message'];

//       // Any other status code error will be go to default.
//       default:
//         return error['message'];
//     }
//   }

//   @override
//   String toString() => message;
// }

import 'package:dio/dio.dart';

// Dio Exceptions class
class DioExceptions implements Exception {
  // Exceptions will be sorted by type here
  DioExceptions.fromDioError(DioError dioError) {
    // Type wise response? will be pass to errorMessage
    switch (dioError.type) {
      // All status code wise exceptions will be in this type
      case DioErrorType.response:
        message = _handleError(
            dioError.response?.statusCode, dioError.response?.data);
        break;
      // All Connection timeout exceptions will be in this type
      case DioErrorType.connectTimeout:
        message = "Connection timeout in connection with API server";
        break;
      // All receive timeout exceptions will be in this type
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      // All request to api cancel exceptions will be in this type
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      // All connection exceptions will be in this type
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      // All Request send timeout exceptions will be in this type
      case DioErrorType.sendTimeout:
        message = "Request send timeout in connection with API server";
        break;
      // Default case for any other DioErrorType
      default:
        message = "Unexpected error occurred with Dio: ${dioError.type}";
        break;
    }
  }

  late String message; // message String will store in this string

  // Status code and error will be sort here
  String _handleError(var statusCode, dynamic error) {
    // By status code response? will be store in message string
    switch (statusCode) {
      case 400:
        return error['message'];
      case 401:
        error['message'].toString();
        return error['message'];
      case 403:
        return error['message'];
      case 404:
        return error['message'];
      case 409:
        return error['message'];
      case 429:
        return error['message'];
      case 500:
        return error['message'];

      // Any other status code error will be go to default.
      default:
        return error['message'];
    }
  }

  @override
  String toString() => message;
}
