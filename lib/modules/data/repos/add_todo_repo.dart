import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';
import 'package:task_manager_app/modules/data/connection/network_helper.dart';
import 'package:task_manager_app/modules/data/models/add_new_todo.dart';

class AddTodoRepo {
  NetworkHelper networkHelper = NetworkHelper();
  
  Future<AddNewTodo?> addNewTodo(Map<String,dynamic> data) async {
    try{
      Response? response = await networkHelper.post(ApplicationConstants.addNewTodo,data: data);
      if(response!.statusCode == 200){
        Map<String,dynamic> convertFromJson = response.data;
        AddNewTodo addNewTodo = AddNewTodo.fromJson(convertFromJson);
        return addNewTodo;
      }else {
        AddNewTodo addNewTodo = AddNewTodo.onError({'message':"somthing went wrong"});
        return addNewTodo;
      }

    }catch(e){
      AddNewTodo addNewTodo = AddNewTodo.onError({'message':e.toString()});
    }
  }
}