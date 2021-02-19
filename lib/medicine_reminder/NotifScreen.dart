import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/medicine_reminder/NotificationPlugin.dart';

class NotifScreen extends StatefulWidget{
  @override
  _NotifScreenState createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {

  @override
  void initState() {
    // TODO: implement initState
    notificationPlugin.setListnerForLowerVersions(onNotificationInLowerVerions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Send Notif'),
            onPressed: ()async{
              await notificationPlugin.scheduleDailyTenAMNotification();
            },
          ),
        ),
      ),
    );
  }

  onNotificationInLowerVerions(ReceivedNotification receivedNotification){}
  onNotificationClick(String payload){}
}