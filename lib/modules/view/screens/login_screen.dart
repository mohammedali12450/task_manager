import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/login_logic/login_bloc.dart';
import '../../business_logic/login_logic/login_events.dart';
import '../../business_logic/login_logic/login_states.dart';
import '../widgets/text_field.dart';
import 'home_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(80, 98, 180, 1),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 300,
                  height: 300,
                ),
              ),
              Form(
                key: formKey,
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: 350,
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      "User name :",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 350,
                    child: MyTextField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "this field can't be empty";
                        }
                        return null;
                      },
                      obscureText: false,
                      icon: Icons.person,
                      onChanged: (value) {
                        userName = value;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: 350,
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      "Password :",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 350,
                    child: MyTextField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "this field can't be empty";
                        }
                        return null;
                      },
                      icon: Icons.lock,
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                    ),
                  ),
                  Container(
                    width: 175,
                    height: 50,
                    margin: const EdgeInsets.all(20.0),
                    child: BlocListener<LoginBloc, LoginStates>(
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false);
                        } else if (state is LoginErrorState) {
                          AwesomeDialog(context: context, desc: state.message)
                              .show();
                        }
                      },
                      child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate() ?? false){
                              loginBloc.add(LoginButtonPressed(
                                  userName: userName!, password: password!));
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
