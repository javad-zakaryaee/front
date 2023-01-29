import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:front/models/coach.dart';

class Plan {
  String id;
  Coach? coach;
  String name;
  String text;
  List<Map<String, dynamic>>? exercises;
  Plan({
    required this.id,
    this.coach,
    required this.name,
    required this.text,
    this.exercises,
  });
}
