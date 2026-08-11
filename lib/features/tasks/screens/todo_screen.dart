import 'package:flutter/material.dart';
import 'package:tasky/features/tasks/models/task_model.dart';
import 'package:tasky/features/tasks/widgets/task_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
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
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final todoTasks = widget.tasks
        .where((element) => !element.isCompleted)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'ToDo Tasks',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : todoTasks.isEmpty
                ? Center(
                    child: Text(
                      'No Tasks',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : TaskList(
                    tasks: todoTasks,
                    onChanged: widget.onChanged,
                    onDelete: widget.onDelete,
                    onEdit: widget.onEdit,
                  ),
          ),
        ),
      ],
    );
  }
}
