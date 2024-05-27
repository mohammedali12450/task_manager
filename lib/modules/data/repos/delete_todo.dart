import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';
import 'package:task_manager_app/modules/data/connection/network_helper.dart';

import '../models/delete_todo.dart';

class DeleteTodoRepo {
  NetworkHelper networkHelper = NetworkHelper();

  Future<DeleteTodoModel?> deleteTodo (int todoId) async {
    try {
      Response? response = await networkHelper.delete(ApplicationConstants.deleteTodo+todoId.toString());
      print(response!.data);
      if(response!.statusCode == 200) {
        Map<String,dynamic> convertFromJson = response.data;
        DeleteTodoModel deleteTodo = DeleteTodoModel.fromJson(convertFromJson);
        print(deleteTodo.isDeleted);
        return deleteTodo;
      }else {
        DeleteTodoModel deleteTodo = DeleteTodoModel.onError({'message':"something went wrong"});
        return deleteTodo;
      }
    }catch (e) {
      DeleteTodoModel deleteTodo = DeleteTodoModel.onError({'message':e.toString()});
      return deleteTodo;
    }
  }
}