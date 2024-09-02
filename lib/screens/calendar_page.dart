// lib/screens/calendar_page.dart
import 'package:flutter/material.dart';
import '/Widgets/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: const CalendarWidget(), // Use the custom CalendarWidget
    );
  }
}
