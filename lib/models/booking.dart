import 'package:uuid/uuid.dart';

class Booking {
  final String id;
  final String name;
  final DateTime date;

  Booking({required this.name, required this.date}) : id = const Uuid().v4();
}

