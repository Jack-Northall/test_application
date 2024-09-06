import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'Screens/blank_page.dart';
import 'Screens/calendar_page.dart';
import '../schemes/colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Home Screen',
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
      home: const HomeScreen(),
      routes: {
        '/blankPage': (context) => const BlankPage(),
        '/calendarPage': (context) => const CalendarPage(),
      },
    );
  }
}
