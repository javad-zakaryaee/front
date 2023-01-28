import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:front/models/coach.dart';
import 'package:front/models/planexercise.dart';

class Plan {
  String id;
  Coach coach;
  String name;
  String text;
  List<PlanExercise> exercises;
  Plan({
    required this.id,
    required this.coach,
    required this.name,
    required this.text,
    required this.exercises,
  });
}
