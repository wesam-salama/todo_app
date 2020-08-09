import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/db_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  Task task;
  TaskItem(this.task);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        child: ListTile(
          title: Text(task.title),
          trailing: Checkbox(
            value: task.isComplete,

          onChanged: (value) {
              Provider.of<DBProvider>(context, listen: false).updateTask(task);
            },)
        ),
      ),

      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () =>
              Provider.of<DBProvider>(context, listen: false).deleteTask(task),
        ),
      ],
    );
//    Dismissible(
//      key: ObjectKey(task),
//      onDismissed: (direction) {
//
//        Provider.of<DBProvider>(context, listen: false).deleteTask(task);
//      },
//      child: Card(
//        child: ListTile(
//          title: Text(task.title),
//          trailing: Checkbox(
//            value: task.isComplete,
//            onChanged: (value) {
//              Provider.of<DBProvider>(context, listen: false).updateTask(task);
//            },
//          ),
//        ),
//      ),
//    );
  }
}
