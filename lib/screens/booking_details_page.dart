import 'package:flutter/material.dart';
import 'package:test_application/widgets/service_selection_widget.dart';
import '../models/booking.dart';

class BookingDetailsPage extends StatefulWidget {
  final Booking booking;

  const BookingDetailsPage({super.key, required this.booking});

  @override
  // ignore: library_private_types_in_public_api
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  CoreService? _selectedService;
  int _nailArt = 0;
  int _nailRemoval = 0;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _selectedService = widget.booking.coreService;
    _nailArt = widget.booking.nailArt;
    _nailRemoval = widget.booking.nailRemoval;
  }

  void _saveDetails() {
    setState(() {
      widget.booking.coreService = _selectedService;
      widget.booking.nailArt = _nailArt;
      widget.booking.nailRemoval = _nailRemoval;
    });

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
