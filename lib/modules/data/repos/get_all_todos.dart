import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';
import 'package:task_manager_app/modules/data/connection/network_helper.dart';
import 'package:task_manager_app/modules/data/models/skip_limit.dart';

import '../models/todos.dart';

class GetAllTodosRepo {
  NetworkHelper networkHelper = NetworkHelper();
  
  Future<Todos?> getAllTodos () async {
    try {
      Response? response = await networkHelper.get(ApplicationConstants.todos);
      if(response!.statusCode == 200){
        Map<String,dynamic> convertFromJson = response.data;
        Todos todos = Todos.fromJson(convertFromJson);
        return todos;
      }else {
        Todos todos = Todos.onError({'message':'something went wrong'});
        return todos;
      }
    }catch(e){
      Todos todos = Todos.onError({'message':e.toString()});
      return todos;
    }
  }
}