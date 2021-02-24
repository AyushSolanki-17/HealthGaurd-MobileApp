import 'dart:async';

import '../Database.dart';

class Reminder{
  int id;
  String medname;
  String timings;
  Reminder({this.medname,this.timings, this.id});

  factory Reminder.fromMap(Map<String, dynamic> json) => new Reminder(
    id: json["id"],
    medname: json["medname"],
    timings: json["timings"],
  );

  Map<String, dynamic> toMap() => {
    "medname": medname,
    "timings": timings,
  };

}

class ReminderBloc {
  ReminderBloc() {
    getReminders();
  }
  final _reminderController = StreamController<dynamic>.broadcast();
  get reminder => _reminderController.stream;

  dispose() {
    _reminderController.close();
  }

  getReminders() async {
    _reminderController.sink.add(await DBProvider.db.getAllReminders());
  }

  add(Reminder reminder) async{
    var rm = await DBProvider.db.newReminder(reminder);
    await getReminders();
    return rm;
  }
}