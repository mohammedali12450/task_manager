import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/create_response.dart';
import '../../data/repos/create_repo.dart';
import '../user_screen_bloc/user_screen_events.dart';
import '../user_screen_bloc/user_screen_states.dart';
import 'create_process_states.dart';

class CreateProcessBloc extends Bloc<UserScreenEvents,UserScreenStates> {
  CreateProcessRepo createProcessRepo = CreateProcessRepo();
  CreateResponse? createResponse;
  CreateProcessBloc():super(CreateInitialState()){
    on<CreateStartEvent>((event, emit) async {
      emit(CreateInProgressState());
      createResponse = await createProcessRepo.createNewUser({
        "name":event.name,
        "job":event.job
      });
      if(createResponse != null){
        emit(CreateSuccessState());
      }else {
        emit(CreateErrorState(message: "something went wrong Try again later"));
      }
    });
  }

}