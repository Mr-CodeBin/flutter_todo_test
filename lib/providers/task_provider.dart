import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_test/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void addTask(TaskModel task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void markAsDone(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks[index].deleted = true;

    notifyListeners();

    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        _tasks.removeAt(index);
        saveTasks();
        notifyListeners();
      },
    );
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = prefs.getString('tasks');
    if (tasks != null) {
      final List<dynamic> taskList = jsonDecode(tasks);
      _tasks = taskList.map((e) => TaskModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', jsonEncode(_tasks));
  }
}
