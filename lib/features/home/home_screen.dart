import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/home/home_controller.dart';

import 'package:tasky/features/add_task/add_task_screen.dart';

import 'components/achieved_tasks_widget.dart';
import 'components/high_priority_tasks_widget.dart';
import 'components/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
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
                        Selector<HomeController, String?>(
                          selector: (context, HomeController controller) {
                            return controller.userImagePath;
                          },
                          builder:
                              (
                                BuildContext context,
                                String? userImagePath,
                                Widget? child,
                              ) {
                                return CircleAvatar(
                                  backgroundImage: userImagePath == null
                                      ? AssetImage('assets/images/person.png')
                                      : FileImage(File(userImagePath)),
                                );
                              },
                        ),
                        SizedBox(width: 16),
                        Column(
                          children: [
                            Selector<HomeController, String?>(
                              selector: (context, controller) =>
                                  controller.username,
                              builder:
                                  (
                                    BuildContext context,
                                    String? username,
                                    Widget? child,
                                  ) {
                                    return Text(
                                      "Good Evening ,$username",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    );
                                  },
                            ),
                            Text(
                              "One task at a time.One step closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        //Icon(Icons.sunny, color: Colors.white),
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
                    AchievedTasksWidget(),
                    SizedBox(height: 16),
                    HighPriorityTasksWidget(),
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
              SliverTaskListWidget(),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 40,
          child: Builder(
            builder: (BuildContext context ) {
              return FloatingActionButton.extended(
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
                 context.read<HomeController>().init();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
