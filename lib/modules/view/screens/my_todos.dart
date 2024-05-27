import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/modules/business_logic/login_logic/login_bloc.dart';
import 'package:task_manager_app/modules/business_logic/my_todo_logic/my_todos_bloc.dart';
import 'package:task_manager_app/modules/business_logic/my_todo_logic/my_todos_events.dart';
import 'package:task_manager_app/modules/business_logic/my_todo_logic/my_todos_state.dart';

class MyTodos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTodosState();
  }
}

class MyTodosState extends State<MyTodos> {
  late MyTodosBloc myTodosBloc;
  late LoginBloc loginBloc;
  @override
  void initState() {
    myTodosBloc = BlocProvider.of<MyTodosBloc>(context);
    loginBloc = BlocProvider.of<LoginBloc>(context);
    print(loginBloc.loginResponse!.id);
    myTodosBloc.add(GetMyTodosStartEvent(userId: loginBloc.loginResponse!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My todos"),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<MyTodosBloc, MyTodosStates>(builder: (context, state) {
        if (state is MyTodosInProgressState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MyTodosSuccessState) {
          print("success state");
          return ListView.builder(
            itemCount: myTodosBloc.todosByUser!.total,
            itemBuilder: (context, i) => Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.blue),
              child: ListTile(
                title:
                    Text("todo id : ${myTodosBloc.todosByUser!.todos[i].id}"),
                subtitle: Text(myTodosBloc.todosByUser!.todos[i].todo),
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
