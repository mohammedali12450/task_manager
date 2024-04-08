import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/navigation_bloc/navigation_events.dart';
import 'package:task_manager_app/modules/business_logic/navigation_bloc/navigation_states.dart';
import 'package:task_manager_app/modules/data/repos/pagination_repo.dart';

import '../../data/models/users_models.dart';

class NavigationBloc extends Bloc<NavigationEvents,NavigationStates> {
  Pagination? pagination;
  PaginationRepo paginationRepo = PaginationRepo();
  NavigationBloc():super(NavigateInitialState()){
    on<NavigateEvent>((event, emit) async{
      emit(NavigateInProgressState());
      pagination = await paginationRepo.getListUsers({"page":event.pageNumber});
      if(pagination != null){
        if(pagination!.data.isNotEmpty){
          emit(NavigateSuccessState());
        }
      }else{
        emit(NavigateErrorState(message: "something went wrong try again later"));
      }
    });
  }
  
}