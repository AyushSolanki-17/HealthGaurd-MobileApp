// This file describes the Test Screen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/Models/ht_data/ht_diseases.dart';
import 'package:health_guard/health_test_design/questionbox.dart';

class HealthTestScreen extends StatefulWidget {
  @override
  _HealthTestScreenState createState() => _HealthTestScreenState();
}

class _HealthTestScreenState extends State<HealthTestScreen> {

  @override
  void initState() {
    super.initState();
  }
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
                'Self-Assesment Test',
                style: TextStyle(fontSize: 25.0, color: Global.white),
              ),
            ),
          ),
          Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 25.0, top: 50.0, bottom: 25.0, right: 25.0),
                children: [
                  for (var x in Diseases.keys) DiseaseNavButton(diseaseName:x.toString()),
              ],
          ))
        ],
      ),
    );
  }
}

class DiseaseNavButton extends StatelessWidget{
  final String diseaseName;

  const DiseaseNavButton({Key key, this.diseaseName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => (Diseases['${diseaseName}'])));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          color: Global.seaGreen,
        ),
        margin: EdgeInsets.symmetric(vertical: 15.0),
        child: Align(
          child: Text('${diseaseName}', style: TextStyle(fontSize: 20.0),),
        ),
      ),
    );
  }

}