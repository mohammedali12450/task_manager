import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';

import '../connection/network_helper.dart';
import '../models/add_new_todo.dart';

class AddNewTodoRepo {

  NetworkHelper networkHelper = NetworkHelper();

  Future<AddNewTodo?> addNewTodo(Map<String,dynamic> data) async {
    try{
      Response? response = await networkHelper.post(ApplicationConstants.addNewTodo,data: data);
      if(response!.statusCode == 200){
        AddNewTodo createResponse = AddNewTodo.fromJson(response.data);
        return createResponse;
      }else{
        AddNewTodo addNewTodo = AddNewTodo.onError({'message':"something went wrong"});
        return addNewTodo;
      }
    }catch(e) {
      print(e.toString());
      AddNewTodo addNewTodo = AddNewTodo.onError({'message':e.toString()});
      return addNewTodo;
    }
  }
}