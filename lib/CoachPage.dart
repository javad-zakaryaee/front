import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/API.dart';
import 'package:front/Navbar.dart';
import 'package:front/models/coach.dart';
import 'package:front/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class CoachPage extends StatefulWidget {
  User? user;
  SharedPreferences prefs;
  CoachPage({Key? key, this.user, required this.prefs}) : super(key: key);

  @override
  _CoachPageState createState() => _CoachPageState();
}

User? user;
Coach? coach;

class _CoachPageState extends State<CoachPage> {
  Future<void> loadUserAndCoach() async {
    Response coachResponse =
        await ApiService().getCoach(widget.prefs.getString("id") ?? "");
    Map<String, dynamic> mapResponse =
        (json.decode(utf8.decode(coachResponse.bodyBytes)));
    user = User.fromJson(mapResponse['user']);
    coach = Coach(
        user: user!,
        id: mapResponse['id'],
        plans: mapResponse['plans'],
        trainees: mapResponse['trainees']);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var isWide = width >= 1200;
    var isTablet = width < 1200 && width > 680;
    var isMobile = width <= 680;
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: loadUserAndCoach(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();

              default:
                return (Column(
                  children: [
                    Navbar(
                      isLoggedIn: true,
                      username: '${user!.firstName} ${user!.lastName}',
                      prefs: widget.prefs,
                    ),
                    Card(
                        elevation: 50,
                        child: Container(
                          width: width * 95,
                          height: height * 0.8,
                          child: Column(
                            children: [
                              Text(
                                "مشخصات " +
                                    user!.firstName +
                                    " " +
                                    user!.lastName,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "B Yekan"),
                              ),
                            ],
                          ),
                        ))
                  ],
                ));
            }
          },
        ),
      ),
    );
  }
}
