class Todos {
  late int total;
  late int skip;
  late int limit;
  late List<AllTodo> todos;
  late String message;
  Todos.fromJson(Map<String, dynamic> json) {
    skip = json['skip'];
    limit = json['limit'];
    total = json['total'];
    todos = (json['todos'] as List).map((e) => AllTodo.fromJson(e)).toList();
  }
  Todos.onError(Map<String,dynamic> json) {
    message = json['message'];
  }
}

class AllTodo {
  late int id;
  late String todo;
  late bool completed;
  late int userId;

  AllTodo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
}
