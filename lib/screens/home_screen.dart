import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task_screen.dart';
import 'package:tasky/widgets/achieved_tasks_card.dart';
import 'package:tasky/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onTaskAdded,
  });
  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;
  final Future<void> Function() onTaskAdded;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
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

  @override
  Widget build(BuildContext context) {
    final totalTasks = widget.tasks.length;
    final completedTasks = widget.tasks
        .where((task) => task.isCompleted)
        .length;
    final progress = totalTasks == 0 ? 0.0 : completedTasks / totalTasks;
    final percentage = (progress * 100).toInt();

    return Scaffold(
      floatingActionButton: SizedBox(
        height: 45,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTaskScreen()),
            );
            if (result == true) {
              await widget.onTaskAdded();
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

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 8),
                child: AchievedTasksCard(
                  completedTasks: completedTasks,
                  totalTasks: totalTasks,
                  progress: progress,
                  percentage: percentage,
                ),
              ),

              HighPriorityTasksWidget(
                tasks: widget.tasks,
                onChanged: widget.onChanged,
              ),

              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Tasks',
                      style: TextStyle(fontSize: 20, color: Color(0xFFFFFCFC)),
                    ),

                    const SizedBox(height: 10),
                    Expanded(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF15B86C),
                              ),
                            )
                          : widget.tasks.isEmpty
                          ? const Center(
                              child: Text(
                                'No Data',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : TaskList(
                              tasks: widget.tasks,
                              onChanged: widget.onChanged,
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
