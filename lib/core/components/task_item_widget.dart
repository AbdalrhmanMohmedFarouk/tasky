import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_item_actions_enum.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';
import '../services/preferences_manger.dart';
import '../widgets/custom_check_box.dart';

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
      height: 56,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Color(0xFFD1DAD6)
              : Colors.transparent,
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) async {
              return onChanged(value);
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
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: TextStyle(
                      color: Color(0XFFC6C6C6),
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
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
                  print(value.name);
                  final result = await _showButtonSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }
                case TaskItemActionsEnum.delete:
                  onDelete(model.id);
                  _showAlertDialog(context);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem(
                value: e,
                child: Text(
                  e.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete task"),
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
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    GlobalKey<FormState> key = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          CustomTextFormField(
                            controller: taskNameController,
                            hintText: "Task Name",
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Pleas Enter Task Name";
                              }
                              return null;
                            },
                            title: 'Task Name',
                          ),

                          SizedBox(height: 20),

                          CustomTextFormField(
                            controller: taskDescriptionController,
                            maxLines: 5,
                            hintText:
                                "Finish onboarding UI and hand off to devs by Thursday.",
                            title: 'Task Description',
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High Priority",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        // Switch(
                        //   value: isHighPriority,
                        //   onChanged: (bool value) {
                        //     setState(() {
                        //       isHighPriority = value;
                        //     });
                        //   },
                        //   activeTrackColor: Color(0XFF15B86C),
                        // ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (key.currentState?.validate() ?? false) {
                          final taskJson = PreferencesManger().getString(
                            'tasks',
                          );
                          List<dynamic> listTasks = [];
                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                          );
                          final item = listTasks.firstWhere((e) {
                            return e['id'] == model.id;
                          });
                          final int index = listTasks.indexWhere(item);
                          listTasks[index] = newModel;
                          final taskEncode = jsonEncode(listTasks);
                          await PreferencesManger().setString(
                            'tasks',
                            taskEncode,
                          );
                          Navigator.of(context).pop(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF15B86C),
                        foregroundColor: Color(0XFFFFFCFC),
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      icon: Icon(Icons.add),
                      label: Text("Add task"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
