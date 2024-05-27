abstract class AddTodoStates {}

class AddTodoInitialState extends AddTodoStates {}

class AddTodoInProgressState extends AddTodoStates {}

class AddTodoSuccessState extends AddTodoStates {}

class AddTodoErrorState extends AddTodoStates {
  String? message;
  AddTodoErrorState({required this.message});
}