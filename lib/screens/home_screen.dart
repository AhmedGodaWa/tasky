import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});

  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final pref = await SharedPreferences.getInstance();

    final taskJson = pref.getString('tasks');

    if (taskJson != null) {
      final List<dynamic> decodedTasks = jsonDecode(taskJson);

      final loadedTasks = decodedTasks
          .map<TaskModel>((taskMap) => TaskModel.fromJson(taskMap))
          .toList();

      setState(() {
        tasks = loadedTasks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      floatingActionButton: SizedBox(
        height: 45,
        //width: 167,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTask()),
            );
          },
          backgroundColor: const Color(0xFF15B86C),
          foregroundColor: const Color(0xFFFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Add New Task'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/person.png',
                    height: 42,
                    width: 42,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening, ${widget.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                      const Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                'Yuhuu ,Your work Is almost done !',
                style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 32),
              ),

              const SizedBox(height: 16),
             
            ],
          ),
        ),
      ),
    );
  }
}
