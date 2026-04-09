import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/high_priority_tasks_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,

    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;

  final Function(bool?, int?) onTap;

  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'High Priority Tasks',
                    style: TextStyle(
                      color: Color(0XFF15B86C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                ...tasks.reversed
                    .where((e) => e.isHighPriority == true)
                    .take(4)
                    .map((element) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckBox(
                            value: element.isDone,
                            onChanged: (bool? value) {
                              final index = tasks.indexWhere((e) {
                                return e.id == element.id;
                              });
                              onTap(value, index);
                            },
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              element.taskName,
                              style: element.isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final reuslt = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityTasksScreen();
                  },
                ),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(8),
                width: 56,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: CustomSvgPicture(
                  path: 'assets/icons/arrow_up_right.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
