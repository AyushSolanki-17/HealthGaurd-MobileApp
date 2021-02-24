import 'package:flutter/gestures.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_guard/medicine_reminder/TimeZone.dart';
import 'dart:io' show File, Platform;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';



class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final timeZone = TimeZone();
  var androidChannelSpecifics = AndroidNotificationDetails(
    "CHANNEL_ID_05",
    "CHANNEL_NAME_REG_NOTIF",
    "CHANNEL_DESC_TO_PROVIDE_NOTIFS",
    importance: Importance.max,
    priority: Priority.high,
  );
  var iosChannelSpecifics = IOSNotificationDetails();

  NotificationDetails getPlatformChannelSpecifics(){
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics,
        iOS: iosChannelSpecifics);
    return platformChannelSpecifics;
  }



  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  var initializationSettings;

  NotificationPlugin._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();

  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('notif_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification =
            ReceivedNotification(id, title, body, payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(alert: true, sound: true, badge: true);
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  setListnerForLowerVersions(Function onNotificationInLowerVersion) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersion(receivedNotification);
    });
  }

  Future<void> showNotification() async{
    var androidChannelSpecifics = AndroidNotificationDetails(
        "CHANNEL_ID_05",
        "CHANNEL_NAME_REG_NOTIF",
        "CHANNEL_DESC_TO_PROVIDE_NOTIFS",
        importance: Importance.max,
        priority: Priority.high,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics,
        iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, "Hello", "This is body",
        platformChannelSpecifics, payload: "Test Payload");
  }



  Future<void> scheduleDailyNotification(int id,String notificationDesc,int hours, int minutes) async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'MedicineReminder',
        notificationDesc,
        await _nextInstanceOfTime(hours,minutes),
        getPlatformChannelSpecifics(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<tz.TZDateTime> _nextInstanceOfTime(int hours, int minutes) async{
    String timeZoneName = await timeZone.getTimeZoneName();
    final location = await timeZone.getLocation(timeZoneName);
    DateTime currentDateTime = new DateTime.now();
    DateTime scheduledDateTime = new DateTime(
        currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      hours,
      minutes
    );
    if(scheduledDateTime.isBefore(currentDateTime)){
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }
    final scheduledDate = tz.TZDateTime.from(scheduledDateTime, location);
    return scheduledDate;
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(this.id, this.title, this.body, this.payload);
}
