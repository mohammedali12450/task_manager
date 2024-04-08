import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';

import '../connection/network_helper.dart';
import '../models/create_response.dart';

class CreateProcessRepo {

  NetworkHelper networkHelper = NetworkHelper();

  Future<CreateResponse?> createNewUser(Map<String,dynamic> data) async {
    try{
      Response? response = await networkHelper.post(ApplicationConstants.getUsers,data: data);
      if(response!.statusCode == 201){
        CreateResponse createResponse = CreateResponse.fromJson(response.data);
        return createResponse;
      }else{
        return null;
      }
    }catch(e) {
      print(e.toString());
      return null;
    }
  }
}