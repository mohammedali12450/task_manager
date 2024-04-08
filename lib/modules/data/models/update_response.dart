class UpdateResponse {
  late String name;
  late String job;
  late String updatedAt;

  UpdateResponse.fromJson(Map<String,dynamic> json){
    name = json['name'];
    job = json['job'];
    updatedAt = json['updatedAt'];
  }
}