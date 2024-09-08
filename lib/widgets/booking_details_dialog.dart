import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../schemes/colors.dart';
import '../schemes/time_formatter.dart';

class BookingDetailsDialog extends StatelessWidget {
  final Booking booking;

  const BookingDetailsDialog({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Booking Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Name: ${booking.name}', style: const TextStyle(color: AppColors.textColor)),
          Text('Date: ${booking.date.toLocal().toString().split(' ')[0]}', style: const TextStyle(color: AppColors.textColor)),
          Text('Time: ${TimeFormatter.formatTimeOfDay(booking.time)}', style: const TextStyle(color: AppColors.textColor)),
          Text('Details: ${booking.details}', style: const TextStyle(color: AppColors.textColor)),
          if (booking.coreService != null)
            Text('Service: ${booking.coreService!.toString().split('.').last}', style: const TextStyle(color: AppColors.textColor)),
          Text('Nail Art: £${booking.nailArt}', style: const TextStyle(color: AppColors.textColor)),
          Text('Nail Removal: £${booking.nailRemoval}', style: const TextStyle(color: AppColors.textColor)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close', style: TextStyle(color: AppColors.textColor)),
        ),
      ],
    );
  }
}
