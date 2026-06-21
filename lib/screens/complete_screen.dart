import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key, required this.tasks});

    final List<TaskModel> tasks;


  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Complete Screen'));
  }
}