import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manger.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final finalTask = PreferencesManger().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromjson(element))
            .where((element) => !element.isDone)
            .toList();
        // tasks = tasks.where((element)=>element.isDone == false).toList();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;
    final finalTask = PreferencesManger().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromjson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        todoTasks.removeWhere((task) => task.id == id);
      });

      final updatedTask = tasks.map((element) => element.toJson()).toList();
      PreferencesManger().setString(StorageKey.tasks, jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : TaskListWidget(
                    tasks: todoTasks,
                    onTap: (value, index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });

                      // final updatedTask = tasks
                      //     .map((element) => element.toJson())
                      //     .toList();

                      final allData = PreferencesManger().getString(StorageKey.tasks);
                      if (allData != null) {
                        final List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromjson(element))
                                .toList();
                        final int newIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );
                        allDataList[newIndex] = todoTasks[index!];

                        PreferencesManger().setString(
                          StorageKey.tasks,
                          jsonEncode(allDataList),
                        );
                        _loadTask();
                      }
                    },
                    emptyMessage: ("No Task Found"),
                    onDelete: (int? id) {
                      _deleteTask(id);
                    },
                    onEdit: () {
                      _loadTask();
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
