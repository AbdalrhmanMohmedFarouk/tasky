import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class ToDoTasksScreen extends StatelessWidget {
  const ToDoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizes.sizeW(18)),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.sizeW(16)),
            child: controller.isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : Consumer<TasksController>(
                    builder:
                        (BuildContext context, valueController, Widget? child) {
                          return TaskListWidget(
                            tasks: valueController.todoTasks,
                            onTap: (value, index) async {
                              controller.doneTask(
                                value,
                                valueController.todoTasks[index!].id,
                              );
                            },
                            emptyMessage: ("No Task Found"),
                            onDelete: (int? id) {
                              controller.deleteTask(id);
                            },
                            onEdit: () {
                              controller.init();
                            },
                          );
                        },
                  ),
          ),
        ),
      ],
    );
  }
}
