import 'dart:convert';

import 'package:collection/collection.dart';

class Exercise {
  String id;
  String name;
  String description;
  String? picUrl;
  Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.picUrl,
  });
}
