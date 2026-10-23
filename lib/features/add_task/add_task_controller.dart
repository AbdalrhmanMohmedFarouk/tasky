import 'package:flutter/material.dart';

import 'package:tasky/core/services/hive_storage_manger.dart';

import 'package:tasky/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = false;

  void addtask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      // PreferencesManger().getString(StorageKey.tasks);

      final List<TaskModel> listTasks =  HiveStorageManger().loadTasks() ;

      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      print("==========================");
      print(listTasks);
      print("==========================");
    listTasks.add(model);

      HiveStorageManger().saveTasks(listTasks);


      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
