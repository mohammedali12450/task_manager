import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<dynamic> {
  AppCubit(initialState):super(initialState);
  void setState(dynamic data)=>emit(data);
}