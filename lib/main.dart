import 'package:flutter/material.dart';
import 'package:health_guard/login_design/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_guard/home_design/home_page.dart';
import 'package:health_guard/health_test_design/ht_screen.dart';
import 'package:health_guard/api_credentials.dart' as api_credentials;
import 'package:health_guard/home_design/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Models/CurrentUser.dart';

void main()=>runApp(HealthGuard());

class CurrentUserInfo extends InheritedWidget{
  final CurrentUser currentUser;

  CurrentUserInfo({this.currentUser, Widget child}): super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget)=>true;

  static CurrentUserInfo of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CurrentUserInfo>();
  }

}



class HealthGuard extends StatelessWidget
{

  final CurrentUser currentUser = new CurrentUser();
  @override
  Widget build(BuildContext context) {

    precacheImage(AssetImage('assets/icon/HGlogo.png'), context);
    return CurrentUserInfo(
      currentUser: currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),//MainPage()
      ),
    );
  }
}

// Main Landing Page: Shows circular progress Indicator till data is found

class MainPage  extends StatefulWidget{
  @override
  _MainPageState createState ()=> _MainPageState();
}

class _MainPageState extends State<MainPage>{

  bool isUserAuthenticated = false;
  Map<String,dynamic> CurrentUser;
  void getCurrentUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user_email = await pref.getString('email');
    if(user_email == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> LoginPageGuider()),(Route<dynamic> route)=> false);
    }
    else {
      String user_refresh_token = await pref.getString('refresh_token');
      try{
        var url = api_credentials.API_LINK+"/api/token/refresh/";
        var response = await http.post(url, body: {
          'grant_type': 'refresh_token',
          'email': user_email,
          'refresh_token': user_refresh_token,
          'client_id': api_credentials.CLIENT_ID,
          'client_secret': api_credentials.CLIENT_SECRET,
        });
        var data = await json.decode(response.body);
        var cu = {
          'email': user_email,
          'fname': data['fname'],
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
        };
        CurrentUserInfo.of(context).currentUser.email = cu['email'];
        CurrentUserInfo.of(context).currentUser.fname = cu['fname'];
        CurrentUserInfo.of(context).currentUser.access_token = cu['access_token'];
        CurrentUserInfo.of(context).currentUser.refresh_token = cu['refresh_token'];
        setState(() {
          pref.setString('fname', cu['fname']);
          pref.setString('access_token', cu['access_token']);
          pref.setString('refresh_token', cu['refresh_token']);
          isUserAuthenticated = true;
          Navigator.of(context)
              .push(
              MaterialPageRoute(
                  builder: (context) => HomePage()
              ));
        });
      }
      catch(e){
        pref.clear();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> LoginPageGuider()),(Route<dynamic> route)=> false);
      }

    }
  }

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/icon/HGlogo.png',
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,

          ),
        ],
      ),
    );
  }

}
