import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import '../../core/components/task_list_widget.dart';

class HighPriorityTasksScreen extends StatelessWidget {
  const HighPriorityTasksScreen({super.key});

  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.isLoading
                  ? Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
                  : Consumer<TasksController>(
                builder: (BuildContext context, value, Widget? child) {
                  return TaskListWidget(
                    tasks: value.highPriorityTask,
                    onTap: (value, index) async {
                      controller.doneHighPriorityTask(value, index);
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
      ),
    );
  }
}