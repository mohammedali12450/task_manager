import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/my_todo_logic/my_todos_events.dart';
import 'package:task_manager_app/modules/business_logic/my_todo_logic/my_todos_state.dart';
import 'package:task_manager_app/modules/data/repos/view_todos_by_user.dart';

import '../../data/models/todos_by_user.dart';

class MyTodosBloc extends Bloc<MyTodosEvents,MyTodosStates> {
  TodosByUser? todosByUser;
  ViewTodoByUserRepo viewTodoByUserRepo = ViewTodoByUserRepo();
  MyTodosBloc() : super (MyTodosInitialState()){
    on<GetMyTodosStartEvent>((event, emit) async {
      try{
        emit(MyTodosInProgressState());
        print(event.userId);
        todosByUser = await viewTodoByUserRepo.getTodosByUser(event.userId!);
        print(todosByUser!.total.toString() + "total");
        if(todosByUser != null) {
          print("success state");
          emit(MyTodosSuccessState());
        }else {
          print("error state");
          emit(MyTodosErrorState());
        }
      }catch(e){
        emit(MyTodosErrorState());
      }
    });
  }

}