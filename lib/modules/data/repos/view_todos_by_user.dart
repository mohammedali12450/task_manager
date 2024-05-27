import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_manager_app/constants/app_constants.dart';
import 'package:task_manager_app/modules/data/connection/network_helper.dart';

import '../models/todos_by_user.dart';

class ViewTodoByUserRepo {
  NetworkHelper networkHelper = NetworkHelper();

  Future<TodosByUser?> getTodosByUser (int userId) async {
    try {
      Response? response = await networkHelper.get(ApplicationConstants.getTodosByUser+userId.toString());
      print(response);
      if(response!.statusCode == 200) {
        print("object");
        Map<String,dynamic> convertFromJson = json.decode(response.data);
        TodosByUser todosByUser = TodosByUser.fromJson(convertFromJson);
        return todosByUser;
      }else {
        TodosByUser todosByUser = TodosByUser.onError({'message':"something went wrong"});
        return todosByUser;
      }
    }catch(e) {
      TodosByUser todosByUser = TodosByUser.onError({'message':e.toString()});
      return todosByUser;
    }
  }
}