import 'package:flutter/foundation.dart';

class Entry {
  final String id;
  final String mood;
  final String description;
  final String imagePath;
  final DateTime date;

  Entry({
    required this.id,
    required this.mood,
    required this.description,
    required this.imagePath,
    required this.date,
  });
}