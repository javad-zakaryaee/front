import 'package:flutter/material.dart';
import 'package:front/Navbar.dart';
import 'API.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoachPage extends StatefulWidget {
  const CoachPage({Key? key}) : super(key: key);

  @override
  _CoachPageState createState() => _CoachPageState();
}

class _CoachPageState extends State<CoachPage> {
  final basePath = 'localhost:8081/api/v1';
  final userPath = '/user';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var isWide = width >= 1200;
    var isTablet = width < 1200 && width > 680;
    var isMobile = width <= 680;
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(children: [
        Navbar(),
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
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: height * 0.075,
                          child: const Text(
                            'صفحه مربی',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontFamily: "B Yekan",
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))))
      ]),
    );
  }
}
