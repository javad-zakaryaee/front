import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:front/models/coach.dart';
import 'package:front/models/user.dart';
import 'dart:core';

class Gym {
  String id;
  User? owner;
  String name;
  double rating;
  String address;
  String? plusCode;
  double pricePerSession;
  double pricePerMonth;
  List<Coach>? coaches;
  Gym({
    required this.id,
    this.owner,
    required this.name,
    required this.rating,
    required this.address,
    this.plusCode,
    required this.pricePerSession,
    required this.pricePerMonth,
    this.coaches,
  });
  factory Gym.fromJson(Map gymData) {
    return Gym(
        id: gymData['id'],
        name: gymData['name'],
        rating: gymData['starRating'],
        address: gymData['address'],
        plusCode: gymData['plusCode'],
        pricePerMonth: gymData['pricePerMonth'],
        pricePerSession: gymData['pricePerSession']);
  }
}
