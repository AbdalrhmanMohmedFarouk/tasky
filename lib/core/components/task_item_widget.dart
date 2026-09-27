import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/enums/task_item_actions_enum.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/services/preferences_manger.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.sizeH(54),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius(20)),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          SizedBox(width: AppSizes.sizeW(8)),

          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) {
              onChanged(value);
            },
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: TextStyle(
                      color: Color(0XFFC6C6C6),
                      fontSize: AppSizes.fontSize(14),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0XFFA0A0A0) : Color(0XFFC6C6C6))
                  : (model.isDone ? Color(0XFFC6C6C6) : Color(0XFF3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);

                case TaskItemActionsEnum.edit:
                  final result = await _showButtonSheet(context, model);

                  if (result == true) {
                    onEdit();
                  }

                case TaskItemActionsEnum.delete:
                  _showAlertDialog(context);
              }
            },
            itemBuilder: (context) {
              return TaskItemActionsEnum.values.map((e) {
                return PopupMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),

            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) {
    final TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );

    final TextEditingController taskDescriptionController =
        TextEditingController(text: model.taskDescription);

    final GlobalKey<FormState> key = GlobalKey<FormState>();

    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: AppSizes.sizeW(16),
                right: AppSizes.radius(16),
                top: AppSizes.sizeH(8),
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Form(
                key: key,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: AppSizes.sizeH(20)),

                      Center(
                        child: Container(
                          width: AppSizes.sizeW(40),
                          height: AppSizes.sizeH(4),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radius(10),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: AppSizes.sizeH(25)),

                      CustomTextFormField(
                        controller: taskNameController,
                        hintText: "Task Name",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Task Name";
                          }

                          return null;
                        },
                        title: 'Task Name',
                      ),

                      SizedBox(height: AppSizes.sizeH(20)),

                      CustomTextFormField(
                        controller: taskDescriptionController,
                        maxLines: 5,
                        hintText:
                            "Finish onboarding UI and hand off to devs by Thursday.",
                        title: 'Task Description',
                      ),

                      SizedBox(height: AppSizes.sizeH(20)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          Switch(
                            value: isHighPriority,
                            onChanged: (bool value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                            activeTrackColor: Color(0XFF15B86C),
                          ),
                        ],
                      ),

                      SizedBox(height: AppSizes.sizeH(25)),

                      ElevatedButton.icon(
                        onPressed: () async {
                          if (!(key.currentState?.validate() ?? false)) {
                            return;
                          }

                          final taskJson = PreferencesManger().getString(
                            StorageKey.tasks,
                          );

                          List<dynamic> listTasks = [];

                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }

                          final int index = listTasks.indexWhere(
                            (e) => e['id'] == model.id,
                          );

                          if (index == -1) {
                            return;
                          }

                          final TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text.trim(),
                            taskDescription: taskDescriptionController.text
                                .trim(),
                            isDone: model.isDone,
                            isHighPriority: isHighPriority,
                          );

                          listTasks[index] = newModel.toJson();

                          final String taskEncode = jsonEncode(listTasks);

                          await PreferencesManger().setString(
                            StorageKey.tasks,
                            taskEncode,
                          );

                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        },
                        icon: Icon(Icons.save),
                        label: Text("Save"),
                      ),

                      SizedBox(height: AppSizes.sizeH(10)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
