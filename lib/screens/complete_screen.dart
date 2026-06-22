import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({
    super.key,
    required this.tasks,
    required this.onChanged,
  });

  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final completedTasks = widget.tasks
        .where((task) => task.isCompleted)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Completed Tasks',
            style: TextStyle(fontSize: 22, color: Color(0xFFFFFCFC)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF15B86C)),
                  )
                : widget.tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No Tasks Completed',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  )
                : TaskList(tasks: completedTasks, onChanged: widget.onChanged),
          ),
        ),
      ],
    );
  }
}
