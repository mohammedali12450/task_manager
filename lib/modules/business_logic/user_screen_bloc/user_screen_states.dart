abstract class UserScreenStates {}

class UpdateInitialState extends UserScreenStates {}

class UpdateInProgressState extends UserScreenStates {}

class UpdateSuccessState extends UserScreenStates {}

class UpdateErrorState extends UserScreenStates {
  final String message;
  UpdateErrorState({required this.message});
}