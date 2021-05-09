import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_example/shared/constants.dart';
import 'package:todo_example/shared/cubit/cubit.dart';
import 'package:todo_example/shared/cubit/states.dart';
import 'package:todo_example/shared/widgets/default_form_field.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.maybePop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            key: scaffoldKey,
            // body: cubit.tasks.length == 0
            //     ? Center(
            //         child: AppGetDatabaseLoadingState(),
            //         // child: Text('No Tasks Yet'),
            //       )
            //     : cubit.screens[cubit.currentIndex],
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.black.withOpacity(0.50),
              elevation: 0,
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green.withOpacity(0.27),
              elevation: 0,
              onPressed: () {
                // try {
                //   var name = await getName();
                //   print(name);
                //   throw('some error');
                // } catch (error) {
                //   print('error ${error.toString()}');
                // }
                // getName().then((value) {
                //   print(value);
                //   throw ('made by me!!!');
                // }).catchError((error) {
                //   print('error is ${error.toString()}');
                // });
                // insertToDatabase();
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                    //   insertToDatabase(
                    //     title: titleController.text,
                    //     time: timeController.text,
                    //     date: dateController.text,
                    //   ).then((value) {
                    //     getDataFromDatabase(database).then((value) {
                    //       // setState(() {
                    //       //   isBottomSheetShown = false;
                    //       //   fabIcon = Icons.edit;
                    //       //   tasks = value;
                    //       //   print(tasks);
                    //       // });
                    //     });
                    //   });
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task title',
                                  prefix: Icons.title,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                DefaultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                DefaultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-08-05'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value);
                                      print(DateFormat.yMMMd().format(value));
                                    });
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task date',
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                // Set the transparency here
                canvasColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  AppCubit.get(context).changeIndex(index);
                  print(cubit.currentIndex);
                },
                // selectedItemColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.50),
                selectedItemColor: Colors.white,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// Future<String> getName() async {
//   return '7arooney';
// }
}