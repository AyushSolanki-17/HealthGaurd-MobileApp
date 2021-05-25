import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/Database.dart';
import 'package:health_guard/Models/Reminder.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/medicine_reminder/NotificationPlugin.dart';

class AddReminder extends StatefulWidget {
  final ReminderBloc bloc;

  const AddReminder({Key key, this.bloc}) : super(key: key);


  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  bool morning = false;
  bool afternoon = false;
  bool night = false;
  var MedNameController = TextEditingController();
  List<String> timings = List<String>();
  Reminder reminder = Reminder();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationPlugin.setListnerForLowerVersions(onNotificationInLowerVerions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Global.white,
        appBar: AppBar(
          backgroundColor: Global.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Global.blue,
              size: 30,
            ),
          ),
          title: Text(
            'Reminder',
            style: TextStyle(
              color: Global.blue,
              fontSize: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Medicine name',
                style: TextStyle(
                  color: Global.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Global.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Global.gray,
                      blurRadius: 10,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: MedNameController,
                  style: TextStyle(
                    color: Global.mediumGreen,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter medicine name',
                      hintStyle: TextStyle(
                        color: Global.mediumGreen,
                      )),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'When to take?',
                style: TextStyle(
                  color: Global.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          try{
                            morning = !morning;
                            morning?timings.add("morning"):timings.remove("morning");
                          }
                          catch(e){}
                        });
                      },
                      child: TimeCard(
                        icon: Icons.wb_sunny_outlined,
                        time: 'Morning',
                        isSelected: morning,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          try{
                            afternoon = !afternoon;
                            afternoon?timings.add("afternoon"):timings.remove("afternoon");
                          }
                          catch(e){}

                        });
                      },
                      child: TimeCard(
                        icon: Icons.wb_sunny_rounded,
                        time: 'Afternoon',
                        isSelected: afternoon,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          try {
                            //print(night);
                            night = !night;
                            night ? timings.add("night") : timings.remove("night");
                          }
                          catch(e){
                            print(e);
                          }
                        });
                      },
                      child: TimeCard(
                        icon: Icons.star_rate_outlined,
                        time: 'Night',
                        isSelected: night,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlatButton(
                  onPressed: () async{
                    setState(() {
                      reminder.medname = MedNameController.text;
                      reminder.timings = timings.join(", ");
                    });
                    var rs = await widget.bloc.add(reminder);
                    await dispatchNotifications(rs);
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
                  color: Global.mediumGreen,
                  splashColor: Global.mediumGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Global.blue,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Set Reminder',
                        style: TextStyle(
                          color: Global.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  onNotificationInLowerVerions(ReceivedNotification receivedNotification){}
  onNotificationClick(String payload){}
  dispatchNotifications(int rid) async{
    Reminder r = await DBProvider.db.getSpecificReminders(rid);
    for(var rem in r.timings.split(", ")){
      String rl = rem.substring(0,1).toLowerCase();
      if(rl == "m"){
        await notificationPlugin.scheduleDailyNotification(int.parse(r.id.toString()+"01"),r.medname, 10, 0);
      }
      else if(rl == "a"){
        await notificationPlugin.scheduleDailyNotification(int.parse(r.id.toString()+"02"),r.medname, 14, 0);
      }
      else if(rl == "n"){
        await notificationPlugin.scheduleDailyNotification(int.parse(r.id.toString()+"03"),r.medname, 21, 30);
      }
    }
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({
    Key key,
    this.icon,
    this.time,
    this.isSelected,
  }) : super(key: key);
  final IconData icon;
  final String time;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: 105,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Global.mediumGreen : Global.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Global.gray,
            blurRadius: 10,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Global.white : Global.mediumGreen,
            size: 40,
          ),
          SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              color: isSelected ? Global.white : Global.mediumGreen,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

}