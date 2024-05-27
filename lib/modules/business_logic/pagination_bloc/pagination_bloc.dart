import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/pagination_bloc/pagination_events.dart';
import 'package:task_manager_app/modules/business_logic/pagination_bloc/pagination_states.dart';
import 'package:task_manager_app/modules/data/repos/skip_limit_repo.dart';
import '../../data/models/skip_limit.dart';

class PaginationBloc extends Bloc<PaginationEvents,PaginationStates> {
  SkipLimitRepo skipLimitRepo = SkipLimitRepo();
  late SkipLimit? skipLimit;
  PaginationBloc(): super(PaginationInitialState()){
    on<PaginationFetchEvent>((event, emit) async {
      try{
        emit(PaginationInProgressState());
        skipLimit = await skipLimitRepo.getSkipLimit({'limit':event.limit,'skip':event.skip});
        // print(skipLimit!.total);
        print(skipLimit!.limit);
        if(skipLimit!.todos!.isNotEmpty){
          emit(PaginationSuccessState());
        }else {
          emit(PaginationErrorState(message: "there are no more users"));
        }
      }catch(e){
        emit(PaginationErrorState(message: e.toString()));
      }
    });
  }
}