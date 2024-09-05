import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_application/schemes/colors.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime, DateTime) onDaySelected;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  const CalendarWidget({
    Key? key,
    required this.onDaySelected,
    required this.focusedDay,
    required this.selectedDay,
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2050, 1, 1),
      focusedDay: widget.focusedDay,
      calendarFormat: _calendarFormat,
      calendarStyle: const CalendarStyle(
        //Selected BoxStyling
        selectedDecoration: BoxDecoration(
          color: AppColors.secondaryColor,
          shape: BoxShape.circle,
        ),
        //Selected TextStyling
        selectedTextStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(widget.selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(selectedDay, focusedDay);
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {},
    );
  }
}
