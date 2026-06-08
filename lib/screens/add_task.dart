import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
        backgroundColor: const Color(0xFF181818),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Task Name',
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _taskNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter task name';
                            }
                            return null;
                          },
                          cursorColor: const Color(0xFFFFFCFC),
                          style: const TextStyle(color: Color(0xFFFFFCFC)),
                          decoration: InputDecoration(
                            hintText: 'Finish UI design for login screen',
                            hintStyle: const TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Task Description',
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          maxLines: 5,
                          textInputAction: TextInputAction.done,

                          controller: _taskDescriptionController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter task description';
                            }
                            return null;
                          },
                          cursorColor: const Color(0xFFFFFCFC),
                          style: const TextStyle(color: Color(0xFFFFFCFC)),
                          decoration: InputDecoration(
                            hintText:
                                'Finish onboarding UI and hand off to devs by Thursday.',
                            hintStyle: const TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                          ),
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
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          /// When the user clicks Add Task -> we want to collect this data in one place.
                          /// We will create a map.

                          final task = TaskModel(
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

                          Navigator.pop(context);
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// bottomNavigationBar: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//           child: SafeArea(
//             top: false,
//             child: SizedBox(
//               height: 40,
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () async {
//                   //if (_formKey.currentState!.validate()) {
//                   /// Give me a copy of the SharedPrefrences stored on the device
//                   // final pref = await SharedPreferences.getInstance();

//                   /// Instead of reading the text twice.
//                   // final name = _nameController.text.trim();

//                   /// pref -> He still holds the application's storage file.
//                   // await pref.setString('userName', name);

//                   //if (!context.mounted) return;
//                   // Navigator.pushReplacement(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (_) => HomeScreen(name: name),
//                   //   ),
//                   // );
//                   // } else {
//                   //   return;
//                   // }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF15B86C),
//                   foregroundColor: const Color(0xFFFFFCFC),
//                 ),
//                 icon: const Icon(Icons.add),
//                 label: const Text('Add Task', style: TextStyle(fontSize: 14)),
//               ),
//             ),
//           ),
//         ),


// ----

//  Spacer(),
//                 SizedBox(
//                   height: 40,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       //if (_formKey.currentState!.validate()) {
//                       /// Give me a copy of the SharedPrefrences stored on the device
//                       // final pref = await SharedPreferences.getInstance();

//                       /// Instead of reading the text twice.
//                       // final name = _nameController.text.trim();

//                       /// pref -> He still holds the application's storage file.
//                       // await pref.setString('userName', name);

//                       //if (!context.mounted) return;
//                       // Navigator.pushReplacement(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (_) => HomeScreen(name: name),
//                       //   ),
//                       // );
//                       // } else {
//                       //   return;
//                       // }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF15B86C),
//                       foregroundColor: const Color(0xFFFFFCFC),
//                     ),
//                     child: const Text(
//                       'Add Task',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),