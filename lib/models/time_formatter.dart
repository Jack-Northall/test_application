// time_formatter.dart
import 'package:flutter/material.dart';

class TimeFormatter {
  // Formats TimeOfDay to "HH:MM" format
  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hours = timeOfDay.hour.toString().padLeft(2, '0');
    final minutes = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
