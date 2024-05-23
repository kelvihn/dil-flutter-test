import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

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
      InterceptorsWrapper(
        onRequest: (options, _){
          print('------- Request ----------');
          print(options.uri);
          print(options.headers);
        },
        onResponse: (response, handler){
          print('------- Response ----------');
          print(response);
        },
        onError: (exception, _){
          print('------- Error ----------');
          print(exception);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
