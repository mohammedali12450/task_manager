abstract class AddTodoEvents {}

class AddNewTodoEvent extends AddTodoEvents {
  String? todo;
  bool? completed;
  int? userId;
  AddNewTodoEvent({required this.todo,required this.userId,required this.completed});
}