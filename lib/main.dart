import 'package:flutter/material.dart';
import 'package:front/HomePage.dart';

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
      theme: ThemeData(
          primarySwatch: Colors.pink,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontFamily: "B Yekan")),
      home: const HomePage(),
    );
  }
}
