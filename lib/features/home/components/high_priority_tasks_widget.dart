import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/tasks/high_priority_tasks_screen.dart';

import '../../tasks/controllers/tasks_controller.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (
          BuildContext context,
          TasksController controller,
          Widget? child,
          ) {
        final tasksList = controller.tasks;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( AppSizes.radius(20)),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all( AppSizes.sizeW(16)),
                      child: Text(
                        'High Priority Tasks',
                        style: TextStyle(
                          color: Color(0XFF15B86C),
                          fontSize:  AppSizes.fontSize(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                      tasksList.reversed
                          .where((e) => e.isHighPriority)
                          .length >
                          4
                          ? 4
                          : tasksList.reversed
                          .where((e) => e.isHighPriority)
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        final task = tasksList.reversed
                            .where((e) => e.isHighPriority)
                            .toList()[index];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckBox(
                              value: task.isDone,
                              onChanged: (bool? value) {
                                controller.doneTask(value, task.id);
                              },
                            ),
                            SizedBox(width:  AppSizes.sizeW(4)),
                            Expanded(
                              child: Text(
                                task.taskName,
                                maxLines: 1,
                                style: task.isDone
                                    ? Theme.of(context).textTheme.titleLarge
                                    : Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return HighPriorityTasksScreen();
                      },
                    ),
                  );

                  controller.init();
                },
                child: Padding(
                  padding:  EdgeInsets.all( AppSizes.sizeW(16)),
                  child: Container(
                    padding:  EdgeInsets.all( AppSizes.sizeH(8)),
                    width:  AppSizes.sizeW(56),
                    height:  AppSizes.sizeH(48),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child:  CustomSvgPicture(
                      path: 'assets/icons/arrow_up_right.svg',
                      width:  AppSizes.sizeW(24),
                      height:  AppSizes.sizeH(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}