import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repositories/db_repository.dart';

class DBProvider extends ChangeNotifier {
  List<Task> allTasks = [];
  List<Task> completeTasks = [];
  List<Task> inCompleteTasks = [];

  Future<List<Task>> setAllLists() async {
    List<Task> tasks = await DBRepository.dbRepository.getAllData();
    this.allTasks = tasks;
    this.completeTasks = await DBRepository.dbRepository.getCompleteData();
    this.inCompleteTasks = await DBRepository.dbRepository.getInCompleteData();
    notifyListeners();

    return tasks;
  }

  insertNewTask(Task task) async {
    await DBRepository.dbRepository.insertNewTask(task);
    setAllLists();
  }

  updateTask(Task task) async {
    await DBRepository.dbRepository.updateTask(task);
    setAllLists();
  }

  deleteTask(Task task) async {
    await DBRepository.dbRepository.deleteTask(task);
    setAllLists();
  }

  deleteAllTasks() async {
    await DBRepository.dbRepository.deleteAllTasks();
    setAllLists();
  }
}