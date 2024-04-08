import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/create_process_bloc/create_process_bloc.dart';
import '../../business_logic/create_process_bloc/create_process_states.dart';
import '../../business_logic/user_screen_bloc/user_screen_bloc.dart';
import '../../business_logic/user_screen_bloc/user_screen_events.dart';
import '../../business_logic/user_screen_bloc/user_screen_states.dart';
import '../../data/models/users_models.dart';
import '../widgets/text_field.dart';

class UserScreen extends StatelessWidget {
  UserScreen({this.user, required this.toUpdate});

  UpdateBloc? updateBloc;
  CreateProcessBloc? createProcessBloc;
  final Users? user;
  bool toUpdate;
  late String? firstName;
  late String? lastName;
  late String? job;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    updateBloc = BlocProvider.of<UpdateBloc>(context);
    createProcessBloc = BlocProvider.of<CreateProcessBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              toUpdate
                  ? Center(
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user!.avatar,
                          ),
                          radius: MediaQuery.of(context).size.width * 0.35))
                  : const SizedBox(),
              toUpdate
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MyTextField(
                        obscureText: false,
                        initialValue: user!.email,
                        enabled: false,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MyTextField(
                        obscureText: false,
                        hintText: "enter email here",
                        enabled: true,
                      ),
                    ),
              toUpdate
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MyTextField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "this field can't be empty";
                          }
                          return null;
                        },
                        obscureText: false,
                        hintText: user!.firstName,
                        onChanged: (value) {
                          firstName = value;
                        },
                        enabled: true,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MyTextField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "this field can't be empty";
                          }
                          return null;
                        },
                        obscureText: false,
                        hintText: "enter first name here",
                        onChanged: (value) {
                          firstName = value;
                        },
                        enabled: true,
                      ),
                    ),
              toUpdate
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MyTextField(
                        obscureText: false,
                        hintText: user!.lastName,
                        onChanged: (value) {
                          lastName = value;
                        },
                        enabled: true,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MyTextField(
                        obscureText: false,
                        hintText: "enter last name here",
                        onChanged: (value) {
                          lastName = value;
                        },
                        enabled: true,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: MyTextField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "this field can't be empty";
                    }
                    return null;
                  },
                  obscureText: false,
                  hintText: "enter job here",
                  onChanged: (value) {
                    job = value;
                  },
                  enabled: true,
                ),
              ),
              toUpdate
                  ? BlocListener<UpdateBloc, UserScreenStates>(
                      listener: (context, state) {
                        if (state is UpdateSuccessState) {
                          AwesomeDialog(
                                  context: context,
                                  desc: "updated successfully .",
                                  dialogType: DialogType.success,
                                  btnOkOnPress: () {
                                    Navigator.of(context).pushNamed("HomePage");
                                  },
                                  btnOkText: "Okay")
                              .show();
                        } else if (state is UpdateErrorState) {
                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  desc: state.message,
                                  btnOkOnPress: () {
                                    Navigator.of(context).pushNamed("HomePage");
                                  },
                                  btnOkText: "Okay")
                              .show();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState!.validate() ?? false){
                                updateBloc!.add(UpdateStartEvent(
                                    name: firstName!, job: job!, userId: user!.id));
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(fontSize: 30),
                            )),
                      ),
                    )
                  : BlocListener<CreateProcessBloc, UserScreenStates>(
                      listener: (context, state) {
                        if (state is CreateSuccessState) {
                          AwesomeDialog(
                                  context: context,
                                  desc: "Created successfully .",
                                  dialogType: DialogType.success,
                                  btnOkOnPress: () {
                                    Navigator.of(context).pushNamed("HomePage");
                                  },
                                  btnOkText: "Okay")
                              .show();
                        } else if (state is CreateErrorState) {
                          AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  desc: state.message,
                                  btnOkOnPress: () {
                                    Navigator.of(context).pushNamed("HomePage");
                                  },
                                  btnOkText: "Okay")
                              .show();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()?? false){
                                createProcessBloc!.add(
                                    CreateStartEvent(name: firstName!, job: job!));
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(fontSize: 30),
                            )),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
