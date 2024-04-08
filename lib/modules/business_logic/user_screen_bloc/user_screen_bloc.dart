import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/user_screen_bloc/user_screen_events.dart';
import 'package:task_manager_app/modules/business_logic/user_screen_bloc/user_screen_states.dart';

import '../../data/models/update_response.dart';
import '../../data/repos/update_repo.dart';

class UpdateBloc extends Bloc<UserScreenEvents,UserScreenStates> {
  UpdateRepo updateRepo = UpdateRepo();
  UpdateResponse? updateResponse;
  UpdateBloc():super(UpdateInitialState()){
   on<UpdateStartEvent>((event, emit) async{
     emit(UpdateInProgressState());
     updateResponse = await updateRepo.updateUser({
       "name":event.name,
       "job":event.job
     }, event.userId);
     if(updateResponse != null){
       emit(UpdateSuccessState());
     }else {
       emit(UpdateErrorState(message: "something went wrong try again later."));
     }
   });
   on((event, emit) => null);
  }
}