import 'package:flutter/material.dart';
import '../models/booking.dart';

class BookingDetailsPage extends StatefulWidget {
  final Booking booking;

  const BookingDetailsPage({super.key, required this.booking});

  @override
  // ignore: library_private_types_in_public_api
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  void _saveDetails() {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Details saved for ${widget.booking.name}')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking Name: ${widget.booking.name}'),
            const SizedBox(height: 20),
            TextField(
              controller: _revenueController,
              decoration: const InputDecoration(
                labelText: 'Revenue',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _costController,
              decoration: const InputDecoration(
                labelText: 'Cost',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveDetails,
              child: const Text('Save Details'),
            ),
          ],
        ),
      ),
    );
  }
}
