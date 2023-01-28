import 'dart:convert';
import 'dart:core';

import 'package:front/models/coach.dart';
import 'package:front/models/plan.dart';
import 'package:front/models/user.dart';

class Trainee {
  String? id;
  User user;
  Coach? coach;
  Plan? plan;
  int height;
  double weight;
  String goal;
  Trainee({
    this.id,
    required this.user,
    this.coach,
    this.plan,
    required this.height,
    required this.weight,
    required this.goal,
  });
}
