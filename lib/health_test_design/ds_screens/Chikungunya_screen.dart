import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/health_test_design/questionbox.dart';
import 'package:health_guard/Models/ht_data/Diseases.dart';

class Chikungunya_screen extends StatefulWidget {
  @override
  _Chikungunya_screenState createState() => _Chikungunya_screenState();
}

class _Chikungunya_screenState extends State<Chikungunya_screen> {
  Chikungunya chikungunya = Chikungunya();
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
                'Chikungunya Self-Assesment Test',
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
                          this.chikungunya.fever = val;
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
                          this.chikungunya.headache = val;
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
                          this.chikungunya.rashes = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing pain in your joints?',
                      answers: {
                        'No': 0,
                        'Mild or Sometimes': 1,
                        'Several and constant':2,
                      },
                      callback: (int val) {
                        setState(() {
                          this.chikungunya.jointpain = val;
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
                          this.chikungunya.musclepain = val;
                        });
                      },
                    ),

                    QuestionBox(
                      question: 'Are you experiencing welling in your body part?',
                      answers: {
                        'No': 0,
                        'Yes': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.chikungunya.swelling = val;
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
                          this.chikungunya.fatigue = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question:
                      'Are you suffering from long term disease like diabetes/BP/Cancer ?',
                      answers: {
                        'No': 0,
                        'Yes': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.chikungunya.chronic = val;
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
                          this.chikungunya.days = val;
                        });
                      },
                    ),
                    has_errors?Text('Please answer all the questions'):SizedBox(height:5.0),
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
                        if(chikungunya.is_valid()){

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
