import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../schemes/colors.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime, DateTime) onDaySelected;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  const CalendarWidget({
    super.key,
    required this.onDaySelected,
    required this.focusedDay,
    required this.selectedDay,
  });

  @override
  // ignore: library_private_types_in_public_api
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
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: AppColors.textColor,        
        ),
        weekendStyle: TextStyle(
          color: AppColors.textColor,
        ),
      ),
      calendarStyle: const CalendarStyle(
        //Selected BoxStyling
        selectedDecoration: BoxDecoration(
          color: AppColors.accentColor,
          shape: BoxShape.circle,
        ),
        //Selected TextStyling
        selectedTextStyle: TextStyle(
          color: Colors.black,
        ),
        //Today BoxStyling
        todayDecoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        //Today TextStyling
        todayTextStyle: TextStyle(
          color: AppColors.textColor,
        ),
        //Weekend TextStyling
        weekendTextStyle: TextStyle(
          color: AppColors.textColor,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        leftChevronIcon: Icon(Icons.chevron_left_rounded, color: AppColors.textColor),
        rightChevronIcon: Icon(Icons.chevron_right_rounded, color: AppColors.textColor),
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
