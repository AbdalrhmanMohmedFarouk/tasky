import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import '../../../core/constants/storage_key.dart';
import '../../../core/services/preferences_manger.dart';
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

  void _loadTasks() {
    isLoading = true;
    final finalTask = PreferencesManger().getString(StorageKey.tasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode.map((element) {
        return TaskModel.fromjson(element);
      }).toList();

      _loadData();

      _calculatePercent();
    }

    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int id) async {

    final index = tasks.indexWhere((e) => e.id == id);

    tasks[index].isDone = value ?? false;
    _loadData();
    _calculatePercent();


    final updatedTask = tasks.map((element) => element.toJson()).toList();

    PreferencesManger().setString(StorageKey.tasks, jsonEncode(tasks));

    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((e)=>e.id==id);
   _loadData();
   _calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManger().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }

  void _calculatePercent() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : (totalDoneTask / totalTask);
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((element) => element.isDone == false).toList();
    completeTasks = tasks.where((element) => element.isDone == true).toList();

    highPriorityTask = tasks
        .where((element) => element.isHighPriority)
        .toList();
    highPriorityTask = highPriorityTask.reversed.toList();
  }
}
