import 'package:flutter/material.dart';
import '../widgets/service_selection_widget.dart';
import '../models/booking.dart';

class BookingDetailsPage extends StatefulWidget {
  final Booking booking;
  final void Function(Booking updatedBooking) onBookingUpdated;

  const BookingDetailsPage({
    super.key,
    required this.booking,
    required this.onBookingUpdated,
  });

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  CoreService? _selectedService;
  int _nailArt = 0;
  int _nailRemoval = 0;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    // Initialize state with booking details
    _selectedService = widget.booking.coreService;
    _nailArt = widget.booking.nailArt;
    _nailRemoval = widget.booking.nailRemoval;
  }

  void _saveDetails() {
    // Create a new Booking object with updated details
    final updatedBooking = Booking(
      id: widget.booking.id, // Preserve the original ID
      name: widget.booking.name,
      details: widget.booking.details,
      time: widget.booking.time,
      date: widget.booking.date,
      coreService: _selectedService,
      nailArt: _nailArt,
      nailRemoval: _nailRemoval,
    );

    // Call the callback function to update the booking
    widget.onBookingUpdated(updatedBooking);

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Details saved for ${updatedBooking.name}')),
    );

    // Navigate back to the previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 1) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            _saveDetails();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text('Service Selection'),
            content: ServiceSelectionWidget(
              selectedService: _selectedService,
              nailArt: _nailArt,
              nailRemoval: _nailRemoval,
              onServiceSelected: (service) {
                setState(() {
                  _selectedService = service;
                });
              },
              onNailArtChanged: (value) {
                setState(() {
                  _nailArt = value;
                });
              },
              onNailRemovalChanged: (value) {
                setState(() {
                  _nailRemoval = value;
                });
              },
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Review & Save'),
            content: const Text('Review the details and click "Save Details" to confirm.'),
            isActive: _currentStep >= 1,
            state: _currentStep == 1 ? StepState.editing : StepState.indexed,
          ),
        ],
      ),
    );
  }
}
