
class SkipLimit {
  List<SkipLimitTodos>? todos;
  int? total;
  int? skip;
  int? limit;
  String? message;
  SkipLimit({this.todos, this.total, this.skip, this.limit});

  SkipLimit.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      todos = <SkipLimitTodos>[];
      json['todos'].forEach((v) {
        todos!.add(SkipLimitTodos.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
  SkipLimit.onError(Map<String,dynamic> json){
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todos != null) {
      data['todos'] = this.todos!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

class SkipLimitTodos {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  SkipLimitTodos({this.id, this.todo, this.completed, this.userId});

  SkipLimitTodos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['todo'] = todo;
    data['completed'] = completed;
    data['userId'] = userId;
    return data;
  }
}