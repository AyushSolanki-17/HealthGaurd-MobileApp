import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';

// ignore: must_be_immutable
class ReportScreen extends StatelessWidget{

  final Map<String, dynamic> result;

  const ReportScreen({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0)
        ),
        margin: EdgeInsets.all(1.0),
        child: Column(
          children: [
            Container(
              padding:
              EdgeInsets.only(left: 5.0, right: 5.0, top: 75.0, bottom: 50.0),
              color: Global.seaGreen,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Health Guard Report',
                  style: TextStyle(fontSize: 35.0, color: Global.black),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.0,),
                    ReportField(heading: "Patient Name",content: result['fname'],),
                    SizedBox(height: 10.0,),
                    ReportField(heading: "Patient Email",content: result['email'],),
                    SizedBox(height: 10.0,),
                    ReportField(heading: "Test Type",content: result["type"],),
                    SizedBox(height: 10.0,),
                    ReportField(heading: "Result",content: result['result'],),
                    SizedBox(height: 10.0,),
                    DescField(heading: "Description",content: result["description"],),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class ReportField extends StatelessWidget{
  final String heading;
  final String content;

  const ReportField({Key key, this.heading, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(child: Text("${this.heading}: ",style: TextStyle(fontSize: 20.0),),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          margin: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Expanded(child: Text("${this.content}",style: TextStyle(fontSize: 20.0,color: Global.redAccent,),)),
      ],
    );
  }
}
class DescField extends StatelessWidget{
  final String heading;
  final String content;

  const DescField({Key key, this.heading, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Text("${this.heading}: ", style: TextStyle(fontSize: 20.0, ),),padding: EdgeInsets.symmetric(horizontal: 15.0),margin: EdgeInsets.symmetric(vertical: 15.0),),
        Container(child: Text("${this.content}",textAlign: TextAlign.justify,style: TextStyle(color: Global.darkblue1, fontSize: 15.0),),padding: EdgeInsets.symmetric(horizontal: 15.0),),
      ],
    );
  }
}