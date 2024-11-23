import 'package:flutter/material.dart';
import '../models/Task.dart';
import '../db/TaskDb.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await Taskdb.instance.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await Taskdb.instance.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await Taskdb.instance.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await Taskdb.instance.deleteTask(id);
    await loadTasks();
  }
}