import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item.dart';

class TaskSliverList extends StatelessWidget {
  const TaskSliverList({
    super.key,
    required this.tasks,
    required this.onChanged,
  });

  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final task = tasks[index];

        return TaskItem(
          task: task,
          onChanged: (value) {
            onChanged(task, value);
          },
        );
      }, childCount: tasks.length),
    );
  }
}
