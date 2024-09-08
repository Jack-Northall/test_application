import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../schemes/colors.dart';
import 'booking_details_page.dart';

class CreateBookingPage extends StatefulWidget {
  final Function(Booking) onBookingCreated;
  final DateTime selectedDate;

  const CreateBookingPage({
    super.key,
    required this.onBookingCreated,
    required this.selectedDate,
  });

  @override
  _CreateBookingPageState createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();

  // Handle booking creation
  void _handleCreateBooking() {
    final bookingName = _nameController.text;
    final bookingDetails = _detailsController.text;
    final int? hour = int.tryParse(_hourController.text);
    final int? minute = int.tryParse(_minuteController.text);

    if (bookingName.isNotEmpty && hour != null && minute != null) {
      final bookingTime = TimeOfDay(hour: hour, minute: minute);
      final booking = Booking(
        name: bookingName,
        details: bookingDetails,
        time: bookingTime,
        date: widget.selectedDate,
      );
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
        const SnackBar(content: Text('Please enter valid booking details and time')),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name text field
              TextField(
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Booking Name',
                  labelStyle: TextStyle(color: AppColors.textColor),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Details text field (Multiline for entering address or details)
              TextField(
                controller: _detailsController,
                maxLength: 300, // Adjust this if needed for longer input
                maxLines: 4, // Allows for 4 lines of text
                decoration: const InputDecoration(
                  labelText: 'Booking Details (e.g., Address)',
                  labelStyle: TextStyle(color: AppColors.textColor),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Custom time input (HH:MM) with larger text fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hour Text Field
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _hourController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: const InputDecoration(
                        labelText: 'HH',
                        labelStyle: TextStyle(color: AppColors.textColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        counterText: '', // Hide the 0/2 counter
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(':', style: TextStyle(fontSize: 30)),
                  const SizedBox(width: 10),
                  // Minute Text Field
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _minuteController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: const InputDecoration(
                        labelText: 'MM',
                        labelStyle: TextStyle(color: AppColors.textColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        counterText: '', // Hide the 0/2 counter
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Save Booking button
              ElevatedButton(
                onPressed: _handleCreateBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.textColor,
                ),
                child: const Text('Save Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
