import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manger.dart';
import '../../core/components/task_list_widget.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  State<HighPriorityTasksScreen> createState() =>
      _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
  List<TaskModel> highPriorityTask = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = false;
    });

    final finalTask = PreferencesManger().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        highPriorityTask = taskAfterDecode
            .map((element) => TaskModel.fromjson(element))
            .where((element) => element.isHighPriority)
            .toList();
        highPriorityTask = highPriorityTask.reversed.toList();
      });
    }
  }

  _deleteTask(int? id) async {
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
        highPriorityTask.removeWhere((task) => task.id == id);
      });

      final updatedTask = tasks.map((element) => element.toJson()).toList();
      PreferencesManger().setString(StorageKey.tasks, jsonEncode(updatedTask));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : TaskListWidget(
                      tasks: highPriorityTask,
                      onTap: (value, index) async {
                        setState(() {
                          highPriorityTask[index!].isDone = value ?? false;
                        });
                        final finalTask = PreferencesManger().getString(
                          StorageKey.tasks,
                        );

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
                            (e) => e.id == highPriorityTask[index!].id,
                          );
                          allDataList[newIndex] = highPriorityTask[index!];

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
      ),
    );
  }
}
