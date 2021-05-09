import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_example/shared/widgets/task_item.dart';

class TasksBuilder extends StatelessWidget {
  final List<Map> tasks;

  const TasksBuilder({Key key, @required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => TaskItem(
          taskModel: tasks[index],
        ),
        separatorBuilder: (context, index) => Container(
          width: double.infinity,
          height: 1.0,
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet!, Please some tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}