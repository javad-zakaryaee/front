import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/API.dart';
import 'package:front/pages/AllPlansPage.dart';
import 'package:front/Navbar.dart';
import 'package:front/pages/PlanPage.dart';
import 'package:front/models/trainee.dart';
import 'package:front/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class TraineePage extends StatefulWidget {
  User? user;
  SharedPreferences prefs;
  TraineePage({Key? key, this.user, required this.prefs}) : super(key: key);

  @override
  _TraineePageState createState() => _TraineePageState();
}

User? user;
Trainee? trainee;

class _TraineePageState extends State<TraineePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Future<void> loadUserAndTrainee() async {
    Response traineeResponse = await ApiService().getTrainee(
        widget.prefs.getString("token") ?? "",
        widget.prefs.getString("id") ?? "");
    Map<String, dynamic> mapResponse =
        (json.decode(utf8.decode(traineeResponse.bodyBytes)));
    user = User.fromJson(mapResponse['user']);
    trainee = Trainee(
        user: user!,
        height: mapResponse['height'],
        weight: mapResponse['weight'],
        goal: mapResponse['goal']);
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
          future: loadUserAndTrainee(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();

              default:
                bool hasPlan = trainee!.plan != null;
                return (Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Navbar(
                      isLoggedIn: true,
                      username: '${user!.firstName} ${user!.lastName}',
                      prefs: widget.prefs,
                    ),
                    Card(
                        elevation: 50,
                        child: Container(
                          width: width * 0.5,
                          height: height * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "مشخصات " +
                                    user!.firstName +
                                    " " +
                                    user!.lastName,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: "B Yekan"),
                              ),
                              Text(
                                "هدف: " + trainee!.goal,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                "وزن فعلی: " + trainee!.weight.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                "قد فعلی: " + trainee!.height.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Visibility(
                                  visible: hasPlan,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: ((context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    PlanPage(
                                                        planId:
                                                            trainee!.plan!.id,
                                                        userId: user!.id!))));
                                      },
                                      child: Text("show plan"))),
                              Visibility(
                                  visible: !hasPlan,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: ((context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    AllPlansPage(
                                                      user: user,
                                                    ))));
                                      },
                                      child: Text(
                                        "اولین برنامه خود را دریافت کنید",
                                        style: TextStyle(fontSize: 22),
                                      )))
                            ],
                          ),
                        )),
                    SizedBox(
                      height: height * 0.2,
                    )
                  ],
                ));
            }
          },
        ),
      ),
    );
  }
}
