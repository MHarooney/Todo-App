import 'package:flutter/material.dart';
import 'package:todo_example/shared/cubit/cubit.dart';

class TaskItem extends StatelessWidget {
  Map taskModel;

  TaskItem({
    @required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return Dismissible(
      key: Key(taskModel['id'].toString()),
      onDismissed: (directions) {
        AppCubit.get(context).deleteDataFromDatabase(
          id: taskModel['id'],
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${taskModel['time']}'),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${taskModel['title']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${taskModel['date']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            IconButton(
              onPressed: () {
                cubit.updateDataFromDatabase(
                  status: 'done',
                  id: taskModel['id'],
                );
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green[200],
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.updateDataFromDatabase(
                  status: 'archived',
                  id: taskModel['id'],
                );
              },
              icon: Icon(
                Icons.archive,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}