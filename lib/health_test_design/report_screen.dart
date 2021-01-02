import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';

class ReportScreen extends StatelessWidget{

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
                    ReportField(heading: "Patient Name",content: "Xyz Abc",),
                    ReportField(heading: "Patient Name",content: "Xyz Abc",),
                    ReportField(heading: "Patient Name",content: "Xyz Abc",),
                    ReportField(heading: "Patient Name",content: "Xyz Abc",),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(padding: EdgeInsets.symmetric(horizontal: 4.5),child: Text("${this.heading}")),
        Container(padding: EdgeInsets.symmetric(horizontal: 4.5),child: Text("${this.content}",)),
      ],
    );
  }

}