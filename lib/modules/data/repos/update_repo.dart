import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';
import '../connection/network_helper.dart';
import '../models/update_response.dart';

class UpdateRepo {
  NetworkHelper networkHelper = NetworkHelper();

  Future<UpdateResponse?> updateUser(
      Map<String, dynamic> data, int userId) async {
    try {
      Response? response = await networkHelper
          .put(ApplicationConstants.getUsers +"/"+ userId.toString(), data: data);
      if(response!.statusCode == 200){
        UpdateResponse updateResponse = UpdateResponse.fromJson(response.data);
        return updateResponse;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
