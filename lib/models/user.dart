import 'dart:convert';
import 'dart:core';

class User {
  String? id;
  String firstName;
  String lastName;
  String email;
  String password;
  String role;
  DateTime birthdate;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthdate,
    required this.password,
    required this.role,
  });
  factory User.fromJson(Map userData) {
    return User(
        id: userData['id'],
        firstName: userData['firstName'],
        lastName: userData['lastName'],
        email: userData['email'],
        password: userData['password'],
        birthdate: DateTime.parse(userData['birthdate']),
        role: userData['role']);
  }
}
