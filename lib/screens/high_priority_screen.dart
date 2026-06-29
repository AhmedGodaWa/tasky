import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({
    super.key,
    required this.tasks,
    required this.onChanged,
  });

  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;
  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  @override
  Widget build(BuildContext context) {
    final highPriorityTasks = widget.tasks
        .where((task) => task.isHighPriority)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('High Priority Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: highPriorityTasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No high-priority tasks',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    )
                  : TaskList(
                      tasks: highPriorityTasks,
                      onChanged: (task, value) {
                        widget.onChanged(task, value);

                        setState(() {});
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
