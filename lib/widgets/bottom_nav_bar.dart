// lib/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:test_application/schemes/colors.dart';
import '../screens/home_screen.dart';
import '../screens/calendar_page.dart';
import '../screens/blank_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          CalendarPage(),
          BlankPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(padding: EdgeInsets.only(bottom: 8.0),child: Icon(Icons.home)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding: EdgeInsets.only(bottom: 8.0),child: Icon(Icons.calendar_month)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding: EdgeInsets.only(bottom: 8.0),child: Icon(Icons.pageview)),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        iconSize: 28,
        selectedItemColor: AppColors.accentColor,
        backgroundColor: AppColors.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
