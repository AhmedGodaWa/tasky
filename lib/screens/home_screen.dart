import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task_screen.dart';
import 'package:tasky/core/widgets/achieved_tasks_card.dart';
import 'package:tasky/core/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/core/widgets/task_sliver_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onTaskAdded,
    required this.onDelete,
    required this.onEdit,
  });
  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;
  final Future<void> Function() onTaskAdded;
  final ValueChanged<TaskModel> onDelete;
  final ValueChanged<TaskModel> onEdit;

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
    final savedName = PreferencesManager().getUserName();

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
          icon: const Icon(Icons.add),
          label: const Text('Add New Task'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Yuhuu ,Your work Is almost done !',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    AchievedTasksCard(
                      completedTasks: completedTasks,
                      totalTasks: totalTasks,
                      progress: progress,
                      percentage: percentage,
                    ),
                    const SizedBox(height: 8),
                    HighPriorityTasksWidget(
                      tasks: widget.tasks,
                      onChanged: widget.onChanged,
                      onDelete: widget.onDelete,
                      onEdit: widget.onEdit,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              if (isLoading)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (widget.tasks.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'No Data',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                )
              else
                TaskSliverList(
                  tasks: widget.tasks,
                  onChanged: widget.onChanged,
                  onDelete: widget.onDelete,
                  onEdit: widget.onEdit,
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 60)),
            ],
          ),
        ),
      ),
    );
  }
}
