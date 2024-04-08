class LoginResponse{
  late String token;
  late String error;

  LoginResponse.onSuccess(Map<String,dynamic> json) {
    token = json['token'];
    error = json['error']??"";
  }
  
  LoginResponse.onError(Map<String,dynamic> json){
    error = json['error'];
    token = json['token']??"";
  }
}