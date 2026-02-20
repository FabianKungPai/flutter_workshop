import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.139:8081/api", //set IP here Everytime that change network
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json"
      }
    )
  )..interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    )
  );
}