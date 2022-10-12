import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static initilazitonDioHelper() {
    dio = Dio(BaseOptions(
        baseUrl: 'http://192.168.43.176:8000/api/v1/',
        receiveDataWhenStatusError: true,
        ));
  }

  // Insert Data
  static Future<Response> postData(
      {required String path,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String? token}) async {
    //header
    dio.options.headers = {'Authorization': token};
    return await dio.post(
      path,
      data: data,
      queryParameters: query,
    );
    
  }

  //Update Data
  static Future<Response> putData(
      {required String path,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String? token}) async {
    //header
    dio.options.headers = {'Authorization': token};
    return await dio.put(
      path,
      data: data,
      queryParameters: query,
    );
  }

  //Get Data
  static Future<Response> getData(
      {required String path,
      Map<String, dynamic>? query,
      String? token}) async {
    //header
    dio.options.headers = {'Authorization': token};
    return await dio.get(path, queryParameters: query);
  }
}
