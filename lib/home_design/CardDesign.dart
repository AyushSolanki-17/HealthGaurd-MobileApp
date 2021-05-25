import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget{

  final String buttonText;
  final IconData buttonIcons;
  double screenWidth, screenHeight;

  MyCard({
   this.buttonText,
    this.buttonIcons,
});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Material(
      child: InkWell(
        child: Container(
          width: screenWidth/1.5,
          height: screenHeight/5.5,
          decoration: BoxDecoration(
              color: Global.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Global.gray,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 0.5),
                BoxShadow(
                    color: Global.lightBlue,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 0.5),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                buttonIcons,
                size: 30.0,
                color: Global.blue,
              ),
              SizedBox(height: 10.0),
              Text(buttonText,
                style: TextStyle(
                  color: Global.black,
                  fontSize: 20.0,
                ),),
            ],
          ),
        ),
      ),
    );
  }

}