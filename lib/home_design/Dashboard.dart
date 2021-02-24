import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_guard/Models/CurrentUser.dart';
import 'package:health_guard/globals.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:health_guard/fonts_icons/med_icons.dart';
import 'package:health_guard/health_test_design/ht_screen.dart';
import 'package:health_guard/home_design/home_page.dart';
import 'package:health_guard/medicine_reminder/ReminderScreen.dart';
import '../main.dart';
import 'CardDesign.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {

  String greetings;
  CurrentUser currentUser = new CurrentUser();
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    DateTime time = DateTime.now();
    setState(() {
      if(time.hour<12){this.greetings = "Good Morning!!";}
      else if(time.hour<16){this.greetings = "Good Afternoon!!";}
      else {this.greetings = "Good Evening!!";}
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        this.currentUser = CurrentUserInfo.of(context).currentUser;
      });
    });

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Global.blue,
        body: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context,this.currentUser.fname),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SideMenuButton(
                  buttonText: "User Detail",
                  buttonIcon: Icons.person_sharp,
                ),
                SideMenuButton(
                  buttonText: "Join Us",
                  buttonIcon: Icons.add_outlined,
                ),
                SideMenuButton(
                  buttonText: "Feedback",
                  buttonIcon: Icons.feedback_outlined,
                ),
                SideMenuButton(
                  buttonText: "Join Us",
                  buttonIcon: Icons.logout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context,fname) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: isCollapsed
              ? BorderRadius.all(Radius.circular(0))
              : BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Global.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: WaveClipperTwo(),
                        child: Container(
                          height: screenHeight / 3.0,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Global.mediumGreen, Global.seaGreen],
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 15.0),
                                  child: InkWell(
                                    child:
                                        Icon(Icons.menu, color: Global.white),
                                    onTap: () {
                                      setState(() {
                                        if (isCollapsed) {
                                          _controller.forward();
                                        } else
                                          _controller.reverse();
                                        isCollapsed = !isCollapsed;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight / 12, left: screenWidth / 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    '${this.greetings} \n${fname}',
                                    style: TextStyle(
                                      color: Global.black,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Global.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push (
                                    context,
                                    MaterialPageRoute(builder: (context) => (ReminderScreen())),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      size: 30.0,
                                      color: Global.blue,
                                    ),
                                    SizedBox(height: 3.0),
                                    Text(
                                      "Reminder",
                                      style: TextStyle(
                                        color: Global.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add_moderator,
                                    size: 30.0,
                                    color: Global.blue,
                                  ),
                                  SizedBox(height: 3.0),
                                  Text(
                                    "Emergency",
                                    style: TextStyle(
                                      color: Global.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push (
                                  context,
                                  MaterialPageRoute(builder: (context) => (HealthTestScreen())),
                                );
                              },
                              child: MyCard(
                                buttonIcons: MedIcons.notes_medical,
                                buttonText: "Self Test",
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: MyCard(
                                buttonIcons: Icons.home_work_outlined,
                                buttonText: "Hospital",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: MyCard(
                                buttonIcons: Icons.local_pharmacy_outlined,
                                buttonText: "Pharmacy",
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: MyCard(
                                buttonIcons: Icons.dashboard,
                                buttonText: "Blog",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  final String buttonText;
  final Function onPressFunc;
  final IconData buttonIcon;

  const SideMenuButton(
      {Key key, this.buttonText, this.onPressFunc, this.buttonIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressFunc,
      child: Row(
        children: <Widget>[
          Icon(
            buttonIcon,
            color: Global.black,
            size: 30.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            buttonText,
            style: TextStyle(color: Global.white, fontSize: 20.0),
          )
        ],
      ),
    );
  }
}
