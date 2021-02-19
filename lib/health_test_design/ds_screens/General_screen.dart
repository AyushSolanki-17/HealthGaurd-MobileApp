import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/Models/ht_data/Diseases.dart';
import 'package:health_guard/health_test_design/report_screen.dart';

import '../../globals.dart';
import '../../main.dart';
import '../questionbox.dart';

class General_screen extends StatefulWidget {
  @override
  _General_screenState createState() => _General_screenState();
}

class _General_screenState extends State<General_screen> {
  General general = General();
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
    this.general.cu = currentUser;
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
                'General Self-Assesment Test',
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
                          this.general.fever = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing rashes on your skin?',
                      answers: {
                        'No': 0,
                        'Yes, but on single area or body part': 1,
                        'Yes, more than one body part': 2,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.rashes = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing any kind of pain in your joints?',
                      answers: {
                        'No': 0,
                        'Yes, but after movement or recent travelling, exercise etc.': 1,
                        'Yes, Mild without any movement': 2,
                        'Yes, constant without any movement': 3,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.jointpain = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing bleeding from any body part like mouth or nose?',
                      answers: {
                        'No': 0,
                        'Yes': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.bleeding = val;
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
                          this.general.fatigue = val;
                        });
                      },
                    ),

                    QuestionBox(
                      question: 'Are you experiencing swelling in your body part?',
                      answers: {
                        'No': 0,
                        'Yes': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.swelling = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question: 'Are you experiencing vomiting?',
                      answers: {
                        'No': 0,
                        'Nausea only': 1,
                        'Vomiting 1 or 2 times': 1,
                        'Vomiting 3+ times': 1,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.vomiting = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question:
                      'Are you experiencing coughing?',
                      answers: {
                        'No': 0,
                        'Low/sometimes/after eating oily foods': 1,
                        'High constant/pain in chest': 2,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.cough = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question:
                      'Are you experiencing shivering?',
                      answers: {
                        'No': 0,
                        'Low with normal conditions': 1,
                        'Constant even in warm place': 2,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.shivering = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question:
                      'Are you experiencing problems in breathing?',
                      answers: {
                        'No': 0,
                        'Yes, after movement/exercise': 1,
                        'Yes, even while doing normal works': 2,
                        'Constant problems even while resting': 3,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.respiratory = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question:
                      'Are you experiencing loss of smell?',
                      answers: {
                        'No': 0,
                        'Yes, loss of smell only': 1,
                        'Yes, loss of smell + loss of taste': 2,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.lossofsmell = val;
                        });
                      },
                    ),
                    QuestionBox(
                      question:
                      'Are you experiencing sorethroat?',
                      answers: {
                        'No': 0,
                        'Yes, after eating food': 1,
                        'Yes, constant': 2,
                      },
                      callback: (int val) {
                        setState(() {
                          this.general.sorethroat = val;
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
                          this.general.days = val;
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
                          if(general.is_valid()){
                            var result = general.check();
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