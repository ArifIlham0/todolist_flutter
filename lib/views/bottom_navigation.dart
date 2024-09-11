import 'package:flutter/material.dart';
import 'package:todolist_get/theme.dart';
import 'package:todolist_get/views/export.dart';
import 'package:todolist_get/components/export.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const TodoListScreen(),
    const CompletedScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kGrey,
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex != 0
                  ? const Icon(Icons.task_outlined)
                  : const Icon(Icons.task_rounded),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex != 1
                  ? const Icon(Icons.check_circle_outlined)
                  : const Icon(Icons.check_circle),
              label: 'Completed',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex != 2
                  ? const Icon(Icons.person_pin_outlined)
                  : const Icon(Icons.person_pin_rounded),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: kWhite,
          iconSize: 30.w,
        ),
      ),
    );
  }
}
