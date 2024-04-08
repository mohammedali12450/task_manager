abstract class LoginStates {}

class LoginInitialState extends LoginStates{}

class LoginInProgressState extends LoginStates{}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String message;
  LoginErrorState({required this.message});
}