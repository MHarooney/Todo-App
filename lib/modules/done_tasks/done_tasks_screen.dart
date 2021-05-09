import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_example/shared/cubit/cubit.dart';
import 'package:todo_example/shared/cubit/states.dart';
import 'package:todo_example/shared/widgets/conditional_builder.dart';
import 'package:todo_example/shared/widgets/task_item.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state){},
      builder: (BuildContext context, AppStates state){
        var tasks = AppCubit.get(context).doneTasks;
        return TasksBuilder(tasks: tasks);
      },
    );
  }
}