import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import '../../core/components/task_list_widget.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
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
            child: controller.isLoading
                ? Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
                : Consumer<TasksController>(
              builder: (BuildContext context, valueController, Widget? child) {
                return TaskListWidget(
                  tasks: valueController.completeTasks,
                  onTap: (value, index) async {
                    controller.doneTask(value,valueController.completeTasks[index!].id );
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
