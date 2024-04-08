import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/pagination_bloc/pagination_events.dart';
import 'package:task_manager_app/modules/business_logic/pagination_bloc/pagination_states.dart';

import '../../data/models/users_models.dart';
import '../../data/repos/pagination_repo.dart';

class PaginationBloc extends Bloc<PaginationEvents,PaginationStates> {
  PaginationRepo paginationRepo = PaginationRepo();
  Pagination? pagination;
  PaginationBloc(): super(PaginationInitialState()){
    on<PaginationFetchEvent>((event, emit) async {
      emit(PaginationInProgressState());
      pagination = await paginationRepo.getListUsers({'page':event.pageNumber});
      if(pagination!.data.isNotEmpty){
        emit(PaginationSuccessState());
      }else {
        emit(PaginationErrorState(message: "there are no more users"));
      }
    });
  }
}