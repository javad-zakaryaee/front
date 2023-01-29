import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/API.dart';
import 'package:front/CoachPage.dart';
import 'package:front/Navbar.dart';
import 'package:front/TraineePage.dart';
import 'package:front/models/coach.dart';
import 'package:front/models/gym.dart';
import 'package:front/models/trainee.dart';
import 'package:front/models/user.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';

List<String> roleList = <String>['انتخاب', 'مربی', 'ورزشکار'];

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

SharedPreferences? prefs;

class _SignUpPageState extends State<SignUpPage> {
  late DateTime selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toString();
      });
    }
  }

  var roleDropdownValue = roleList.first;
  var gymDropdownValue = 'انتخاب باشگاه';
  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var dateController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  var goalController = TextEditingController();

  List<Gym> gymData = [];
  List<String> gymNames = ['انتخاب باشگاه'];
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
        .then((value) => setState(() => prefs = value));
    ApiService().getAllGyms().then((value) {
      setState(() {
        List<dynamic> gymMap = json.decode(utf8.decode(value.bodyBytes));

        gymMap.forEach((element) {
          gymData.add(Gym.fromJson(element));
          gymNames.add(Gym.fromJson(element).name);
        });
      });
    });
  }

  var isCoach = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var isWide = width >= 1200;
    var isTablet = width < 1200 && width > 680;
    var isMobile = width <= 680;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(children: [
        Navbar(
          isLoggedIn: false,
        ),
        Container(
            height: height * 0.89,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 56, 71, 151),
                  Color(0xFF277AF6)
                ])),
            child: Center(
                child: SizedBox(
              width: width * 0.5,
              child: Card(
                elevation: 100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.075,
                        color: Colors.pink,
                        child: const Text(
                          'ثبت حساب جدید',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontFamily: "B Yekan", fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: firstNameController,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black),
                                validator: ((value) {
                                  if (value == null || value.isEmpty) {
                                    return "نمی تواند خالی باشد";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: InputDecoration(
                                  hintText: "نام",
                                  hintStyle:
                                      const TextStyle(fontFamily: "B Yekan"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(width: 40)),
                                ),
                              ),
                              // SizedBox(
                              //   width: width * 0.02,
                              // ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextFormField(
                                controller: lastNameController,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black),
                                validator: ((value) {
                                  if (value == null || value.isEmpty) {
                                    return "نمی تواند خالی باشد";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: InputDecoration(
                                  hintText: "نام خانوادگی",
                                  hintStyle:
                                      const TextStyle(fontFamily: "B Yekan"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(width: 40)),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextFormField(
                                controller: emailController,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value == null ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return 'ایمیل درست وارد نشده است';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: " ایمیل خود را وارد کنید",
                                  hintStyle:
                                      const TextStyle(fontFamily: "B Yekan"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(width: 40)),
                                ),
                              ),

                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black),
                                validator: ((value) {
                                  if (value == null || value.isEmpty) {
                                    return "نمی تواند خالی باشد";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: InputDecoration(
                                  hintText: "رمز عبور ",
                                  hintStyle:
                                      const TextStyle(fontFamily: "B Yekan"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(width: 40)),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextFormField(
                                controller: confirmPasswordController,
                                obscureText: true,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black),
                                validator: ((value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value != passwordController.text) {
                                    return "نمی تواند خالی باشد";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: InputDecoration(
                                  hintText: "تکرار رمز عبور",
                                  hintStyle:
                                      const TextStyle(fontFamily: "B Yekan"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(width: 40)),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextFormField(
                                  controller: dateController,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(color: Colors.black),
                                  validator: ((value) {
                                    if (value == null || value.isEmpty) {
                                      return "نمی تواند خالی باشد";
                                    } else {
                                      return null;
                                    }
                                  }),
                                  decoration: InputDecoration(
                                    hintText: 'تاریخ تولد',
                                    hintStyle:
                                        const TextStyle(fontFamily: "B Yekan"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            const BorderSide(width: 40)),
                                  ),
                                  readOnly: true,
                                  onTap: () => _selectDate(context)),

                              SizedBox(
                                height: height * 0.02,
                              ),
                              DropdownButtonFormField<String>(
                                value: roleDropdownValue,
                                style: const TextStyle(color: Colors.black),
                                elevation: 16,
                                validator: (value) {
                                  if (value != "انتخاب") {
                                    return null;
                                  } else {
                                    return "نقش خود را مشخص کنید";
                                  }
                                },
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value == 'مربی') {
                                      isCoach = true;
                                    } else {
                                      isCoach = false;
                                    }

                                    roleDropdownValue = value!;
                                  });
                                },
                                items: roleList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Visibility(
                                visible: isCoach,
                                child: DropdownButtonFormField<String>(
                                  value: gymDropdownValue,
                                  style: const TextStyle(color: Colors.black),
                                  elevation: 16,
                                  // validator: (value) {
                                  //   if (value != "انتخاب باشگاه") {
                                  //     return null;
                                  //   } else {
                                  //     return "باشگاه خود را مشخص کنید";
                                  //   }
                                  // },
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      gymDropdownValue = value!;
                                    });
                                  },
                                  items: gymNames.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Visibility(
                                  visible:
                                      !isCoach && roleDropdownValue != 'انتخاب',
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: weightController,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        // validator: ((value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return "نمی تواند خالی باشد";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // }),
                                        decoration: InputDecoration(
                                          hintText: 'وزن فعلی',
                                          hintStyle: const TextStyle(
                                              fontFamily: "B Yekan"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide:
                                                  const BorderSide(width: 40)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      TextFormField(
                                        controller: heightController,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        // validator: ((value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return "نمی تواند خالی باشد";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // }),
                                        decoration: InputDecoration(
                                          hintText: 'قد فعلی',
                                          hintStyle: const TextStyle(
                                              fontFamily: "B Yekan"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide:
                                                  const BorderSide(width: 40)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      TextFormField(
                                        controller: goalController,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        // validator: ((value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return "نمی تواند خالی باشد";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // }),
                                        decoration: InputDecoration(
                                          hintText: 'هدف ',
                                          hintStyle: const TextStyle(
                                              fontFamily: "B Yekan"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide:
                                                  const BorderSide(width: 40)),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: 75, vertical: 25)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 148, 29, 69)))),
                                ),
                                onPressed: () {
                                  var role = "";
                                  if (roleDropdownValue == "مربی") {
                                    role = "coach";
                                  }
                                  if (roleDropdownValue == "ورزشکار") {
                                    role = "trainee";
                                  }
                                  if (formKey.currentState!.validate()) {
                                    print("validated");

                                    User newUser = User(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        role: role,
                                        birthdate:
                                            DateUtils.dateOnly(selectedDate));
                                    ApiService()
                                        .signUp(newUser)
                                        .then((userResponse) {
                                      if (userResponse.statusCode == 201) {
                                        if (role == "coach") {
                                          Gym newCoachGym = gymData.singleWhere(
                                              (element) =>
                                                  element.name ==
                                                  gymDropdownValue);
                                          Coach newCoach = Coach(
                                              gym: newCoachGym, user: newUser);
                                          ApiService()
                                              .signUpCoach(newCoach)
                                              .then((coachResponse) {
                                            if (coachResponse.statusCode ==
                                                201) {
                                              var user = json.decode(
                                                  utf8.decode(
                                                      coachResponse.bodyBytes));
                                              prefs?.setString(
                                                  "token", user['token']);
                                              prefs?.setString(
                                                  "id", user['id']);
                                              Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                      pageBuilder: ((context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          CoachPage(
                                                            prefs: prefs!,
                                                          ))));
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) =>
                                                      const Text(
                                                          "An error occured")));
                                            }
                                          });
                                        } else {
                                          Trainee newTrainee = Trainee(
                                              user: newUser,
                                              height: int.parse(
                                                  heightController.text),
                                              weight: double.parse(
                                                  weightController.text),
                                              goal: goalController.text);
                                          ApiService()
                                              .signUpTrainee(newTrainee)
                                              .then((traineeResponse) {
                                            if (traineeResponse.statusCode ==
                                                201) {
                                              Map<String, dynamic> response =
                                                  json.decode(utf8.decode(
                                                      traineeResponse
                                                          .bodyBytes));

                                              prefs?.setString(
                                                  "token", response['token']);
                                              prefs?.setString(
                                                  "id", response['id']);
                                              Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                      pageBuilder: ((context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          TraineePage(
                                                            prefs: prefs!,
                                                          ))));
                                            } else
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    Text("An error occured"),
                                              );
                                          });
                                        }
                                      } else if (userResponse.statusCode ==
                                          409) {
                                        showDialog(
                                            context: context,
                                            builder: ((context) => const Text(
                                                "Email already used!")));
                                      }
                                    });
                                  } else
                                    print("no valid");
                                },
                                child: const Text(
                                  "ثبت نام",
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
              ),
            )))
      ]),
    );
  }
}
