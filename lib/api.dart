import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;

  ///TODO: [initalizeDio] should be called when the [ApiService class] is initialized
  ApiService(this._dio);

  void initializeDio() {
    _dio.options = BaseOptions(
      baseUrl: "https://yapp-middleware.azurewebsites.net/api/v1/",
      headers: {
        "content-Type": "application/json",
      },
    );

    _dio.interceptors.add(
      ///TODO: Implement [onRequest, onResponse and onError]
      ///Each interceptor can simply have a [print statement] of the request information e.g [request url, headers e.t.c]
      InterceptorsWrapper(),
    );
  }

  Dio get dio => _dio;
}
