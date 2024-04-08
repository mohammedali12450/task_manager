class CreateResponse {
  late String name;
  late String job;
  late String id;
  late String createdAt;

  CreateResponse.fromJson(Map<String,dynamic> json){
    name = json['name'];
    name = json['job'];
    name = json['id'];
    name = json['createdAt'];
  }
}