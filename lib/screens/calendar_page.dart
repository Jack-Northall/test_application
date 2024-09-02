import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_application/screens/create_booking_page.dart';
import '../models/booking.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Booking>> _bookings = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _addBooking(Booking booking) {
    final dateKey = _dateOnly(booking.date);
    //print('Adding booking for date: $dateKey'); // Debugging
    setState(() {
      if (_bookings.containsKey(dateKey)) {
        _bookings[dateKey]!.add(booking);
      } else {
        _bookings[dateKey] = [booking];
      }
      //print('Current bookings for $dateKey: ${_bookings[dateKey]}'); // Debugging
    });
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

 void _navigateToCreateBookingPage() {
  if (_selectedDay == null) {
    return;
  }
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
        title: const Text('Calendar Page'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          ElevatedButton(
            onPressed: _navigateToCreateBookingPage,
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
    //print('Selected Day: $_selectedDay');  // Debugging
    //print('Date Key: $dateKey');  // Debugging
    //print('Bookings for Date Key: ${_bookings[dateKey]}');  // Debugging

    if (!_bookings.containsKey(dateKey) || _bookings[dateKey]!.isEmpty) {
      return const Center(child: Text('No bookings for the selected date.'));
    }

    return ListView.builder(
      itemCount: _bookings[dateKey]!.length,
      itemBuilder: (context, index) {
        final booking = _bookings[dateKey]![index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text(booking.name),
            subtitle: 
              Text('Booking ID: ${booking.id}'),
            isThreeLine: false,
          ),
        );
      },
    );
  }
}
