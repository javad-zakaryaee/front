import 'dart:convert';
import 'dart:core';

import 'package:collection/collection.dart';

import 'package:front/models/gym.dart';
import 'package:front/models/plan.dart';
import 'package:front/models/trainee.dart';
import 'package:front/models/user.dart';

class Coach {
  String? id;
  Gym? gym;
  User user;
  List<Plan>? plans;
  List<Trainee>? trainees;
  Coach({
    this.id,
    this.gym,
    required this.user,
    this.plans,
    this.trainees,
  });
}
