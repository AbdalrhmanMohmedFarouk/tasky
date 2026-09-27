import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;

  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
  final String emptyMessage;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessage ?? "No Data",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        : ListView.separated(
            itemCount: tasks.length,
            padding: EdgeInsets.only(bottom:  AppSizes.sizeH(50)),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:  EdgeInsets.only(top:  AppSizes.sizeH(8)),
                child: TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDelete: (int id) {
                    onDelete(id);
                  },
                  onEdit: () {
                    onEdit();
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: AppSizes.sizeH(8));
            },
          );
  }
}
