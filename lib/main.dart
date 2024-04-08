import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/storage/user_shared_preference.dart';
import 'package:task_manager_app/modules/business_logic/navigation_bloc/navigation_bloc.dart';
import 'core/storage/shared_preference.dart';
import 'modules/business_logic/create_process_bloc/create_process_bloc.dart';
import 'modules/business_logic/login_logic/login_bloc.dart';
import 'modules/business_logic/pagination_bloc/pagination_bloc.dart';
import 'modules/business_logic/user_screen_bloc/user_screen_bloc.dart';
import 'modules/view/screens/home_page.dart';
import 'modules/view/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => PaginationBloc()),
        BlocProvider(create: (_) => UpdateBloc()),
        BlocProvider(create: (_) => CreateProcessBloc()),
        BlocProvider(create: (_) => NavigationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (setting) {
          if (setting.name == "LoginScreen") {
            return MaterialPageRoute(builder: (context) => LoginScreen());
          } else if (setting.name == "HomePage") {
            return MaterialPageRoute(builder: (context) => HomePage());
          }
          return UserSharedPreference.getAccessToken() == null
              ? MaterialPageRoute(builder: (context) => LoginScreen())
              : MaterialPageRoute(builder: (context) => HomePage());
        },
        home: UserSharedPreference.getAccessToken() == null
            ? LoginScreen()
            : HomePage(),
      ),
    );
  }
}
