import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';
import '../connection/network_helper.dart';
import '../models/users_models.dart';

class PaginationRepo {
  NetworkHelper networkHelper = NetworkHelper();

  Future<Pagination?> getListUsers(Map<String,dynamic> parameters) async {
    try {
      Response? response = await networkHelper.get(ApplicationConstants.getUsers,parameters: parameters);
      Pagination pagination = Pagination.fromJson(response!.data);
      return pagination;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}