import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasky/features/add_task/add_task_controller.dart';

import '../../core/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Form(
                key: controller.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: controller.taskNameController,
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
                            controller: controller.taskDescriptionController,
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
                        Consumer<AddTaskController>(
                          builder:
                              (
                                BuildContext context,
                                AddTaskController value,
                                Widget? child,
                              ) {
                                return Switch(
                                  value: value.isHighPriority,
                                  onChanged: (bool value) {
                                    controller.toggle(value);
                                  },
                                  activeTrackColor: Color(0XFF15B86C),
                                );
                              },
                        ),
                      ],
                    ),
                    Spacer(),
                    Consumer(
                      builder:
                          (
                            BuildContext context,
                            AddTaskController controller,
                            Widget? child,
                          ) {
                            return ElevatedButton.icon(
                              onPressed: () async {
                                context.read<AddTaskController>().addtask(
                                  context,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF15B86C),
                                foregroundColor: Color(0XFFFFFCFC),
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width,
                                  40,
                                ),
                              ),
                              icon: Icon(Icons.add),
                              label: Text("Add task"),
                            );
                          },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
