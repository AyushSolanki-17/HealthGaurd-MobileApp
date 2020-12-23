//this file contains the question box and its answer choices`+
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/globals.dart';

class QuestionBox extends StatefulWidget{
  final String question;
  final Map<String,int> answers;
  final Function callback;
  QuestionBox({Key key, this.question, this.answers, this.callback}) : super(key: key);

  @override
  _QuestionBoxState createState() => _QuestionBoxState(callback: this.callback);
}

class _QuestionBoxState extends State<QuestionBox> {

  Function callback;
  Map<String,bool> answer_list={};
  int vl=0;
  _QuestionBoxState({this.callback});


  @override
  void initState(){
    super.initState();
    for(String x in widget.answers.keys){
      answer_list[x] = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Global.redAccent, width: 1.5, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(15.0),
        color: Global.lightBlue
      ),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Align(alignment:Alignment.centerLeft,child: Text('${widget.question}',style: TextStyle(color: Global.white, fontSize: 20.0),)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  color: Global.seaGreen,
                ),
            ),
            SizedBox(height:10.0),
            for(var i in widget.answers.keys)FlatButton(child: Align(alignment:Alignment.center,
                child: Text('${i}', style: TextStyle(
                  color: answer_list[i]==null?Global.black:answer_list[i]?Global.white:Global.black
                ),),
            ),
            splashColor: Global.seaGreen,
            color: answer_list[i]==null?Global.white:answer_list[i]?Global.mediumGreen:Global.white,
            padding: EdgeInsets.symmetric(vertical: 10.0),
              onPressed: ()=>{
              setState((){
                for(var key in answer_list.keys){
                  answer_list[key] = false;
                }
                answer_list[i] = true;
                vl = widget.answers[i];
                this.callback(widget.answers[i]);
              })
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(2.5),
                      bottomLeft: Radius.circular(2.5), bottomRight: Radius.circular(25.0)),
                  side: BorderSide(color: Global.seaGreen)
              ),
            )
          ],
        ),
      ),
    );
  }
}