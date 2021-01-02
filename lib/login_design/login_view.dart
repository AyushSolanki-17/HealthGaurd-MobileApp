//this page is for login form

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/login_design/home_model.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/login_design/button_widget.dart';
import 'package:health_guard/login_design/textfield_widget.dart';
import 'package:health_guard/login_design/wave_widget.dart';
import 'package:health_guard/login_design/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:health_guard/home_design/home_page.dart';
import 'package:health_guard/Models/User.dart';
import 'package:health_guard/main.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Map<String, dynamic> server_respond;
  bool is_submitted = false;
  bool has_errors = false;

  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();

  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  void setUser(String u_email, String u_name, String u_accesstoken,
      String u_refreshtoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', u_email);
    prefs.setString('fname', u_name);
    prefs.setString('access_token', u_accesstoken);
    prefs.setString('refresh_token', u_refreshtoken);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final model = Provider.of<HomeModel>(context);

    return Scaffold(
      backgroundColor: Global.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: Global.mediumGreen,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Global.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    color: Global.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextFieldWidget(
                  hintText: 'Email',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                  suffixIconData: model.isValid ? Icons.check : null,
                  onChanged: (value) {
                    model.isValidEmail(value);
                  },
                  controller: EmailController,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'Password',
                      obscureText: model.isVisible ? false : true,
                      prefixIconData: Icons.lock_outline,
                      suffixIconData: model.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      controller: PasswordController,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Global.mediumGreen,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  //Container to display errors while submitting the form
                  padding: EdgeInsets.only(left: 7.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: has_errors
                          ? Text(
                              server_respond['Error'].toString(),
                              style: TextStyle(color: Colors.red),
                            )
                          : Text('')),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Material(
                  child: InkWell(
                    child: ButtonWidget(
                      title: 'Login',
                      hasBorder: false,
                    ),
                    onTap: () {
                      var user = HealthGuardUser.LogUserData(
                          EmailController.text.toString(),
                          PasswordController.text.toString());
                      if (user.is_validLogin()) {
                        var respond = user.login();
                        respond.then((value) {
                          setState(() {
                            server_respond = value;
                            if (value['Error'] != null) {
                              has_errors = true;
                            } else {
                              CurrentUserInfo.of(context).currentUser.email = value['email'];
                              CurrentUserInfo.of(context).currentUser.fname = value['fname'];
                              CurrentUserInfo.of(context).currentUser.access_token = value['access_token'];
                              CurrentUserInfo.of(context).currentUser.refresh_token = value['refresh_token'];
                              setUser(
                                  value['email'],
                                  value['fname'],
                                  value['access_token'],
                                  value['refresh_token']);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>HomePage()),(Route<dynamic> route) => false);
                            }
                          });
                        }).catchError((err) {
                          server_respond = {
                            'Error': 'Server Errors! try again later...'
                          };
                          setState(() {
                            has_errors = true;
                          });
                        });
                      } else {
                        setState(() {
                          has_errors = true;
                          server_respond = user.validateLogin();
                        });
                      }
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Divider(
                      color: Global.mediumGreen,
                      thickness: 2,
                      indent: size.width / 25.0,
                      endIndent: size.width / 25.0,
                      height: 25,
                    ),
                  ],
                ),
                InkWell(
                  child: ButtonWidget(
                    title: 'Sign Up',
                    hasBorder: true,
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SignUpPageGuider()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPageGuider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (context) => HomeModel(), child: LoginView());
  }
}
