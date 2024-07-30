import 'package:dio/dio.dart';
import 'EndPoints.dart';

// Dio client object

class DioClient {
  static BaseOptions options = new BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: EndPoints.connectionTimeout,
      receiveTimeout: EndPoints.receiveTimeout);
  Dio _dio = Dio(options);

  Future<Response> post(String uri,
      {required Map<String, dynamic> queryParameters,
      required Options options,
      required CancelToken cancelToken,
      required ProgressCallback onReceiveProgress}) async {
    try {
      final response = await _dio.post(uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
