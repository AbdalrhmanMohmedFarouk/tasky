import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import '../../core/constants/storage_key.dart';
import 'components/achieved_tasks_widget.dart';
import 'components/high_priority_tasks_widget.dart';
import 'components/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          final controller = context.read<HomeController>();
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
                              backgroundImage: value.userImagePath == null
                                  ? AssetImage('assets/images/person.png')
                                  : FileImage(File(value.userImagePath!)),
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                Text(
                                  "Good Evening ,{$value.username}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                          totalTask: value.totalTask,
                          totalDoneTask: value.totalDoneTask,
                          percent: value.percent,
                        ),
                        SizedBox(height: 16),
                        HighPriorityTasksWidget(
                          tasks: value.tasks,
                          onTap: (value, index) {
                            controller.doneTask(value, index);
                          },
                          refresh: () {
                            controller.loadTask();
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
                    tasks: value.tasks,
                    onTap: (bool? value, int? index) {
                      controller.doneTask(value, index);
                    },
                    emptyMessage: ("No Data"),
                    onDelete: (id) {
                      controller.deleteTask(id);
                    },
                    onEdit: () {
                      controller.loadTask();
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
                    controller.loadTask();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
