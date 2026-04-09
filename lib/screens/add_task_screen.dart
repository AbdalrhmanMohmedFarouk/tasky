import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/models/task_model.dart';
import '../core/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFFFFCFC),
                      ),
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
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      PreferencesManger().getString('tasks');



                      final taskJson = PreferencesManger().getString('tasks');
                      List<dynamic> listTasks = [];
                      if (taskJson != null) {
                        listTasks = jsonDecode(taskJson);
                      }
                      TaskModel model = TaskModel(
                        id: listTasks.length + 1,
                        taskName: taskNameController.text,
                        taskDescription: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      print("==========================");
                      print(listTasks);
                      print("==========================");
                      listTasks.add(model.toJson());
                      print(listTasks);
                      print("==========================");

                      final taskEncode = jsonEncode(listTasks);
                      await PreferencesManger().setString('tasks',taskEncode );


                      Navigator.of(context).pop(true);
                    }
                    ;
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
        ),
      ),
    );
  }
}
