import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/storage/user_shared_preference.dart';
import '../../data/models/login_response.dart';
import '../../data/repos/login_repo.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  late LoginResponse? loginResponse;
  LoginRepo loginRepo = LoginRepo();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginInProgressState());
      loginResponse = await loginRepo
          .login({"username": event.userName, "password": event.password});
      if(loginResponse!.token != ""){
        UserSharedPreference.setAccessToken(loginResponse!.token);
        emit(LoginSuccessState());
      }else{
        emit(LoginErrorState(message: loginResponse!.error));
      }
    });
  }
}
