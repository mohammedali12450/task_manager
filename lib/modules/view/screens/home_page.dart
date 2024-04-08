import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:task_manager_app/modules/business_logic/cubit/app_cubit.dart';
import 'package:task_manager_app/modules/business_logic/navigation_bloc/navigation_bloc.dart';
import 'package:task_manager_app/modules/business_logic/navigation_bloc/navigation_events.dart';
import 'package:task_manager_app/modules/business_logic/navigation_bloc/navigation_states.dart';
import 'package:task_manager_app/modules/view/screens/user_screen.dart';

import '../../business_logic/pagination_bloc/pagination_bloc.dart';
import '../../business_logic/pagination_bloc/pagination_events.dart';
import '../../business_logic/pagination_bloc/pagination_states.dart';
import '../widgets/custom_container.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late PaginationBloc paginationBloc;
  late NavigationBloc navigationBloc;
  late AppCubit cubit;
  @override
  void initState() {
    paginationBloc = BlocProvider.of<PaginationBloc>(context);
    paginationBloc.add(PaginationFetchEvent(pageNumber: 1));
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
    navigationBloc.add(NavigateEvent(pageNumber: 1));
    cubit = AppCubit(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserScreen(toUpdate: false)));
          },
        ),
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: BlocBuilder<PaginationBloc,PaginationStates>(
        builder:(context,state) {
          if(state is PaginationSuccessState){
            return Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<AppCubit,dynamic>(
                    bloc: cubit,
                    builder:(_,pageNumber)=> NumberPagination(
                      onPageChanged: (onPageChanged) {
                        cubit.setState(onPageChanged);
                        navigationBloc
                            .add(NavigateEvent(pageNumber: onPageChanged));
                      },
                      pageTotal: paginationBloc.pagination!.totalPages,
                      pageInit: pageNumber,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<NavigationBloc, NavigationStates>(
                      builder: (context, state) {
                        if (state is NavigateInProgressState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is NavigateSuccessState) {
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: ListView.builder(
                                  itemBuilder: (context, index) => InkWell(
                                    child: CustomContainer(
                                      url: paginationBloc.pagination!.data[index].avatar,
                                      firstName:
                                      paginationBloc.pagination!.data[index].firstName,
                                      lastName:
                                      paginationBloc.pagination!.data[index].lastName,
                                      email: paginationBloc.pagination!.data[index].email,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => UserScreen(
                                              toUpdate: true,
                                              user:
                                              paginationBloc.pagination!.data[index])));
                                    },
                                  ),
                                  itemCount: paginationBloc.pagination!.perPage,
                                ),
                              ),

                            ],
                          );
                        }else if (state is NavigateErrorState){
                          return Center(child: Text(state.message,),);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),

              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
