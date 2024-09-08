// lib/screens/calendar_page.dart
import 'package:flutter/material.dart';
import 'package:test_application/schemes/colors.dart';
import 'package:test_application/widgets/calendar_widget.dart';
import 'package:test_application/widgets/booking_details_dialog.dart';  // Import the new dialog widget
import 'package:test_application/screens/create_booking_page.dart';
import '../models/booking.dart';
import '../models/time_formatter.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Booking>> _bookings = {};

  void _addBooking(Booking booking) {
    final dateKey = _dateOnly(booking.date);
    setState(() {
      if (_bookings.containsKey(dateKey)) {
        _bookings[dateKey]!.add(booking);
      } else {
        _bookings[dateKey] = [booking];
      }
    });
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void _navigateToCreateBookingPage() {
    if (_selectedDay == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateBookingPage(
          onBookingCreated: (booking) {
            _addBooking(booking);
            Navigator.pop(context);
          },
          selectedDate: _selectedDay!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: Column(
        children: [
          CalendarWidget(
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
          ),
          ElevatedButton(
            onPressed: _navigateToCreateBookingPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: AppColors.textColor,
            ),
            child: const Text('Add Booking'),
          ),
          Expanded(child: _buildBookingList()),
        ],
      ),
    );
  }

  Widget _buildBookingList() {
    if (_selectedDay == null) {
      return const Center(child: Text('Select a date to see bookings.'));
    }

    final dateKey = _dateOnly(_selectedDay!);
    if (!_bookings.containsKey(dateKey) || _bookings[dateKey]!.isEmpty) {
      return const Center(child: Text('No bookings for the selected date.'));
    }

    return ListView.builder(
      itemCount: _bookings[dateKey]!.length,
      itemBuilder: (context, index) {
        final booking = _bookings[dateKey]![index];
        final timeString = TimeFormatter.formatTimeOfDay(booking.time);

        return Card(
          child: ListTile(
            leading: const Icon(Icons.calendar_month, color: AppColors.textColor),
            title: Text(booking.name, style: const TextStyle(color: AppColors.textColor)),
            subtitle: Text(timeString, style: const TextStyle(color: AppColors.textColor)),
            isThreeLine: false,
            tileColor: AppColors.primaryColor,
            trailing: ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BookingDetailsDialog(booking: booking);
                },
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.textColor, backgroundColor: AppColors.secondaryColor,
              ),
              child: const Text('View'),
            ),
          ),
        );
      },
    );
  }
}
