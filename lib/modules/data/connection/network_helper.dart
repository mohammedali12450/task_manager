
import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';

class NetworkHelper {
  late Dio dio;

  NetworkHelper() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: ApplicationConstants.baseUrl,
        sendTimeout: Duration(microseconds: 7000),
        receiveTimeout: Duration(milliseconds: 7000),
        connectTimeout: Duration(milliseconds: 7000),
        validateStatus: (status) {
          if (status != null) {
            return status <= 500;
          }
          return false;
        },
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    dio = Dio(baseOptions);
  }

  Future<Response?> get(String url, {Map<String, dynamic>? parameters}) async {
    try {
      Response response = await dio.get(url, queryParameters: parameters);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Response?> post(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.post(url, data: data);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Response?> patch(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.patch(url, data: data);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Response?> put(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.put(url, data: data);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Response?> delete(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.delete(url, data: data);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
