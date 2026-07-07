import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/complete_screen.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    final taskJson = PreferencesManager().getTasks();

    if (taskJson != null) {
      final List<dynamic> decodedTasks = jsonDecode(taskJson);

      final loadedTasks = decodedTasks
          .map<TaskModel>((taskMap) => TaskModel.fromJson(taskMap))
          .toList();

      tasks = loadedTasks;
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveTasks() async {
    final taskJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await PreferencesManager().saveTasks(taskJson);
  }

  void _onTaskChanged(TaskModel task, bool? value) {
    if (value == null) return;

    final index = tasks.indexWhere((t) => t.id == task.id);

    final updatedTask = tasks[index].copyWith(isCompleted: value);

    setState(() {
      tasks[index] = updatedTask;
    });

    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        tasks: tasks,
        onChanged: _onTaskChanged,
        onTaskAdded: _loadTasks,
      ),
      TodoScreen(tasks: tasks, onChanged: _onTaskChanged),
      CompleteScreen(tasks: tasks, onChanged: _onTaskChanged),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: screens[selectedIndex]),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF181818),
        selectedItemColor: const Color(0xFF15B86C),
        unselectedItemColor: const Color(0xFFFFFCFC),
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home_Icon.svg',
              colorFilter: ColorFilter.mode(
                selectedIndex == 0
                    ? const Color(0xFF15B86C)
                    : const Color(0xFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo_Icon.svg',
              colorFilter: ColorFilter.mode(
                selectedIndex == 1
                    ? const Color(0xFF15B86C)
                    : const Color(0xFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/completed_Icon.svg',
              colorFilter: ColorFilter.mode(
                selectedIndex == 2
                    ? const Color(0xFF15B86C)
                    : const Color(0xFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile_icon.svg',
              colorFilter: ColorFilter.mode(
                selectedIndex == 3
                    ? const Color(0xFF15B86C)
                    : const Color(0xFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
