import 'dart:convert';

import 'package:health_guard/api_credentials.dart' as api_credentials;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser{
  String email;
  String fname ;
  String access_token;
  String refresh_token;

  Future<void> refresh() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var url = api_credentials.API_LINK + "/api/token/refresh/";
      var response = await http.post(url, body: {
        'grant_type': 'refresh_token',
        'email': this.email,
        'refresh_token': this.refresh_token,
        'client_id': api_credentials.CLIENT_ID,
        'client_secret': api_credentials.CLIENT_SECRET,
      });
      var val = await json.decode(response.body);
      if (val['Error'] == null) {
        this.refresh_token = val['refresh_token'];
        this.access_token = val['access_token'];
        pref.setString('access_token', val['access_token']);
        pref.setString('refresh_token', val['refresh_token']);
      }
    }
    catch(e){
    }
  }

}