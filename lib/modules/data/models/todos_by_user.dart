class TodosByUser {
  late int total;
  late String skip;
  late int limit;
  late List<TodoByUser> todos;
  late String message;
  TodosByUser.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
    todos = (json['todos'] as List).map((e) => TodoByUser.fromJson(e)).toList();
  }
  TodosByUser.onError(Map<String,dynamic> json) {
    message = json['message'];
  }
}

class TodoByUser {
  late int id;
  late String todo;
  late bool completed;
  late int userId;

  TodoByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
}
