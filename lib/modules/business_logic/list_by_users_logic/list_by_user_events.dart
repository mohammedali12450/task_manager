abstract class TodosByUserEvents {}

class GetTodosByUser extends TodosByUserEvents {
  late int userId;
  GetTodosByUser({required this.userId});
}