import 'dart:core';
import 'package:flutter/material.dart';

import 'package:tasky/core/services/hive_storage_manger.dart';

import '../../../models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;
  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTask = [];
  int totalTask = 0;
  int totalDoneTask = 0;
  double percent = 0;

  init() {
    _loadTasks();
  }

  void _loadTasks() async {
    isLoading = true;

    tasks = HiveStorageManger().loadTasks();

    _loadData();

    _calculatePercent();

    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int id) async {
    final index = tasks.indexWhere((e) => e.id == id);

    tasks[index].isDone = value ?? false;
    _loadData();
    _calculatePercent();

    HiveStorageManger().saveTasks(tasks);

    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((e) => e.id == id);
    _loadData();
    _calculatePercent();

    HiveStorageManger().saveTasks(tasks);
    notifyListeners();
  }

  void _calculatePercent() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : (totalDoneTask / totalTask);
    notifyListeners();
  }

  void _loadData() async {
    HiveStorageManger().loadTasks();

    todoTasks = tasks.where((element) => element.isDone == false).toList();
    completeTasks = tasks.where((element) => element.isDone == true).toList();

    highPriorityTask = tasks
        .where((element) => element.isHighPriority)
        .toList();
    highPriorityTask = highPriorityTask.reversed.toList();
  }

  clearTasks() {
    _loadTasks();
  }
}
