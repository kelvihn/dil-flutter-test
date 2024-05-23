import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
      ///TODO: Implement [onRequest, onResponse and onError]: DONE
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
       
          debugPrint(options.baseUrl);
        
      }, onError: (error, handler) {
        
          debugPrint(error.message);
               
      },
      onResponse: (response, handler) {
       
          debugPrint(response.data);
         
      }
      ),
    );
  }

  Dio get dio => _dio;
}
