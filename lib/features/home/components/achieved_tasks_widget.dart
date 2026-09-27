import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular( AppSizes.radius(20)),
          ),
          padding: EdgeInsetsGeometry.all(AppSizes.sizeW(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achieved Tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSizes.sizeH(14)),
                  Text(
                    '${controller.totalDoneTask} Out of ${controller.totalTask} Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      width: AppSizes.sizeW(48),
                      height: AppSizes.sizeH(48),
                      child: CircularProgressIndicator(
                        value: controller.percent,
                        backgroundColor: Color(0XFF6D6D6D),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0XFF15B86C),
                        ),
                        strokeWidth: AppSizes.sizeW(4),
                        // strokeAlign: 50,
                      ),
                    ),
                  ),
                  Text(
                    '${(controller.percent * 100).toInt()}%',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
