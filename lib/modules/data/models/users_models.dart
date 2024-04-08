class Pagination {
  late int page;
  late int perPage;
  late int total;
  late int totalPages;
  late List<Users> data;

  Pagination.fromJson(Map<String,dynamic> json){
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    data = (json['data'] as List).map((e) => Users.fromJson(e)).toList()??[];
  }
}

class Users {
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;

  Users.fromJson(Map<String,dynamic> json){
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}