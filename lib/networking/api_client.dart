import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.currencylayer.com/')
abstract class ApiClient{
  factory ApiClient({String? baseUrl} ){
    Dio dio = Dio();
    RequestOptions? reqOptions;

    Map<String, dynamic> headers = {
      "access_key" : ""
    };

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
      headers: headers
    );

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody:  true
    ));



    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler){
      reqOptions = options;
      handler.next(options);
      },
      onResponse: (response, handler){
        handler.next(response);
    },
      onError: (error, handler){
        return handler.next(error);
      }
    ));


    return _ApiClient(dio,baseUrl:baseUrl);


  }



}