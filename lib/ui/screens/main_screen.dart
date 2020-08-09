import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/db_provider.dart';
import 'package:todo/ui/screens/tabs_screens/all_tasks_tab.dart';
import 'package:todo/ui/screens/tabs_screens/complete_task_tab.dart';
import 'package:todo/ui/screens/tabs_screens/in_complete_tasks_tab.dart';
import 'package:todo/ui/widgets/floatingActionButton.dart';

class MainScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String title;
  String description;
  setTitle(String value) {
    this.title = value;
  }

  setDescription(String value) {
    this.description = value;
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<DBProvider>(context, listen: false).insertNewTask(Task(
          title: this.title,
        ));
        Navigator.pop(context);
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('TODO'),
            centerTitle: true,
            bottom: TabBar(tabs: [
              Tab(
                text: 'All Tasks',
              ),
              Tab(
                text: 'Complete',
              ),
              Tab(
                text: 'InComplete',
              )
            ]),
          ),
          body: FutureBuilder<List<Task>>(
            future: Provider.of<DBProvider>(context).setAllLists(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      AllTasksTab(),
                      CompleteTasksTab(),
                      InCompleteTasksTab()
                    ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButton: FloatingActionButtonWidget(),
//
        ));
  }
}
