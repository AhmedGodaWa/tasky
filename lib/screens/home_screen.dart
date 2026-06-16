import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTasks();
  }

  Future<void> _loadUserName() async {
    final pref = await SharedPreferences.getInstance();

    final savedName = pref.getString('userName');

    if (savedName != null) {
      setState(() {
        userName = savedName;
      });
    }
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    //await Future.delayed(const Duration(seconds: 3));
    final pref = await SharedPreferences.getInstance();

    final taskJson = pref.getString('tasks');

    if (taskJson != null) {
      final List<dynamic> decodedTasks = jsonDecode(taskJson);

      final loadedTasks = decodedTasks
          .map<TaskModel>((taskMap) => TaskModel.fromJson(taskMap))
          .toList();

      setState(() {
        tasks = loadedTasks;
        isLoading = false;
      });
    }
  }

  Future<void> _saveTasks() async {
    final pref = await SharedPreferences.getInstance();

    final taskJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await pref.setString('tasks', taskJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF181818),
      floatingActionButton: SizedBox(
        height: 45,
        //width: 167,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTask()),
            );
            if (result != null && result == true) {
              await _loadTasks();
            }
          },
          backgroundColor: const Color(0xFF15B86C),
          foregroundColor: const Color(0xFFFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Add New Task'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/person.png',
                    height: 42,
                    width: 42,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening, $userName',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                      const Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                'Yuhuu ,Your work Is almost done !',
                style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 32),
              ),

              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Tasks',
                      style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
                    ),

                    const SizedBox(height: 16),
                    Expanded(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF15B86C),
                              ),
                            )
                          : tasks.isEmpty
                          ? const Center(
                              child: Text(
                                'No Data',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 55),
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 65,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF282828),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          child: Checkbox(
                                            value: task.isCompleted,
                                            activeColor: const Color(
                                              0xFF15B86C,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),

                                            onChanged: (value) async {
                                              if (value == null) return;

                                              final updatedTask = task.copyWith(
                                                isCompleted: value,
                                              );

                                              setState(() {
                                                tasks[index] = updatedTask;
                                              });

                                              await _saveTasks();
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                task.taskName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: task.isCompleted
                                                      ? const Color(0xFFA0A0A0)
                                                      : const Color(0xFFFFFCFC),
                                                  fontSize: 16,
                                                  decoration: task.isCompleted
                                                      ? TextDecoration
                                                            .lineThrough
                                                      : TextDecoration.none,
                                                  decorationColor: const Color(
                                                    0xFFA0A0A0,
                                                  ),
                                                ),
                                              ),
                                              if (task
                                                  .taskDescription
                                                  .isNotEmpty)
                                                Text(
                                                  task.taskDescription,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: task.isCompleted
                                                        ? const Color(
                                                            0xFFA0A0A0,
                                                          )
                                                        : const Color(
                                                            0xFFC6C6C6,
                                                          ),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.more_horiz),
                                          color: task.isCompleted
                                              ? const Color(0xFFA0A0A0)
                                              : const Color(0xFFC6C6C6),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
