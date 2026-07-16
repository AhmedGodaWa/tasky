import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, required this.onChanged});

  final TaskModel task;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        alignment: Alignment.center,
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Checkbox(value: task.isCompleted, onChanged: onChanged),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: task.isCompleted
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).disabledColor,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Theme.of(context).disabledColor,
                          )
                        : Theme.of(context).textTheme.bodyLarge,
                    // style: TextStyle(
                    //   color: task.isCompleted
                    //       ? const Color(0xFFA0A0A0)
                    //       : const Color(0xFFFFFCFC),
                    //   fontSize: 16,
                    //   decoration: task.isCompleted
                    //       ? TextDecoration.lineThrough
                    //       : TextDecoration.none,
                    //   decorationColor: const Color(0xFFA0A0A0),
                    // ),
                  ),
                  if (task.taskDescription.isNotEmpty)
                    Text(
                      task.taskDescription,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              color: task.isCompleted
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ],
        ),
      ),
    );
  }
}
