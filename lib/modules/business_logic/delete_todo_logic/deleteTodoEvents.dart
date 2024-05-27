abstract class DeleteTodoEvents {}

class DeleteTodoStartEvent extends DeleteTodoEvents {
  final int todoId;
  DeleteTodoStartEvent({required this.todoId});

}