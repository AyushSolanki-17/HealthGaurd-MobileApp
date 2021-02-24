import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:health_guard/api_credentials.dart' as api_credentials;

class HealthGuardUser{
  final String email;
  final String fname;
  final String mobile;
  final String gender;
  final DateTime dob;
  final String password;
  final String cfpassword;

  final DateFormat dob_formatter = DateFormat('yyyy-MM-dd');
  bool is_valid = false;

  HealthGuardUser(this.email, this.fname, this.mobile, this.gender, this.dob, this.password, this.cfpassword);
  HealthGuardUser.LogUserData(this.email,this.password):fname='',dob=null,gender='',cfpassword='',mobile='';

  Future<Map<String,dynamic>> save() async{

    try{
      var url = api_credentials.API_LINK+"/api/register/";
      var response = await http.post(url, body: {
        'grant_type': 'password',
        'email': email,
        'fname': fname,
        'mobile': mobile,
        'gender': gender,
        'dob': dob_formatter.format(dob).toString(),
        'password': password,
        'password2': cfpassword,
        'client_id': api_credentials.CLIENT_ID,
        'client_secret': api_credentials.CLIENT_SECRET,
      });
      return await json.decode(response.body);
    }
    catch(e){
      print(e);
      return {
        'Error':'Network Request Error'
      };
    }
  }
  Future<Map<String,dynamic>> login() async {
    try{
      var url = api_credentials.API_LINK+"/api/token/";
      var response = await http.post(url, body: {
        'grant_type': 'password',
        'email': email,
        'password': password,
        'client_id': api_credentials.CLIENT_ID,
        'client_secret': api_credentials.CLIENT_SECRET,
      });
      var val = await json.decode(response.body);
      if (val['Error']!=null){
        return {
          'Error':'Server Error'
        };
      }
      return val;
    }
    catch(e){
      print(e);
      return {
        'Error':'Network Request Error'
      };
    }
  }

  bool is_validSignup(){
    var res = validateSignUp();
    if(res['ValidationStatus']==true){
      return true;
    }
    return false;
  }

  bool is_validLogin(){
    var res = validateLogin();
    if(res['ValidationStatus']==true){
      return true;
    }
    return false;
  }


  Map<String,dynamic> validateSignUp(){
    try{
      if(email!=''  && fname!=''  && mobile!='' && gender!='' && password!='' && dob!=null &&  cfpassword!=''){
        if(cfpassword!=password){
          return{
            'Error': 'Password Fields does not match..!!',
            'ValidationStatus':false
          };
        }
        else{
          if(fname.length >=3){
            if(password.length >=8 && cfpassword.length >=8){
              DateTime currentDate = DateTime.now();
              DateTime adultDate = DateTime(dob.year+10,dob.month,dob.day);
              if(currentDate.isAfter(adultDate) || (currentDate.day == adultDate.day && currentDate.month == adultDate.month && currentDate.year == adultDate.year)){
                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);
                if (regex.hasMatch(email)){
                  Pattern pattern = r'^[6-9]\d{9}$';
                  RegExp regex = new RegExp(pattern);
                  if (regex.hasMatch(mobile)){
                    return {
                      'ValidationStatus':true
                    };
                  }
                  else{
                    return {
                      'Error': 'Mobile Number is not valid..!!',
                      'ValidationStatus':false
                    };
                  }
                }
                else{
                  return {
                    'Error': 'Email Address is not valid..!!',
                    'ValidationStatus':false
                  };
                }
              }
              else{
                return {
                  'Error': 'You Must be 10 years old to use this app..!!',
                  'ValidationStatus':false
                };
              }
            }
            else{
              return {
                'Error': 'Password must be atleast 8 characters',
                'ValidationStatus':false
              };
            }
          }
          else{
            return {
              'Error': 'Full name must be atleast 3 letters..!!',
              'ValidationStatus':false
            };
          }
        }
      }
      else{
        return {
          'Error': 'All fields are required..!!',
          'ValidationStatus':false
        };
      }
    }
    catch(e){
      return {
        'Error': 'All fields are required..!!',
        'ValidationStatus':false
      };
    }
  }

  Map<String,dynamic> validateLogin(){
    try {
      if (email != '' && password != '') {
        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (regex.hasMatch(email)) {
          return {
            'ValidationStatus': true
          };
        }
        else {
          return {
            'Error': 'Enter a valid email..!!',
            'ValidationStatus': false
          };
        }
      }
      else {
        return {
          'Error': 'All fields are required..!!',
          'ValidationStatus': false
        };
      }
    }
    catch(e){
      return {
        'Error': 'All fields are required..!!',
        'ValidationStatus': false
      };
    }
  }

}


