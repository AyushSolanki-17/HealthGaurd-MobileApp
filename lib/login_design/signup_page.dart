//this page is for sign in form

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_guard/login_design/home_model.dart';
import 'package:health_guard/login_design/globals.dart';
import 'package:health_guard/login_design/button_widget.dart';
import 'package:health_guard/login_design/textfield_widget.dart';
import 'package:health_guard/login_design/wave_widget.dart';
import 'package:health_guard/Models/User.dart';
import 'package:provider/provider.dart';
import 'package:health_guard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_guard/home_design/home_page.dart';
import 'login_view.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Map<String,dynamic> server_respond;
  bool is_submitted=false;
  bool has_errors=false;
  DateTime pickedDate;
  String Gender;
  final EmailController = TextEditingController();
  final FnameController = TextEditingController();
  final MobileController = TextEditingController();
  final PasswordController = TextEditingController();
  final CpasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Gender = "M";
    pickedDate = DateTime.now();
  }

  void dispose(){
    EmailController.dispose();
    FnameController.dispose();
    MobileController.dispose();
    PasswordController.dispose();
    CpasswordController.dispose();
    super.dispose();
  }

  setGender(String val) {
    setState(() {
      Gender = val;
    });
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 75),
        lastDate: DateTime(DateTime.now().year),
        initialDate: DateTime(DateTime.now().year - 5),
    );

    if(date != null)
      setState(() {
        pickedDate = date;
      });

  }

  void setUser(String u_email, String u_accesstoken, String u_refreshtoken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', u_email);
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height,
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
                    'Sign Up',
                    style: TextStyle(
                      color: Global.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: keyboardOpen ? size.height / 7.5 : size.height / 2.5,
              height: keyboardOpen ? size.height / 2.0 : size.height / 1.75,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFieldWidget(
                        hintText: 'Name',
                        obscureText: false,
                        prefixIconData: Icons.person_add_alt_1_outlined,
                        controller: FnameController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
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
                      TextFieldWidget(
                        hintText: 'Mobile No.',
                        obscureText: false,
                        prefixIconData: Icons.call_outlined,
                        controller: MobileController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Gender',
                              style: TextStyle(
                                color: Global.mediumGreen,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Radio(value: "M",
                                groupValue: Gender,
                                onChanged: (val) {
                                  setGender(val);
                                },
                                activeColor: Global.mediumGreen,),
                              Text('Male',
                                style: TextStyle(
                                    color: Global.mediumGreen
                                ),),
                              Radio(value: "F",
                                groupValue: Gender,
                                onChanged: (val) {
                                  setGender(val);
                                },
                                activeColor: Global.mediumGreen,),
                              Text('Female',
                                style: TextStyle(
                                    color: Global.mediumGreen
                                ),),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            color: Global.white,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Date of Birth',
                                style: TextStyle(
                                  color: Global.mediumGreen,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}" ,
                              style: TextStyle(
                              color: Global.mediumGreen,
                              fontSize: 15,
                            ),
                            ),
                            trailing: Icon(Icons.date_range_sharp, color: Global.mediumGreen, size: 20,),
                            onTap: _pickDate,
                          ),
                        ],
                      ),
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
                      TextFieldWidget(
                        hintText: 'Confirm Password',
                        obscureText: model.isVisible ? false : true,
                        prefixIconData: Icons.lock_outline,
                        suffixIconData: model.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        controller: CpasswordController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        //Container to display errors while submitting the form
                        padding: EdgeInsets.only(left: 7.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                            child: has_errors? Text(server_respond['Error'].toString(),
                            style: TextStyle(color: Colors.red),):Text('')
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        child: InkWell(
                          child: ButtonWidget(
                            title: 'Sign Up',
                            hasBorder: false,
                          ),
                          splashColor: Colors.redAccent,
                          highlightColor: Colors.amber,
                          onTap: (){
                            var user = HealthGuardUser(EmailController.text.toString(),
                                FnameController.text.toString(),
                                MobileController.text.toString(),
                                Gender,
                                pickedDate,
                                PasswordController.text.toString(),
                                CpasswordController.text.toString()
                            );

                            if (user.is_validSignup()) {
                              var respond = user.save();
                              respond.then((value){

                                setState(() {
                                  server_respond = value;
                                  if(value['Error'] != null){
                                    has_errors = true;
                                  }
                                  else{
                                     setUser(value['email'], value['access_token'], value['refresh_token']);
                                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> HomePage()),(Route<dynamic> route)=> false);
                                  }
                                });
                              }).catchError((err){
                                server_respond = {
                                  'Error': 'Server Errors! try again later...'
                                };
                                setState((){
                                  has_errors = true;
                                });
                              });
                            }
                            else{
                              setState((){
                                has_errors = true;
                                server_respond = user.validateSignUp();
                              });
                            }

                          }
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

                      Material(
                        child: InkWell(
                          splashColor: Colors.red,
                          child: ButtonWidget(
                            title: 'Login',
                            hasBorder: true,
                          ),
                          onTap: (){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=> LoginPageGuider()),(Route<dynamic> route)=> false);
                          },
                        ),
                      ),


                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPageGuider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (context) => HomeModel(),
        child: SignUp()
    );
  }
}
