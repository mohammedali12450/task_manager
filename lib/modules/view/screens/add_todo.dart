import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/add_todo_logic/add_todo_blco.dart';
import 'package:task_manager_app/modules/business_logic/add_todo_logic/add_todo_events.dart';
import 'package:task_manager_app/modules/business_logic/add_todo_logic/add_todo_states.dart';
import 'package:task_manager_app/modules/business_logic/login_logic/login_bloc.dart';
import 'package:task_manager_app/modules/view/screens/home_page.dart';

class AddNewTodo extends StatefulWidget {
  const AddNewTodo({super.key});

  @override
  State<AddNewTodo> createState() => _AddNewTodoState();
}

class _AddNewTodoState extends State<AddNewTodo> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late LoginBloc loginBloc;
  late AddTodoBloc addTodoBloc;
  bool selectedItem = false;
  late String todo;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    addTodoBloc = BlocProvider.of<AddTodoBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "enter your text here",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  maxLines: 5,
                  onChanged: (value) {
                    todo = value;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      "select the status",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          child: Text('true'),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text('false'),
                          value: false,
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value!;
                        });
                      },
                      value: selectedItem,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                BlocListener<AddTodoBloc,AddTodoStates>(
                  listener: (context, state) {
                    if (state is AddTodoSuccessState) {
                      AwesomeDialog(
                          context: context,
                          desc: "you have successfully added your todo",
                          btnOkColor: Colors.blue,
                          btnOkText: "okay",
                          btnOkOnPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }).show();
                    }else if (state is AddTodoErrorState){
                      AwesomeDialog(
                          context: context,
                          desc: state.message,
                          btnOkColor: Colors.blue,
                          btnOkText: "okay",
                          btnOkOnPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }).show();
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      addTodoBloc.add(AddNewTodoEvent(
                          todo: todo,
                          userId: loginBloc.loginResponse!.id,
                          completed: selectedItem));
                    },
                    child: Text("add"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
