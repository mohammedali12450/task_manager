import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/add_todo_logic/add_todo_events.dart';
import 'package:task_manager_app/modules/business_logic/add_todo_logic/add_todo_states.dart';
import 'package:task_manager_app/modules/data/repos/create_todo_repo.dart';

import '../../data/models/add_new_todo.dart';

class AddTodoBloc extends Bloc<AddTodoEvents,AddTodoStates>{
  AddNewTodoRepo addTodoRepo = AddNewTodoRepo();
  AddNewTodo? addTodo;
  AddTodoBloc() : super (AddTodoInitialState()){
    on<AddNewTodoEvent>((event, emit) async {
      try{
        emit(AddTodoInProgressState());
        addTodo = await addTodoRepo.addNewTodo({'todo':event.todo,'completed':event.completed,'userId':event.userId});
        if(addTodo != null){
          emit(AddTodoSuccessState());
        }else {
          emit(AddTodoErrorState(message: "something went wrong"));
        }
      }catch(e){
        emit(AddTodoErrorState(message: e.toString()));
      }
    });
  }

}