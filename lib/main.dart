import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
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
          foregroundColor: AppColors.textColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: AppColors.textColor,
          ),
        ),
      ),
      home: const BottomNavBar(),
    );
  }
}
