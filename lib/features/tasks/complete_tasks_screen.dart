import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/models/task_model.dart';
import '../../core/components/task_list_widget.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> completeTask = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final finalTask = PreferencesManger().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        completeTask = taskAfterDecode
            .map((element) => TaskModel.fromjson(element))
            .where((element) => element.isDone == true)
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
    final finalTask = PreferencesManger().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromjson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        completeTask.removeWhere((task) => task.id == id);
      });

      final updatedTask = tasks.map((element) => element.toJson()).toList();
      PreferencesManger().setString('tasks', jsonEncode(updatedTask));
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
            "Completed Task",
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : TaskListWidget(
                    tasks: completeTask,
                    onTap: (value, index) async {
                      setState(() {
                        completeTask[index!].isDone = value ?? false;
                      });

                      // final finalTask=PreferencesManger().getString('tasks');
                      // final updatedTask = tasks
                      //     .map((element) => element.toJson())
                      //     .toList();

                      final allData = PreferencesManger().getString('tasks');
                      if (allData != null) {
                        final List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromjson(element))
                                .toList();
                        final int newIndex = allDataList.indexWhere(
                          (e) => e.id == completeTask[index!].id,
                        );
                        allDataList[newIndex] = completeTask[index!];
                        await PreferencesManger().setString(
                          'tasks',
                          jsonEncode(allDataList),
                        );
                        _loadTask();
                      }
                    },
                    emptyMessage: ("No Task Found"),
                    onDelete: (int? id) {
                      _deleteTask(id);
                    }, onEdit: (){
                      _loadTask();
            },
                  ),
          ),
        ),
      ],
    );
  }
}
