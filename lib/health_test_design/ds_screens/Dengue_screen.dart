import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/health_test_design/questionbox.dart';
import 'package:health_guard/Models/ht_data/Diseases.dart';

class Dengue_screen extends StatefulWidget {
  @override
  _Dengue_screenState createState() => _Dengue_screenState();
}

class _Dengue_screenState extends State<Dengue_screen> {
  Dengue dengue = Dengue();
  bool has_errors = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 5.0, right: 5.0, top: 75.0, bottom: 50.0),
            color: Global.mediumGreen,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Dengue Self-Assesment Test',
                style: TextStyle(fontSize: 25.0, color: Global.white),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 25.0, top: 50.0, bottom: 25.0, right: 25.0),
            child: Column(
              children: [
                QuestionBox(
                  question: 'Which kind of Fever you are experiencing?',
                  answers: {
                    'No Fever': 0,
                    'Low or Mild': 1,
                    'Recurring after taking medicines': 2,
                    'Constant high fever': 3,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.fever = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Are you experiencing headache?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.headache = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Have you seen rashes on your skin?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.rashes = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Are you experiencing nausea or vomiting?',
                  answers: {
                    'No': 0,
                    'Yes, but only Nausea': 1,
                    'Vomiting 1-2 times': 2,
                    'Vomiting more than 3 times': 3,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.nausea_vomiting = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Are you experiencing pain in your eyes?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.eyepain = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Are you experiencing pain in your muscles?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.musclepain = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Are you experiencing pain in your joints?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.jointpain = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Are you experiencing loss of taste?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.loss_of_appetite = val;
                    });
                  },
                ),
                QuestionBox(
                  question: 'Are you experiencing weakness?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.fatigue = val;
                    });
                  },
                ),
                QuestionBox(
                  question:
                      'Are you experiencing bleeding from any part of your body like nose etc..?',
                  answers: {
                    'No': 0,
                    'Yes': 1,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.bleeding = val;
                    });
                  },
                ),
                QuestionBox(
                  question:
                      'From how many days are you experiencing these symptoms?',
                  answers: {
                    'Today': 1,
                    'Yesterday': 2,
                    'The day before yesterday': 3,
                    'More than 2 days': 4,
                  },
                  callback: (int val) {
                    setState(() {
                      this.dengue.days = val;
                    });
                  },
                ),
                has_errors?Text('Has Error'):SizedBox(height:5.0),
                SizedBox(height:15.0),
                FlatButton(
                  color: Global.redAccent,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    child: Text(
                      'Check Results',
                      style: TextStyle(color: Global.white, fontSize: 20.0),
                    ),
                    color: Global.redAccent,
                  ),
                  onPressed: () {
                    if(dengue.is_valid()){

                    }
                    else{
                      setState(() {
                        has_errors = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
