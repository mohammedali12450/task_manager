abstract class NavigationStates {}

class NavigateInitialState extends NavigationStates {}

class NavigateInProgressState extends NavigationStates {}

class NavigateSuccessState extends NavigationStates {}

class NavigateErrorState extends NavigationStates {
  final String message;
  NavigateErrorState({required this.message});
}