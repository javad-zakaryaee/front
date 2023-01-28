import 'package:flutter/material.dart';
import 'package:front/CoachPage.dart';
import 'package:front/Navbar.dart';
import 'package:front/TraineePage.dart';
import 'API.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                            '!به بارفیکس خوش آمدید',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontFamily: "B Yekan",
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                width * 0.01, height * 0.075, width * 0.01, 0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: " ایمیل خود را وارد کنید",
                                    hintStyle: TextStyle(fontFamily: "B Yekan"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(width: 40)),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: "رمز عبور خود را وارد کنید",
                                    hintStyle: TextStyle(fontFamily: "B Yekan"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(width: 40)),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                horizontal: 75, vertical: 25)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 148, 29, 69)))),
                                  ),
                                  onPressed: () {
                                    ApiService()
                                        .Login(emailController.text,
                                            passwordController.text)
                                        .then((json) {
                                      var user = jsonDecode(json);
                                      var role;
                                      if (user != null) role = user['role'];
                                      if (role == 'trainee')
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: ((context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    TraineePage())));
                                      if (role == 'coach')
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: ((context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    CoachPage())));
                                    });
                                  },
                                  child: Text(
                                    "ورود",
                                    style: TextStyle(
                                        fontFamily: "B Yekan", fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))))
      ]),
    );
  }
}
