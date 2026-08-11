import 'package:flutter/material.dart';
import 'package:tasky/features/tasks/models/task_model.dart';

class HighPriorityTaskItem extends StatelessWidget {
  const HighPriorityTaskItem({
    super.key,
    required this.task,
    required this.onChanged,
  });

  final TaskModel task;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Checkbox(
            value: task.isCompleted,
            visualDensity: VisualDensity.compact,
            onChanged: onChanged,
          ),
          Expanded(
            child: Text(
              task.taskName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: task.isCompleted
                  ? Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).disabledColor,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Theme.of(context).disabledColor,
                    )
                  : Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
