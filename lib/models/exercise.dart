import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:front/models/planexercise.dart';

class Exercise {
  String id;
  String name;
  String description;
  String picUrl;
  List<PlanExercise> plans;
  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.picUrl,
    required this.plans,
  });
}
