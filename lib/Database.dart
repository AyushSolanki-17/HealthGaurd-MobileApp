import 'dart:async';
import 'dart:io';

import 'package:health_guard/Models/Reminder.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "HGDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Reminders (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,medname TEXT NOT NULL,timings TEXT NOT NULL);");
        });
  }
  newReminder(Reminder newReminder) async {
    final db = await database;
    var res = await db.insert("Reminders", newReminder.toMap());
    return res;
  }
  getSpecificReminders(int id)async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Reminders WHERE id="+id.toString());
    var list =
    res.isNotEmpty ? res.toList().map((c) => Reminder.fromMap(c)) : null;
    return list.first;
  }
  getAllReminders() async {
    final db = await database;
    var res = await db.query("Reminders");
    List<Reminder> list =
    res.isNotEmpty ? res.map((c) => Reminder.fromMap(c)).toList() : [];
    return list;
  }
}