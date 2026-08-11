import 'package:flutter/material.dart';
import 'package:tasky/core/enums/menu_action.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/core/widgets/primary_button.dart';
import 'package:tasky/features/tasks/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;
  final ValueChanged<TaskModel> onEdit;

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
            PopupMenuButton<MenuAction>(
              onSelected: (value) {
                switch (value) {
                  case MenuAction.toggleCompleted:
                    onChanged(!task.isCompleted);
                    break;

                  case MenuAction.edit:
                    _showEditBottomSheet(context, task);
                    break;

                  case MenuAction.delete:
                    _showDeleteDialog(context);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: MenuAction.toggleCompleted,
                  child: Text(task.isCompleted ? 'Undone' : 'Done'),
                ),
                const PopupMenuItem(
                  value: MenuAction.edit,
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: MenuAction.delete,
                  child: Text('Delete'),
                ),
              ],
              // itemBuilder: (context) =>
              // MenuAction.values.map((e) {
              //   return PopupMenuItem(
              //     value: e,
              //     child: Text(e.name),
              //   );
              // }).toList(),
              icon: Icon(
                Icons.more_vert_outlined,
                color: task.isCompleted
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditBottomSheet(context, TaskModel task) async {
    final taskNameController = TextEditingController(text: task.taskName);
    final taskDescriptionController = TextEditingController(
      text: task.taskDescription,
    );

    bool isHighPriority = task.isHighPriority;

    await showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit Task',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const SizedBox(height: 24),

                      CustomTextFormField(
                        controller: taskNameController,
                        title: 'Task Name',
                        hintText: 'Finish UI design for login screen',
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: taskDescriptionController,
                        maxLines: 3,
                        title: 'Task Description',
                        hintText:
                            'Finish onboarding UI and hand off to devs by Thursday.',
                        textInputAction: TextInputAction.done,
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'High Priority',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Switch(
                            value: isHighPriority,
                            onChanged: (value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      PrimaryButton(
                        text: 'Save Changes',
                        onPressed: () {
                          final updatedTask = task.copyWith(
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                          );

                          Navigator.pop(context);

                          onEdit(updatedTask);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
