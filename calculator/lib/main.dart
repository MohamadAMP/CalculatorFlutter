import 'package:calculator/calc.dart';
import 'package:calculator/database.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:path/path.dart';

void main() {
  runApp(Home());
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Login Page",
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                child: Center(
                  child: Text(
                    "Login To Calculator",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                controller: userController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'E-mail'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                controller: passController,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    labelText: 'Password'),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            TextButton(
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SimpleCalculator()),
                )
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.fromLTRB(150, 10, 150, 10)),
            ),
            const SizedBox(
              height: 55,
            ),
          ],
        ));
  }
}
