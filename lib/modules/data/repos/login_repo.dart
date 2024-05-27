import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';

import '../connection/network_helper.dart';
import '../models/login_response.dart';

class LoginRepo {
  NetworkHelper networkHelper = NetworkHelper();
  
  Future<LoginResponse?> login(Map<String,dynamic> data) async {
    try {
      Response? response = await networkHelper.post(ApplicationConstants.login,data: data);
      print("response is ${response}");
      if(response!.statusCode == 200){
        Map<String,dynamic> convertFromJson = response.data;
        print("in success : $convertFromJson");
        LoginResponse loginResponse = LoginResponse.onSuccess(convertFromJson);
        return loginResponse;
      }else{
        Map<String,dynamic> convertFromJson = response.data;
        print("in other code : $convertFromJson");
        LoginResponse loginResponse = LoginResponse.onError(convertFromJson);
        return loginResponse;
      }
    } on DioException catch(e){
      print(e.toString());
      Map<String,dynamic> response = {'message':e.toString()};
      print("in exception : $response");
      LoginResponse loginResponse = LoginResponse.onError(response);
      return loginResponse;
    }
  }
}