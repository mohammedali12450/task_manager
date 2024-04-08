abstract class LoginEvents {}

class LoginButtonPressed extends LoginEvents {
  final String userName;
  final String password;
  LoginButtonPressed({required this.userName,required this.password});
}