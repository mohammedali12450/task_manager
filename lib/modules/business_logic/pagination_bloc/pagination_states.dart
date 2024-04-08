abstract class PaginationStates {}

class PaginationInitialState extends PaginationStates {}

class PaginationInProgressState extends PaginationStates {}

class PaginationSuccessState extends PaginationStates {}

class PaginationErrorState extends PaginationStates {
  final String message;

  PaginationErrorState({required this.message});
}