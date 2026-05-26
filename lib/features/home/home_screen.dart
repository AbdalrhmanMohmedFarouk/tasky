import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import '../../core/constans/storage_key.dart';
import 'components/achieved_tasks_widget.dart';
import 'components/high_priority_tasks_widget.dart';
import 'components/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  String? userImagePath;

  bool isLoading = true;
  int totalTask = 0;
  int totalDoneTask = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _lodeUserName();
    _loadTask();
  }

  void _calculatePercent() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : (totalDoneTask / totalTask);
  }

  void _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });
    final updataTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManger().setString('tasks', jsonEncode(updataTask));
  }

  _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calculatePercent();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManger().setString('tasks', jsonEncode(updatedTask));
  }

  _loadTask() async {
    final finalTask = PreferencesManger().getString('tasks');

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      final tasks = taskAfterDecode.map((element) {
        return TaskModel.fromjson(element);
      }).toList();

      print(tasks);
      setState(() {
        this.tasks = tasks;
      });
      print("task After Decode = ${taskAfterDecode}");
      print("task = ${this.tasks[0]}");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: userImagePath == null
                            ? AssetImage('assets/images/person.png')
                            : FileImage(File(userImagePath!)),
                      ),
                      SizedBox(width: 16),
                      Column(
                        children: [
                          Text(
                            "Good Evening ,$username",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "One task at a time.One step closer.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.sunny, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "Yuhuu ,Your work Is ",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "almost done ! ",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      CustomSvgPicture.withoutColor(
                        path:
                            'assets/images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasksWidget(
                    totalTask: totalTask,
                    totalDoneTask: totalDoneTask,
                    percent: percent,
                  ),
                  SizedBox(height: 16),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (value, index) {
                      _doneTask(value, index);
                    },
                    refresh: () {
                      _loadTask();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 16,
                      left: 8,
                    ),
                    child: Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
            SliverTaskListWidget(
              tasks: tasks,
              onTap: (bool? value, int? index) {
                _doneTask(value, index);
              },
              emptyMessage: ("No Data"),
              onDelete: (id) {
                _deleteTask(id);
              },
              onEdit: () {
                _loadTask();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add New Task", style: TextStyle(fontSize: 14)),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(100),
          ),
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskScreen();
                },
              ),
            );
            if (result != null && result) {
              _loadTask();
            }
          },
        ),
      ),
    );
  }

  void _lodeUserName() async {
    // await Future.delayed(Duration(seconds: 5));
    print("user name is (home) $username");
    setState(() {
      username = PreferencesManger().getString(StorageKey.username);
      isLoading = true;
      userImagePath = PreferencesManger().getString('user_image');
    });
  }
}
