import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';
import 'screens/blank_page.dart';
import 'screens/calendar_page.dart';
import 'screens/home_screen.dart';
import '../schemes/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Example',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0XFFFFFFFF),
          ),
        ),
      ),
      home: const BottomNavBar(), // Set BottomNavBar as the home
    );
  }
}
