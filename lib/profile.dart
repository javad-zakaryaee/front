import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/API.dart';
import 'package:front/Navbar.dart';
import 'package:front/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class Profile extends StatefulWidget {
  User? user;
  SharedPreferences prefs;
  Profile({Key? key, this.user, required this.prefs}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<User> loadUser() async {
    User user;
    Response response = await ApiService().getUser(
        widget.prefs.getString("token") ?? "",
        widget.prefs.getString("id") ?? "");
    user = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    return user;
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
          future: loadUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                return (Column(
                  children: [
                    Navbar(
                      isLoggedIn: true,
                      username:
                          '${snapshot.data?.firstName} ${snapshot.data?.lastName}',
                      prefs: widget.prefs,
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
