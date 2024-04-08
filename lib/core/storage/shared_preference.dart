import 'package:task_manager_app/core/storage/user_shared_preference.dart';

Future initializeSharedPreferences() async {
  await UserSharedPreference.init();
}

Future clearSharedPreferences() async {
  await UserSharedPreference.clear();
}