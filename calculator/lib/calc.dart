import 'package:calculator/database.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:path/path.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String eq = "0";
  String res = "0";
  String exp = "";
  late DatabaseHandler handler;

  void insert() async {
    Calc calc = Calc(expression: exp, result: res);
    List<Calc> listOfCalc = [calc];
    await handler.insertCalc(listOfCalc);
    List<Calc> t = await handler.retrieveCalc();
    t.forEach((element) {
      print(element.expression + " = " + element.result);
    });
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        eq = "0";
        res = "0";
      } else if (buttonText == "=") {
        exp = eq;
        exp = exp.replaceAll('×', '*');
        exp = exp.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression expression = p.parse(exp);

          ContextModel cm = ContextModel();
          res = '${expression.evaluate(EvaluationType.REAL, cm)}';
          insert();
        } catch (e) {
          res = "Error";
        }
      } else {
        if (eq == "0") {
          eq = buttonText;
          res = buttonText;
        } else {
          eq = eq + buttonText;
          res = res + buttonText;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB();
  }

  Widget buildButton(String text, Color backColor, bool larger) {
    if (text == 'AC') {
      return Container(
          margin: EdgeInsets.all(8),
          // height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
          child: ElevatedButton(
            onPressed: () {
              buttonPressed(text);
            },
            child: Text(
              text,
              style: TextStyle(fontSize: 35, color: Colors.black),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
                backgroundColor: MaterialStateProperty.all(backColor),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                fixedSize: MaterialStateProperty.all(const Size(286, 80))),
          ));
    } else if (text == '0') {
      return Container(
          margin: const EdgeInsets.all(8),
          // height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
          child: ElevatedButton(
            onPressed: () {
              buttonPressed(text);
            },
            child: Text(
              text,
              style: const TextStyle(fontSize: 35, color: Colors.black),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
                backgroundColor: MaterialStateProperty.all(backColor),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                fixedSize: MaterialStateProperty.all(const Size(187, 80))),
          ));
    } else {
      return Container(
          margin: const EdgeInsets.all(8),
          // height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
          child: ElevatedButton(
            onPressed: () {
              buttonPressed(text);
            },
            child: Text(
              text,
              style: const TextStyle(fontSize: 35, color: Colors.black),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
                backgroundColor: MaterialStateProperty.all(backColor),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                fixedSize: MaterialStateProperty.all(const Size(85, 80))),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(centerTitle: true, title: const Text('Calculator')),
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Text(
                  res,
                  style: const TextStyle(fontSize: 50, color: Colors.white),
                ),
              ),
              Column(
                children: [
                  Row(children: [
                    buildButton("AC", Colors.orange, true),
                    buildButton("÷", Colors.blue, false),
                  ]),
                  Row(children: [
                    buildButton("7", Colors.white, false),
                    buildButton("8", Colors.white, false),
                    buildButton("9", Colors.white, false),
                    buildButton("×", Colors.blue, false),
                  ]),
                  Row(children: [
                    buildButton("4", Colors.white, false),
                    buildButton("5", Colors.white, false),
                    buildButton("6", Colors.white, false),
                    buildButton("-", Colors.blue, false),
                  ]),
                  Row(children: [
                    buildButton("1", Colors.white, false),
                    buildButton("2", Colors.white, false),
                    buildButton("3", Colors.white, false),
                    buildButton("+", Colors.blue, false),
                  ]),
                  Row(children: [
                    buildButton("0", Colors.white, true),
                    buildButton(".", Colors.white, false),
                    buildButton("=", Colors.orange, false),
                  ]),
                ],
              ),
            ],
          ),
        ));
  }
}
