import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/high_priority_screen.dart';
import 'package:tasky/widgets/high_priority_task_item.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onChanged,
  });

  final List<TaskModel> tasks;
  final void Function(TaskModel, bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    final highPriorityTasks = tasks
        .where((task) => task.isHighPriority)
        .take(4)
        .toList();
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'High Priority Tasks',
                    style: TextStyle(fontSize: 14, color: Color(0xFF15B86C)),
                  ),
                ),
                const SizedBox(height: 8),

                if (highPriorityTasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'No high-priority tasks',
                      style: TextStyle(fontSize: 14, color: Color(0xFFA0A0A0)),
                    ),
                  )
                else
                  ...highPriorityTasks.map(
                    (task) => HighPriorityTaskItem(
                      task: task,
                      onChanged: (value) => onChanged(task, value),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HighPriorityScreen(tasks: tasks, onChanged: onChanged),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF282828),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6E6E6E)),
                ),
                child: SvgPicture.asset('assets/images/arrow_up_right.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
