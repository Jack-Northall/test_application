import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum CoreService { gelPolish, builderGel, gelExtension }

class Booking {
  final String id;
  final String name;
  final String details;
  final TimeOfDay time;
  final DateTime date;
  final CoreService? coreService;
  final int nailArt;
  final int nailRemoval;

  Booking({
    String? id, // Make id optional, to be used when creating fromMap
    required this.name,
    required this.details,
    required this.time,
    required this.date,
    this.coreService,
    this.nailArt = 0,
    this.nailRemoval = 0,
  }) : id = id ?? const Uuid().v4(); // Use provided id if not null

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'time': '${time.hour}:${time.minute}', // Store time as a string
      'date': date.toIso8601String(),
      'coreService': coreService?.toString(), // Convert enum to string if not null
      'nailArt': nailArt,
      'nailRemoval': nailRemoval,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'], // Pass the id from the map
      name: map['name'],
      details: map['details'],
      time: _parseTime(map['time']),
      date: DateTime.parse(map['date']),
      coreService: _parseCoreService(map['coreService']),
      nailArt: map['nailArt'],
      nailRemoval: map['nailRemoval'],
    );
  }

  // Helper method to parse TimeOfDay from a string
  static TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  // Helper method to parse CoreService from a string
  static CoreService? _parseCoreService(String? coreServiceString) {
    if (coreServiceString == null) return null;
    return CoreService.values.firstWhere(
      (e) => e.toString() == coreServiceString,
      orElse: () => CoreService.gelPolish, // Provide a default value if not found
    );
  }
}
