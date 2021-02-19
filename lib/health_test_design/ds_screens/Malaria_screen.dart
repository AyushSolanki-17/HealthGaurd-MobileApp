import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/Models/ht_data/Diseases.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/health_test_design/questionbox.dart';
import 'package:health_guard/main.dart';

import '../report_screen.dart';

class Malaria_screen extends StatefulWidget {
  @override
  _Malaria_screenState createState() => _Malaria_screenState();
}

class _Malaria_screenState extends State<Malaria_screen> {
  Malaria malaria = new Malaria();
  bool has_errors = false;
  void refreshToken(){
    var currentUser = CurrentUserInfo.of(context).currentUser;
    currentUser.refresh();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = CurrentUserInfo.of(context).currentUser;
    this.malaria.cu = currentUser;
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
                'Malaria Self-Assesment Test',
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
                          this.malaria.fever = val;
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
                          this.malaria.headache = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing shivering?',
                      answers: {
                        'No': 0,
                        'Yes': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.malaria.shivering = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing vomiting?',
                      answers: {
                        'No': 0,
                        'Only Nausea': 1,
                        'Vomiting 1 or 2 times':2,
                        'Vomiting 3+ times':3,
                      },
                      callback: (int val) {
                        setState(() {
                          this.malaria.vomitting = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing cough?',
                      answers: {
                        'No': 0,
                        'Low/sometimes/after eating oily foods': 1,
                        'High constant/pain in chest': 2,
                      },
                      callback: (int val) {
                        setState(() {
                          this.malaria.cough = val;
                        });
                      },
                    ),

                    QuestionBox(
                      question: 'Are you experiencing problems in breathing?',
                      answers: {
                        'No': 0,
                        'Yes, but only after movement/exercise': 1,
                        'Yes, high without movement': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.malaria.respiratory = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing increase in your heartbeat?',
                      answers: {
                        'No': 0,
                        'Yes': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.malaria.fastheartrate = val;
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
                          this.malaria.fatigue = val;
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
                          this.malaria.chronic = val;
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
                          this.malaria.days = val;
                        });
                      },
                    ),
                    has_errors?Text('Please answer all the questions'):SizedBox(height:5.0),
                    SizedBox(height:15.0),
                    Material(
                      color: Global.redAccent,
                      child: InkWell(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                          child: Text(
                            'Check Results',
                            style: TextStyle(color: Global.white, fontSize: 20.0),
                          ),
                        ),
                        onTap: () {
                          if(malaria.is_valid()){
                            var result = malaria.check();
                            result.then((value){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>(ReportScreen(result: value,))));
                            });
                          }
                          else{
                            setState(() {
                              has_errors = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}