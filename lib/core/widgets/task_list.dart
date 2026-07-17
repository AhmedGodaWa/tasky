import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks, required this.onChanged});

  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 55),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskItem(
          task: task,
          onChanged: (value) {
            onChanged(task, value);
          },
        );
      },
    );
  }
}
