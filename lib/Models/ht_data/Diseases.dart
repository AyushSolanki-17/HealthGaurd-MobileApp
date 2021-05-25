import 'dart:convert';
import 'package:health_guard/Models/CurrentUser.dart';
import 'package:health_guard/api_credentials.dart' as api_credentials;
import 'package:flutter/material.dart';
import 'package:health_guard/main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> diseaseRequest(cu,model,dname) async{
  try{
    String symptoms = jsonEncode(model);
    var url = api_credentials.API_LINK+"/api/tests/"+dname+"/";
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    var response = await http.post(url, body: {
      'grant_type': 'password',
      'user': cu.email,
      'access_token': cu.access_token,
      'date': date,
      'symptoms': symptoms,
      'client_id': api_credentials.CLIENT_ID,
      'client_secret': api_credentials.CLIENT_SECRET,
    });
    var val = await json.decode(response.body);
    if(val['Error']!=null){
      return {
        'Error':val['Error']
      };
    }
    return val;
  }
  catch(e){
    print(e);
    return {
      'Error': 'Network Requst Error'
    };
}
}


class Dengue {
  CurrentUser cu;
  int fever;
  int headache;
  int rashes;
  int nausea_vomiting;
  int eyepain;
  int musclepain;
  int jointpain;
  int loss_of_appetite;
  int fatigue;
  int bleeding;
  int days;

  bool is_valid(){
    if (this.fever != null && this.headache != null && this.rashes != null && this.nausea_vomiting != null && this.eyepain != null && this.musclepain != null
        && this.jointpain != null && this.loss_of_appetite != null && this.fatigue != null && this.bleeding != null && this.days != null){
      return true;
    }
    else{
      return false;
    }
  }

  Future<Map<String, dynamic>> check() async {
    Map<String, dynamic> model = {
      'fever': this.fever,
      'headache': this.headache,
      'nvom': this.nausea_vomiting,
      'rashes': this.rashes,
      'musclepain': this.musclepain,
      'jointpain': this.jointpain,
      'eyepain': this.eyepain,
      'fatigue': this.fatigue,
      'loa': this.loss_of_appetite,
      'bleeding': this.bleeding,
      'days': this.days,
    };
    var res = await diseaseRequest(cu, model, "dengue");
    return res;
  }


}


class Chikungunya{
  CurrentUser cu;
  int fever;
  int headache;
  int rashes;
  int jointpain;
  int musclepain;
  int fatigue;
  int swelling;
  int chronic;
  int days;

  bool is_valid(){
    if (this.fever != null && this.headache != null && this.rashes != null && this.musclepain != null
        && this.jointpain != null && this.swelling != null && this.fatigue != null && this.chronic != null && this.days != null){
      return true;
    }
    else{
      return false;
    }
  }
  Future<Map<String, dynamic>> check() async {
    Map<String, dynamic> model = {
      'fever': this.fever,
      'headache': this.headache,
      'rashes': this.rashes,
      'musclepain': this.musclepain,
      'jointpain': this.jointpain,
      'swelling': this.swelling,
      'fatigue': this.fatigue,
      'chronic': this.chronic,
      'days': this.days,
    };
    var res = await diseaseRequest(cu, model, "chikungunya");
    return res;

  }
}


class General{
  CurrentUser cu;
  int fever;
  int rashes;
  int shivering;
  int jointpain;
  int vomiting;
  int cough;
  int bleeding;
  int swelling;
  int respiratory;
  int lossofsmell;
  int sorethroat;
  int days;

  bool is_valid(){
    if (this.fever != null && this.vomiting != null && this.rashes != null && this.cough != null
        && this.bleeding != null && this.lossofsmell != null && this.shivering != null
        && this.jointpain != null && this.swelling != null && this.respiratory != null && this.days != null){
      return true;
    }
    else{
      return false;
    }
  }
  Future<Map<String, dynamic>> check() async {
    Map<String, dynamic> model = {
      'fever': this.fever,
      'shivering': this.shivering,
      'rashes': this.rashes,
      'vomiting': this.vomiting,
      'lossofsmell': this.lossofsmell,
      'bleeding': this.bleeding,
      'jointpain': this.jointpain,
      'swelling': this.swelling,
      'cough': this.cough,
      'respiratory': this.respiratory,
      'sorethroat': this.sorethroat,
      'days': this.days,
    };
    var res = await diseaseRequest(cu, model, "general");
    return res;

  }
}


class Covid{
  CurrentUser cu;
  int fever;
  int cough;
  int respiratory;
  int heartrate;
  int lossofsmell;
  int pain;
  int chronic;
  int days;

  bool is_valid(){
    if (this.fever != null && this.lossofsmell != null && this.cough != null && this.respiratory != null
        && this.pain != null && this.heartrate != null && this.chronic != null && this.days != null){
      return true;
    }
    else{
      return false;
    }
  }
  Future<Map<String, dynamic>> check() async {
    Map<String, dynamic> model = {
      'fever': this.fever,
      'lossofsmell': this.lossofsmell,
      'cough': this.cough,
      'heartrate': this.heartrate,
      'pain': this.pain,
      'respiratory': this.respiratory,
      'chronic': this.chronic,
      'days': this.days,
    };
    var res = await diseaseRequest(cu, model, "covid");
    return res;

  }
}


class Malaria{
  CurrentUser cu;
  int fever;
  int headache;
  int shivering;
  int vomitting;
  int cough;
  int fastheartrate;
  int respiratory;
  int fatigue;
  int chronic;
  int days;

  bool is_valid(){
    if (this.fever != null && this.headache != null && this.shivering != null && this.fatigue != null && this.vomitting != null
        && this.cough != null && this.respiratory != null && this.fastheartrate != null && this.chronic != null && this.days != null){
      return true;
    }
    else{
      return false;
    }
  }
  Future<Map<String, dynamic>> check() async {
    Map<String, dynamic> model = {
      'fever': this.fever,
      'headache': this.headache,
      'respiratory': this.respiratory,
      'fastheartrate': this.fastheartrate,
      'shivering': this.shivering,
      'vomiting': this.vomitting,
      'cough': this.cough,
      'fatigue': this.fatigue,
      'chronic': this.chronic,
      'days': this.days,
    };
    var res = await diseaseRequest(cu, model, "malaria");
    return res;
  }
}
