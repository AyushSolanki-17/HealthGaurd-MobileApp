import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/Database.dart';
import 'package:health_guard/Models/Reminder.dart';
import 'package:health_guard/globals.dart';
import 'package:health_guard/medicine_reminder/AddReminderScreen.dart';

class ReminderScreen extends StatefulWidget {
  final ReminderBloc bloc = ReminderBloc();
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReminderHeader(context),
      body: Container(
        child: Column(
            children:[ReminderList(bloc: widget.bloc,)]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddReminder(bloc: widget.bloc,)));
        },
        backgroundColor: Global.mediumGreen,
        label: Text(
          'ADD Reminder',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

AppBar ReminderHeader(context) {
  return AppBar(
    backgroundColor: Global.mediumGreen,
    elevation: 0.0,
    centerTitle: true,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios_outlined,
        color: Global.white,
        size: 30,
      ),
    ),
    title: Text(
      'Medicine Reminders',
      style: TextStyle(
        color: Global.white,
        fontSize: 25,
      ),
    ),
  );
}

class ReminderList extends StatefulWidget {
  final ReminderBloc bloc;

  const ReminderList({Key key, this.bloc}) : super(key: key);
  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 25.0),
          child: StreamBuilder<dynamic>(
            stream: widget.bloc.reminder,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData){
                return Column(
                  children: [
                    for(var reminder in snapshot.data)ReminderListBox(reminderText: reminder.medname,timings: reminder.timings,)
                  ],
                );
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }

            }
          ),
    ));
  }
}


class ReminderListBox extends StatefulWidget{
  final String reminderText;
  final String timings;

  const ReminderListBox({Key key, this.reminderText, this.timings}) : super(key: key);

  @override
  _ReminderListBoxState createState() => _ReminderListBoxState();
}

class _ReminderListBoxState extends State<ReminderListBox> {
  bool st = false;
  @override
  Widget build(BuildContext context) {
    var timeList = widget.timings.split(", ");
    const IconData stars_rounded = IconData(0xf490, fontFamily: 'MaterialIcons');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            child:Container(
              padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
              margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.reminderText,textAlign: TextAlign.start,),
                  Row(children: [for(var li in timeList)li.substring(0,1)=="m"? Icon(stars_rounded,color: Global.yellow,):li.substring(0,1)=="a"?Icon(stars_rounded,color: Global.redAccent,):Icon(stars_rounded,color: Global.darkblue1,)],),
                ],
              ),
              color: this.st?Global.seaGreen:Global.lightblue,
              width: MediaQuery.of(context).size.width * 0.75,
        ),
          onLongPress: (){
              setState(() {
                this.st?this.st=false:this.st=true;
              });
            },
        ),
      ],
    );
  }
}