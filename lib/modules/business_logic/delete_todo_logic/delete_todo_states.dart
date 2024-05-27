abstract class DeleteTodoStates {}

class DeleteTodoInitialState extends DeleteTodoStates {}

class DeleteTodInProgressState extends DeleteTodoStates {}

class DeleteTodoSuccessState extends DeleteTodoStates {}

class DeleteTodoErrorState extends DeleteTodoStates {
  final String message;

  DeleteTodoErrorState({required this.message});

}