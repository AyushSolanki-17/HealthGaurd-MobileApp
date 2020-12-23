import 'package:flutter/material.dart';
import 'package:health_guard/home_design/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_guard/login_design/login_view.dart';
import 'package:health_guard/login_design/signup_page.dart';

class HomePage  extends StatefulWidget{
  @override
  _HomePageState createState ()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{

  bool isUserAuthenticated = false;
  Map<String,dynamic> CurrentUser;
  void getCurrentUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user_email = await pref.getString('email');
    if(user_email == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> SignUpPageGuider()),(Route<dynamic> route)=> false);
    }
    else {
      String user_fname = await pref.getString('fname');
      String user_access_token = await pref.getString('access_token');
      String user_refresh_token = await pref.getString('refresh_token');
      var cu = {
        'email': user_email,
        'fname': user_fname,
        'access_token': user_access_token,
        'refresh_token': user_refresh_token,
      };
      setState(() {
        CurrentUser = cu;
        isUserAuthenticated = true;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return isUserAuthenticated?Dashboard(fname:CurrentUser['fname'],email:CurrentUser['email']):CircularProgressIndicator();
  }

}