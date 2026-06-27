import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

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
            activeColor: const Color(0xFF15B86C),
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: onChanged,
          ),
          //const SizedBox(width: 6),
          Expanded(
            child: Text(
              task.taskName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: task.isCompleted
                    ? const Color(0xFFA0A0A0)
                    : const Color(0xFFFFFCFC),
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: const Color(0xFFA0A0A0),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   constraints: const BoxConstraints(),
          //   padding: EdgeInsets.zero,
          //   iconSize: 18,
          //   icon: const Icon(Icons.more_horiz),
          //   color: task.isCompleted
          //       ? const Color(0xFFA0A0A0)
          //       : const Color(0xFFC6C6C6),
          // ),
        ],
      ),
    );
  }
}
