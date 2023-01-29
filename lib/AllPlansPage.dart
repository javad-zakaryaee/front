import 'package:flutter/material.dart';
import 'package:front/API.dart';
import 'package:front/LoginPage.dart';
import 'package:front/Navbar.dart';
import 'package:front/PlanPage.dart';
import 'package:front/TraineePage.dart';
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
                    return Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: ListView.builder(
                              itemCount: allPlans.length,
                              itemBuilder: (context, index) =>
                                  Text(allPlans[index].name)),
                        )
                      ],
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
