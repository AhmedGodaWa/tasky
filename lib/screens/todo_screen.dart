import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.tasks, required this.onChanged});
  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;

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
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'ToDo Tasks',
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
                      'No Tasks',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  )
                : TaskList(tasks: todoTasks, onChanged: widget.onChanged),
          ),
        ),
      ],
    );
  }
}
