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

      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print('Request[${options.method}] => PATH: ${options.path}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');
          return handler.next(options); // Continue the request
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print('Response[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response); // Continue the response
        },
        onError: (error, ErrorInterceptorHandler handler) {
          print(
              'Error[${error.response?.statusCode}] => MESSAGE: ${error.message}');
          return handler.next(error); // Continue the error
        },
      ),
    );
  }

  Dio get dio => _dio;
}
