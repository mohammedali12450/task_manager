class DeleteTodoModel {
  late int id;
  late String todo;
  late bool completed;
  late int userId;
  late bool isDeleted;
  late String deletedOn;
  late String message;
  DeleteTodoModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
    isDeleted = json['isDeleted'];
    deletedOn = json['deletedOn'];
  }
  DeleteTodoModel.onError (Map<String,dynamic> json){
    message = json['message'];
  }
}