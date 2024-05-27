import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:task_manager_app/modules/business_logic/cubit/app_cubit.dart';
import 'package:task_manager_app/modules/business_logic/delete_todo_logic/deleteTodoEvents.dart';
import 'package:task_manager_app/modules/business_logic/delete_todo_logic/delete_todo_bloc.dart';
import 'package:task_manager_app/modules/business_logic/delete_todo_logic/delete_todo_states.dart';
import 'package:task_manager_app/modules/business_logic/login_logic/login_bloc.dart';
import 'package:task_manager_app/modules/business_logic/pagination_bloc/pagination_bloc.dart';
import 'package:task_manager_app/modules/business_logic/pagination_bloc/pagination_states.dart';
import 'package:task_manager_app/modules/business_logic/todos_logic/all_todos_bloc.dart';
import 'package:task_manager_app/modules/business_logic/todos_logic/all_todos_events.dart';
import 'package:task_manager_app/modules/business_logic/todos_logic/all_todos_states.dart';
import 'package:task_manager_app/modules/data/models/skip_limit.dart';
import 'package:task_manager_app/modules/view/screens/add_todo.dart';

import '../../business_logic/pagination_bloc/pagination_events.dart';
import 'my_todos.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late AppCubit cubit;
  late PaginationBloc paginationBloc;
  late AllTodosBloc allTodosBloc;
  late DeleteTodoBloc deleteTodoBloc;
  late LoginBloc loginBloc;
  int pageNumber = 1;

  @override
  void initState() {
    cubit = AppCubit(1);
    loginBloc = BlocProvider.of<LoginBloc>(context);
    paginationBloc = BlocProvider.of<PaginationBloc>(context);
    allTodosBloc = BlocProvider.of<AllTodosBloc>(context);
    paginationBloc.add(PaginationFetchEvent(limit: 10, skip: 0));
    allTodosBloc.add(GetAllTodos());
    deleteTodoBloc = BlocProvider.of<DeleteTodoBloc>(context);
    deleteTodoBloc.add(DeleteTodoStartEvent(todoId: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(height: 25,),
              CircleAvatar(
                backgroundImage: NetworkImage(loginBloc.loginResponse!.image),
                radius: MediaQuery.of(context).size.width * 0.3,
              ),
              SizedBox(height: 25,),
              Text(loginBloc.loginResponse!.firstName+" "+loginBloc.loginResponse!.lastName),
              Divider(thickness: 2,),
              ListTile(title: Text("My Todos",textAlign: TextAlign.center,),onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyTodos()));
              },),
              Divider(thickness: 2,),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<AllTodosBloc, AllTodosStates>(
            builder: (context, state) {
          if (state is AllTodosSuccessState) {
            return NumberPagination(
              onPageChanged: (int pageNumber) {
                //To optimize further, use a package that supports partial updates instead of setState (e.g. riverpod)
                setState(() {
                  this.pageNumber = pageNumber;
                });
                if (pageNumber == allTodosBloc.todos!.total ~/ 10) {
                  paginationBloc.add(PaginationFetchEvent(
                      limit: 19, skip: (pageNumber - 1) * 10));
                } else {
                  paginationBloc.add(PaginationFetchEvent(
                      limit: 10, skip: (pageNumber - 1) * 10));
                }
              },
              pageInit: 1,
              // picked number when init page
              colorPrimary: Colors.blueAccent,
              threshold: 3,
              colorSub: Colors.white,
              pageTotal: allTodosBloc.todos!.total ~/ 10,
            );
          }
          return Container();
        }),
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNewTodo()));
                },
                icon: Icon(Icons.add))
          ],
          centerTitle: true,
        ),
        body: BlocConsumer<PaginationBloc, PaginationStates>(
          bloc: paginationBloc,
          builder: (context, state) {
            if (state is PaginationInProgressState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaginationSuccessState) {
              return ListView.builder(
                  itemCount: paginationBloc.skipLimit!.todos!.length,
                  itemBuilder: (context, i) {
                    final item = paginationBloc.skipLimit!.todos![i];
                    return BlocBuilder<DeleteTodoBloc, DeleteTodoStates>(
                        builder: (context, state) {
                      if (state is DeleteTodoSuccessState) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: ListTile(
                            trailing: IconButton(onPressed: (){
                              deleteTodoBloc.add(DeleteTodoStartEvent(todoId: paginationBloc.skipLimit!.todos![i].id!));
                              paginationBloc.add(PaginationFetchEvent(limit: 10, skip: pageNumber));
                            },icon: Icon(Icons.delete,color: Colors.white,),),
                            title: Text(
                                "todo id : ${paginationBloc.skipLimit!.todos![i].id.toString()}"),
                            subtitle: Text(
                                paginationBloc.skipLimit!.todos![i].todo!),
                          ),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: ListTile(
                          trailing: IconButton(onPressed: (){
                            deleteTodoBloc.add(DeleteTodoStartEvent(todoId: paginationBloc.skipLimit!.todos![i].id!));
                            paginationBloc.add(PaginationFetchEvent(limit: 10, skip: pageNumber));
                          },icon: Icon(Icons.delete,color: Colors.white,),),
                          title: Text(
                              "todo id : ${paginationBloc.skipLimit!.todos![i].id.toString()}"),
                          subtitle:
                              Text(paginationBloc.skipLimit!.todos![i].todo!),
                        ),
                      );
                    });
                  });
            }
            return Container();
          },
          listener: (context, state) {
            if (state is PaginationErrorState) {
              AwesomeDialog(
                      context: context,
                      desc: state.message,
                      btnOkOnPress: () {},
                      btnOkColor: Colors.blue,
                      dialogType: DialogType.info)
                  .show();
            }
          },
        ),
      ),
    );
  }
}
