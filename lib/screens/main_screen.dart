import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const TodoScreen(),
    const CompleteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

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
