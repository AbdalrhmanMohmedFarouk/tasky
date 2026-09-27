import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/file_storage_manger.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = false;

  void addtask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      PreferencesManger().getString(StorageKey.tasks);

      final taskJson = PreferencesManger().getString(StorageKey.tasks);
      List<dynamic> listTasks = [];
      if (taskJson != null) {
        listTasks = jsonDecode(taskJson);
      }
      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      print("==========================");
      print(listTasks);
      print("==========================");
      listTasks.add(model.toJson());
      print(listTasks);
      print("==========================");

      FileStorageManger().saveTask(listTasks);

      final taskEncode = jsonEncode(listTasks);
      await PreferencesManger().setString(StorageKey.tasks, taskEncode);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
