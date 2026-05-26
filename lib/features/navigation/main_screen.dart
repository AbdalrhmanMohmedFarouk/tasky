import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/tasks/complete_tasks_screen.dart';
import 'package:tasky/features/home/home_screen.dart';
import 'package:tasky/features/profile/profile_screen.dart';
import 'package:tasky/features/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _screen = [
    HomeScreen(),
    TasksScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/icons/home.svg',0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/icons/To Do.svg' , 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/icons/Icon.svg',2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/icons/ProfileICon.svg',3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _screen[_currentIndex]),
    );
  }

  SvgPicture _buildSvgPicture(String path , int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0XFF15B86C) : Color(0XFFC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
