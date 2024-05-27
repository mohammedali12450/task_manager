import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/delete_todo_logic/deleteTodoEvents.dart';
import 'package:task_manager_app/modules/business_logic/delete_todo_logic/delete_todo_states.dart';
import 'package:task_manager_app/modules/data/repos/delete_todo.dart';

import '../../data/models/delete_todo.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvents,DeleteTodoStates>{
  DeleteTodoRepo deleteTodoRepo = DeleteTodoRepo();
  DeleteTodoModel? deleteTodo;
  DeleteTodoBloc() : super(DeleteTodoInitialState()){
    on<DeleteTodoStartEvent>((event, emit) async {
      try{
        print("1");
        emit(DeleteTodInProgressState());
        deleteTodo = await deleteTodoRepo.deleteTodo(event.todoId);
        print("this message was deleted ${deleteTodo!.message}");
        if(deleteTodo != null){
          print("success state");
          emit(DeleteTodoSuccessState());
        }else {
          print("error state");
          emit(DeleteTodoErrorState(message: "something went wrong"));
        }
      }catch (e){
        emit(DeleteTodoErrorState(message: e.toString()));
      }
    });
  }

}