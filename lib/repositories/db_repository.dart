import 'package:todo/models/task_model.dart';
import 'package:todo/repositories/db_client.dart';

class DBRepository {
  DBRepository._();
  static final DBRepository dbRepository = DBRepository._();

  insertNewTask(Task task) async {
    await DBClient.dbClient.insertNewTask(task.toJson());
  }

  Future<List<Task>> getAllData() async {
    List<Map<String, dynamic>> results = await DBClient.dbClient.getAllTasks();
    List<Task> tasks = results.map((e) => Task.fromJson(e)).toList();
    return tasks;
  }

  Future<List<Task>> getCompleteData() async {
    List<Map<String, dynamic>> results =
    await DBClient.dbClient.getCompleteTasks();
    List<Task> tasks = results.map((e) => Task.fromJson(e)).toList();
    return tasks;
  }

  Future<List<Task>> getInCompleteData() async {
    List<Map<String, dynamic>> results =
    await DBClient.dbClient.getInCompleteTasks();
    List<Task> tasks = results.map((e) => Task.fromJson(e)).toList();
    return tasks;
  }

  Future<int> updateTask(Task task) async {
    task.toggleTask();
    int x = await DBClient.dbClient.updateTask(task.toJson(), task.id);
    return x;
  }

  Future<int> deleteTask(Task task) async {
    int x = await DBClient.dbClient.deleteTask(task.id);
    return x;
  }

  deleteAllTasks() async {
    await DBClient.dbClient.deleteAllTasks();
  }
}