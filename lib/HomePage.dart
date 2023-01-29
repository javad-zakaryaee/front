import 'package:flutter/material.dart';
import 'package:front/LoginPage.dart';
import 'package:front/Navbar.dart';
import 'package:front/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var isWide = width >= 1200;
    var isTablet = width < 1200 && width > 680;
    var isMobile = width <= 680;
    Future<SharedPreferences> getPrefs() {
      return SharedPreferences.getInstance();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
          future: getPrefs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            else if (!snapshot.data!.containsKey("id")) {
              return Column(
                children: [
                  Navbar(isLoggedIn: false),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Color.fromARGB(255, 56, 71, 151),
                              Color(0xFF277AF6)
                            ])),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(width * 0.03,
                                height * 0.04, width * 0.1, height * 0.02),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: height * 0.5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                      child: Image.asset(
                                        "assets/images/landing.jpg",
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "باشگاه را به خانه خود بیاورید.",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(fontSize: 32),
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          side: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      30,
                                                                      233,
                                                                      155)))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(255,
                                                              24, 177, 118)),
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.all(35)),
                                                ),
                                                child: Text(
                                                  "ثبت مربی",
                                                  style: TextStyle(
                                                    height: 1.0,
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.005,
                                            ),
                                            Container(
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .red))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.pink),
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.all(35)),
                                                ),
                                                child: Text(
                                                  "ثبت ورزشکار",
                                                  style: TextStyle(
                                                    height: 1.0,
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))),
                  ),
                ],
              );
            } else {
              return FutureBuilder(
                  future: getPrefs(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    else {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  Profile(prefs: snapshot.data!))));
                      return Container();
                    }
                  }));
            }
          }),
    );
  }
}
