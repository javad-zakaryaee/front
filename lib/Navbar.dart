import 'package:flutter/material.dart';
import 'package:front/HomePage.dart';
import 'package:front/LoginPage.dart';

import 'SignUpPage.dart';

class Navbar extends StatelessWidget {
  bool? isLoggedIn;
  Navbar({Key? key, this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var isWide = width >= 1200;
    var isTablet = width < 1200 && width > 680;
    var isMobile = width <= 680;
    return Column(
      children: [
        if (isWide)
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 56, 71, 151),
                  Color(0xFF277AF6)
                ])),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.03, height * 0.04, width * 0.1, height * 0.02),
              child: Container(
                height: height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.all(20),
                                      side: BorderSide(
                                          width: 2.0, color: Colors.pink),
                                      textStyle: TextStyle(
                                          fontSize: 16, fontFamily: "B Yekan"),
                                      foregroundColor: Colors.white),
                                  child: Text("ورود")),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text("ثبت نام"),
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(20),
                                    textStyle: TextStyle(
                                        fontSize: 16, fontFamily: "B Yekan"),
                                    backgroundColor: Colors.pink),
                              )
                            ],
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 16, fontFamily: "B Yekan"),
                                  foregroundColor: Colors.white),
                              onPressed: () {},
                              child: Text("درباره ما")),
                          TextButton(
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 16, fontFamily: "B Yekan"),
                                  foregroundColor: Colors.white),
                              onPressed: () {},
                              child: Text("تماس با ما")),
                          TextButton(
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 16, fontFamily: "B Yekan"),
                                foregroundColor: Colors.white),
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text("صفحه اصلی"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "بارفیکس",
                          style: TextStyle(fontSize: 32),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
