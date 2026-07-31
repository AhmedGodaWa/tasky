import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/widgets/task_item.dart';

class TaskSliverList extends StatelessWidget {
  const TaskSliverList({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;
  final ValueChanged<TaskModel> onDelete;
  final ValueChanged<TaskModel> onEdit;

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
          onDelete: () {
            onDelete(task);
          },
          onEdit: onEdit,
        );
      }, childCount: tasks.length),
    );
  }
}
