import 'package:flutter/material.dart';
import '../models/booking.dart';
import 'booking_details_page.dart';

class CreateBookingPage extends StatefulWidget {
  final Function(Booking) onBookingCreated;
  final DateTime selectedDate;

  const CreateBookingPage({super.key, required this.onBookingCreated, required this.selectedDate});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBookingPageState createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final TextEditingController _nameController = TextEditingController();

  void _handleCreateBooking() {
    final bookingName = _nameController.text;
    if (bookingName.isNotEmpty) {
      final booking = Booking(name: bookingName, date: widget.selectedDate);
      widget.onBookingCreated(booking);

      // Navigate to booking details page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingDetailsPage(
            booking: booking,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a booking name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Booking Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleCreateBooking,
              child: const Text('Save Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
