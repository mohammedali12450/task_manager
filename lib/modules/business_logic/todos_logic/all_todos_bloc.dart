import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/todos_logic/all_todos_events.dart';
import 'package:task_manager_app/modules/business_logic/todos_logic/all_todos_states.dart';
import 'package:task_manager_app/modules/data/repos/get_all_todos.dart';

import '../../data/models/todos.dart';

class AllTodosBloc extends Bloc<AllTodosEvents,AllTodosStates> {
  GetAllTodosRepo getAllTodosRepo = GetAllTodosRepo();
  late Todos? todos;
  AllTodosBloc() : super (AllTodosInitialState()){
    on<GetAllTodos>((event, emit) async {
      emit(AllTodosInProgressState());
      todos = await getAllTodosRepo.getAllTodos();
      if(todos != null) {
        emit(AllTodosSuccessState());
      }else {
        emit(AllTodosErrorState());
      }
    });
  }

}