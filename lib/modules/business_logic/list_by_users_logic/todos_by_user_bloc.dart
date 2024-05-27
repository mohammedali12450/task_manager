import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/list_by_users_logic/list_by_user_events.dart';
import 'package:task_manager_app/modules/business_logic/list_by_users_logic/todos_by_user_states.dart';
import 'package:task_manager_app/modules/data/repos/view_todos_by_user.dart';

import '../../data/models/todos_by_user.dart';

class TodosByUserBloc extends Bloc<TodosByUserEvents,TodosByUserStates> {
  ViewTodoByUserRepo viewTodoByUserRepo = ViewTodoByUserRepo();
  late TodosByUser? todosByUser;
  TodosByUserBloc() : super(TodosByUserInitialState()){
   on<GetTodosByUser>((event, emit) async {
     emit(TodosByUserInProgressState());
     todosByUser = await viewTodoByUserRepo.getTodosByUser(event.userId);
     if(todosByUser != null) {
       emit(TodosByUserSuccessState());
     }else {
       emit(TodosByUserErrorState());
     }
   });
  }

}