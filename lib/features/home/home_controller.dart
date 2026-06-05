import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manger.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  List<TaskModel> tasks = [];
  String? userImagePath;

  bool isLoading = true;
  int totalTask = 0;
  int totalDoneTask = 0;
  double percent = 0;


  void init() {
    lodeUserName();
    loadTask();
  }

  void lodeUserName() async {
    // await Future.delayed(Duration(seconds: 5));
    print("user name is (home) $username");

    username = PreferencesManger().getString(StorageKey.username);
    isLoading = true;
    userImagePath = PreferencesManger().getString(StorageKey.userImage);
    notifyListeners();
  }

  void loadTask() async {
    final finalTask = PreferencesManger().getString(StorageKey.tasks);

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      final tasks = taskAfterDecode.map((element) {
        return TaskModel.fromjson(element);
      }).toList();

      print(tasks);

      this.tasks = tasks;

      print("task After Decode = ${taskAfterDecode}");
      print("task = ${this.tasks[0]}");
    }
    isLoading = false;
    notifyListeners();
  }

  void calculatePercent() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : (totalDoneTask / totalTask);
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updataTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManger().setString(StorageKey.tasks, jsonEncode(updataTask));
    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((task) => task.id == id);
    calculatePercent();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManger().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }
}
