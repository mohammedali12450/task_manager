class AddNewTodo {
  late int id;
  late String todo;
  late bool completed;
  late int userId;
  late String message;
  AddNewTodo.fromJson(Map<String,dynamic> json){
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
  AddNewTodo.onError(Map<String,dynamic> json) {
    message = json['message'];
  }
}