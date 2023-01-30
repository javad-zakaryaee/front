import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/API.dart';
import 'package:front/pages/CoachPage.dart';
import 'package:front/Navbar.dart';
import 'package:front/models/exercise.dart';
import 'package:front/models/plan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'TraineePage.dart';

class PlanPage extends StatefulWidget {
  String planId;
  String userId;
  PlanPage({Key? key, required this.planId, required this.userId})
      : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();
}

SharedPreferences? prefs;
Plan? plan;

class _PlanPageState extends State<PlanPage> {
  final basePath = 'localhost:8081/api/v1';
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SharedPreferences.getInstance()
        .then((value) => setState(() => prefs = value));
  }

  Future<void> getPlan() async {
    http.Response response = await ApiService().getPlan(widget.planId);
    Map<String, dynamic> planMap = json.decode(utf8.decode(response.bodyBytes));
    plan = Plan(
        id: planMap['id'],
        name: planMap['name'],
        text: planMap['text'],
        exercises: planMap['exercises']);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
          future: getPlan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            else
              return Body(width: width, height: height);
          }),
    );
  }
}

class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  int i = -1;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Navbar(
        isLoggedIn: false,
      ),
      Expanded(
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromARGB(255, 56, 71, 151),
                    Color(0xFF277AF6)
                  ])),
              child: Center(
                  child: Card(
                elevation: 100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Container(
                  width: width * 0.25,
                  height: height * 0.45,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        plan!.name,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        plan!.text,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ))))
    ]);
  }
}
