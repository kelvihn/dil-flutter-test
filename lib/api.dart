import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;

  ///TODO: [initalizeDio] should be called when the [ApiService class] is initialized
  ApiService(this._dio){
    initializeDio();
  }

  void initializeDio() {
    _dio.options = BaseOptions(
      baseUrl: "https://yapp-middleware.azurewebsites.net/api/v1/",
      headers: {
        "content-Type": "application/json",
      },
    );

    _dio.interceptors.add(
        LoggerInterceptor(),
    );
  }

  Dio get dio => _dio;
}


class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("--> ${options.method} ${options.uri}");
    print("Headers:");
    options.headers.forEach((key, value) {
      print("$key: $value");
    });
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print("<---------- END HTTP --------------------->");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    print("<-- ${response.statusCode} ${response.requestOptions.uri}");
    print("Headers:");
    response.headers.forEach((key, value) {
      print("$key: $value");
    });
    if (response.data != null) {
      print("Response: ${response.data}");
    }
    print("<---------- END HTTP --------------------->");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("<-- ${err.response?.statusCode} ${err.requestOptions.uri}");
    print("Error: ${err.message}");
    print("<---------- END HTTP --------------------->");
    super.onError(err, handler);
  }
}
