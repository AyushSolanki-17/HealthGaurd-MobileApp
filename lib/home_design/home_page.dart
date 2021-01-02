import 'package:flutter/material.dart';
import 'package:health_guard/Models/CurrentUser.dart';
import 'package:health_guard/home_design/Dashboard.dart';
import 'package:health_guard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_guard/login_design/login_view.dart';
import 'package:health_guard/login_design/signup_page.dart';
import 'package:health_guard/Models/CurrentUser.dart';




class HomePage  extends StatefulWidget{
  @override
  _HomePageState createState ()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{



  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var currentUser = CurrentUserInfo.of(context).currentUser;
    if (currentUser.email != ''){
      return Dashboard();
    }
    else{
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

  }

}