import 'package:flutter/material.dart';
import 'package:front/pages/HomePage.dart';
import 'package:front/pages/LoginPage.dart';
import 'package:front/pages/SignUpPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barfix App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => SignUpPage(),
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/')
      //     return PageRouteBuilder(pageBuilder: (_, __, ___) => HomePage());
      //   if (settings.name == '/login')
      //     return PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage());
      //   if (settings.name == '/register')
      //     return PageRouteBuilder(pageBuilder: (_, __, ___) => SignUpPage());
      // },
      theme: ThemeData(
          primarySwatch: Colors.pink,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontFamily: "B Yekan")),
    );
  }
}
