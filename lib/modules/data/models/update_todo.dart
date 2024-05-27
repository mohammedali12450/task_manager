class UpdateTodo {
  late int id;
  late String todo;
  late bool completed;
  late int userId;
  late String message;
  UpdateTodo.fromJson(Map<String,dynamic> json){
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
  UpdateTodo.onError(Map<String,dynamic> json) {
    message = json['message'];
  }
}