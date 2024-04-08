
import '../user_screen_bloc/user_screen_states.dart';

class CreateInitialState extends UserScreenStates {}

class CreateInProgressState extends UserScreenStates {}

class CreateSuccessState extends UserScreenStates {}

class CreateErrorState extends UserScreenStates {
  final String message;
  CreateErrorState({required this.message});
}