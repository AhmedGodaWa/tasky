import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/core/widgets/primary_button.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHighPriority = true;

  @override
  void dispose() {
    super.dispose();
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        // backgroundColor: const Color(0xFF181818),
        appBar: AppBar(
          backgroundColor: const Color(0xFF181818),
          foregroundColor: const Color(0xFFFFFCFC),
          titleSpacing: 0,
          centerTitle: false,
          title: const Text('New Task', style: TextStyle(fontSize: 22)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),

                        CustomTextFormField(
                          controller: _taskNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter task name';
                            }
                            return null;
                          },
                          title: 'Task Name',
                          hintText: 'Finish UI design for login screen',
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 20),

                        CustomTextFormField(
                          maxLines: 5,
                          controller: _taskDescriptionController,
                          title: 'Task Description',
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                          textInputAction: TextInputAction.done,
                        ),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'High Priority',
                              style: TextStyle(
                                color: Color(0xFFFFFCFC),
                                fontSize: 16,
                              ),
                            ),
                            Switch(
                              activeTrackColor: const Color(0xFF15B86C),
                              value: isHighPriority,
                              onChanged: (value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SafeArea(
                  top: false,
                  child: PrimaryButton(
                    text: 'Add Task',
                    icon: Icons.add,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final task = TaskModel(
                          id: DateTime.now().microsecondsSinceEpoch.toString(),
                          taskName: _taskNameController.text,
                          taskDescription: _taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                        );

                        final pref = await SharedPreferences.getInstance();

                        final tasksJson = pref.getString('tasks');

                        List<dynamic> tasks = [];

                        if (tasksJson != null) {
                          tasks = jsonDecode(tasksJson);
                        }

                        tasks.add(task.toJson());

                        final updateTasksJson = jsonEncode(tasks);

                        await pref.setString('tasks', updateTasksJson);

                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          /// When the user clicks Add Task -> we want to collect this data in one place.
                          /// We will create a map.

                          final task = TaskModel(
                            id: DateTime.now().microsecondsSinceEpoch
                                .toString(),

                            taskName: _taskNameController.text,
                            taskDescription: _taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                          );

                          /// If the user clicks Add Task a second time,
                          /// How do I find the old tasks?
                          /// I need to retrieve them first.

                          final pref = await SharedPreferences.getInstance();

                          /// I don't bring one Task.
                          /// I bring the Tasks here.
                          final tasksJson = pref.getString('tasks');

                          /*
                          We'll create an empty list,
                          in case the user is adding a task for the first time or if there's old data stored as a string.
                          We'll work on the empty list.
                          */

                          List<dynamic> tasks = [];

                          /*
                          If there are old tasks,
                          jsonDecode will convert them from strings to maps or objects.
                          */
                          if (tasksJson != null) {
                            tasks = jsonDecode(tasksJson);
                          }

                          /// When we add a new task, we need to add it to the list so that it is stored with the old tasks.
                          tasks.add(task.toJson());

                          /*
                          We need to store it in the shared preference,
                          but it can't store this list because it's a dynamic list,
                          and we need to return a string.
                          */
                          final updateTasksJson = jsonEncode(tasks);

                          /// We have now finished the entire saving process.
                          await pref.setString('tasks', updateTasksJson);

                          Navigator.pop(context, true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF15B86C),
                        foregroundColor: const Color(0xFFFFFCFC),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Add Task',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),

 */
