import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/API.dart';
import 'package:front/models/exercise.dart';
import 'package:front/pages/LoginPage.dart';
import 'package:front/Navbar.dart';
import 'package:front/pages/PlanPage.dart';
import 'package:front/pages/TraineePage.dart';
import 'package:front/models/plan.dart';
import 'package:front/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AllPlansPage extends StatefulWidget {
  User? user;
  AllPlansPage({Key? key, this.user}) : super(key: key);

  @override
  _AllPlansPageState createState() => _AllPlansPageState();
}

List<Plan> allPlans = [];
SharedPreferences? prefs;

class _AllPlansPageState extends State<AllPlansPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SharedPreferences.getInstance()
        .then((value) => setState(() => prefs = value));
  }

  Future<List<Plan>> getAllPlans() async {
    var response = await ApiService().getAllPlans();
    var allPlansJson = json.decode(utf8.decode(response.bodyBytes));

    allPlansJson.forEach((e) {
      Plan newPlan = Plan(id: e['id'], name: e['name'], text: e['text']);
      allPlans.add(newPlan);
    });

    return allPlans;
  }

  Future<List<Exercise>> loadExercises() async {
    List<Exercise> exercises = [];
    plan!.exercises!.forEach((element) async {
      var response =
          await ApiService().getExercise(element['id']['exerciseId']);
      var jsonDecode = json.decode(utf8.decode(response.bodyBytes));
      Exercise newEx = Exercise(
          id: jsonDecode['id'],
          name: jsonDecode['name'],
          description: jsonDecode['description']);
      exercises.add(newEx);
    });
    return exercises;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Navbar(
            isLoggedIn: true,
            username: widget.user!.firstName + ' ' + widget.user!.lastName,
            prefs: prefs,
          ),
          Card(
            elevation: 25,
            child: Container(
              width: width * 0.9,
              height: height * 0.8,
              child: FutureBuilder(
                future: getAllPlans(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...allPlans
                              .map((e) => GestureDetector(
                                    onTap: (() async {
                                      var response = await ApiService()
                                          .updateTrainee(trainee!.id!,
                                              prefs!.getString("token")!, e.id);
                                      print(response.statusCode);
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: ((context, animation,
                                                      secondaryAnimation) =>
                                                  TraineePage(
                                                    prefs: prefs!,
                                                    user: user,
                                                  ))));
                                    }),
                                    child: Card(
                                      elevation: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: ExpansionTile(
                                          title: Text(
                                            e.name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          subtitle: Text(
                                            e.text,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          children: [
                                            FutureBuilder(
                                              future: loadExercises(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting)
                                                  return CircularProgressIndicator();
                                                else {
                                                  return Column(
                                                    children: [
                                                      ...snapshot.data!.map(
                                                        (e) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                                color:
                                                                    Colors.blue,
                                                                child: Row(
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        Text(e
                                                                            .name),
                                                                        Text(e
                                                                            .description)
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )),
                                                          );
                                                        },
                                                      ).toList()
                                                    ],
                                                  );
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
