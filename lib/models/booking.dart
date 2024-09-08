import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum CoreService { gelPolish, builderGel, gelExtension }

class Booking {
  final String id;
  final String name;
  final String details;
  final TimeOfDay time;
  final DateTime date;
  CoreService? coreService;
  int nailArt;
  int nailRemoval;

  Booking({
    required this.name,
    required this.details,
    required this.time,
    required this.date,
    this.coreService,
    this.nailArt = 0,
    this.nailRemoval = 0,
  }) : id = const Uuid().v4();
}