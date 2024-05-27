// import 'package:dio/dio.dart';
// import 'package:task_manager_app/constants/app_constants.dart';
// import '../connection/network_helper.dart';
// import '../models/update_todo.dart';
//
// class UpdateRepo {
//   NetworkHelper networkHelper = NetworkHelper();
//
//   Future<UpdateTodo?> updateUser(
//       Map<String, dynamic> data, int userId) async {
//     try {
//       Response? response = await networkHelper
//           .put(ApplicationConstants.getUsers +"/"+ userId.toString(), data: data);
//       if(response!.statusCode == 200){
//         UpdateTodo updateTodo = UpdateTodo.fromJson(response.data);
//         return updateTodo;
//       }else {
//         UpdateTodo updateTodo = UpdateTodo.onError({'message':"something went wrong"});
//         return updateTodo;
//       }
//     } catch (e) {
//       print(e.toString());
//       UpdateTodo updateTodo = UpdateTodo.onError({'message':e.toString()});
//       return updateTodo;
//     }
//   }
// }
