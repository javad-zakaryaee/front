import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/models/coach.dart';
import 'package:front/models/trainee.dart';
import 'package:front/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ApiService {
  final basePath = 'http://localhost:3010/api/v1';
  final userPath = '/user';
  final gymPath = '/gym';
  final coachPath = '/coach';
  final traineePath = '/trainee';
  final planPath = "/plan";
  final exercisePath = "/exercise";

  Future<Response> Login(String email, String password) async {
    final result = await http.post(Uri.parse('$basePath$userPath/login'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));
    if (result.statusCode == 200)
      return result;
    else
      return Future.value(null);
  }

  Future<Response> signUp(User user) async {
    final result = await http.post(Uri.parse('$basePath$userPath/create'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          'email': user.email,
          'password': user.password,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'role': user.role,
          'birthdate': DateFormat('yyyy-MM-dd').format(user.birthdate)
        }));

    return result;
  }

  Future<Response> getAllGyms() async {
    final result = await http.get(
      Uri.parse('$basePath$gymPath/get'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    if (result.statusCode == 200)
      return result;
    else
      return Future.value(null);
  }

  Future<Response> signUpCoach(Coach coach) async {
    final result = await http.post(Uri.parse('$basePath$coachPath/create'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, String>{
          'email': coach.user.email,
          'gym': coach.gym!.id,
        }));
    return result;
  }

  Future<Response> signUpTrainee(Trainee trainee) async {
    final result = await http.post(Uri.parse('$basePath$traineePath/create'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          'email': trainee.user.email,
          'height': trainee.height,
          'weight': trainee.weight,
          'goal': trainee.goal
        }));
    return result;
  }

  Future<Response> getUser(String token, String id) async {
    final result = await http.get(
      Uri.parse('$basePath$userPath/get/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      },
    );
    return result;
  }

  Future<Response> getTrainee(String token, String id) async {
    final result = await http.get(
      Uri.parse('$basePath$traineePath/get/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      },
    );
    return result;
  }

  Future<Response> getCoach(String id) async {
    final result = await http.get(
      Uri.parse('$basePath$coachPath/get/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    return result;
  }

  Future<Response> getPlan(String id) async {
    final result = await http.get(
      Uri.parse('$basePath$planPath/get/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    return result;
  }

  Future<Response> getExercise(String id) async {
    final result = await http.get(
      Uri.parse('$basePath$exercisePath/get/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    return result;
  }

  Future<Response> getAllPlans() async {
    final result = await http.get(
      Uri.parse('$basePath$planPath/get'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    return result;
  }

  Future<Response> updateTrainee(String id, String token, String planId) async {
    print(id);
    print(planId);
    print(token);
    final result = await http.put(
      Uri.parse('$basePath$traineePath/update/$id'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      },
      body: json.encode(<String, dynamic>{'plan': planId}),
    );
    return result;
  }
}
