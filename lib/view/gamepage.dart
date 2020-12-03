import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../model/record.dart';

import '../controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/gamepage_controller.dart';

class GamePage extends StatefulWidget
{
  final Record record;
  GamePage(this.record);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GamePageState(record);
  }
  
}
class GamePageState extends State<GamePage>
{
  Record record; 
  GamePageController controller;
  BuildContext context;
      int endTime = DateTime.now().millisecondsSinceEpoch + 25 * 60 * 60;

      String img = "";
    var formKey = GlobalKey<FormState>();

  GamePageState(this.record)
  {
    controller = GamePageController(this);
  }

  void stateChanged(Function fn)
  {
    setState(fn);
  }
    AssetImage getImage(String value) {
    AssetImage cross = AssetImage("images/cross.jpg");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage edit = AssetImage("images/edit.png");

    switch (value) {
      case ("-"):
        return edit;
        break;
      case ('x'):
        return cross;
        break;
      case ('o'):
        return circle;
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this.context = context;
    AssetImage statusimage = getImage("");
     return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe", style: TextStyle(
          color: Colors.white,
        ),
        ),
      backgroundColor: Color(0xFF192A56),
      ),
      
       body: 
        Form(
        key: formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
         Expanded(
           
            child: GridView.builder(
              padding: EdgeInsets.all(5.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: int.parse(record.gamemode),
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemCount: record.finalboard.length ,
              itemBuilder: (context, i) => SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: MaterialButton(
                      onPressed: () => controller.playGame(i),
                      child: Image(
                        image: this.getImage(record.finalboard[i]),
                      ),
                    ),
                    ),
                  ),
            
          )
          ,
          Container(
           child: CountdownTimer(
            endTime: endTime,
             widgetBuilder: (_, CurrentRemainingTime time) {
                List<Widget> list = [];
              if(time == null)
              {
                record.winner = 'x';
                img = "You Lost!";    
                endTime = DateTime.now().millisecondsSinceEpoch + 100000000000;
                controller.updateRecord(record);
                 list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text('Time out'),
                  ],
                ));
                 return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list,
              
              );}
              else
              {
                if(record.gameid == null)
                {
                  return Text("${time.min}:${time.sec}",      style: TextStyle(fontSize: 30));
                }
                else
                {
                  return Text("");
                }
              }}
             )
           /*CountdownTimer(
            endTime: endTime,
            widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
              List<Widget> list = [];
              if(time == null)
              {
              list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text('Time out'),
                  ],
                ));
              }
              else
              {
  if(time.days != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_satisfied),
                    Text(time.days.toString()),
                  ],
                ));
              }
              if(time.hours != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_satisfied),
                    Text(time.hours.toString()),
                  ],
                ));
              }
              if(time.min != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_dissatisfied),
                    Text(time.min.toString()),
                  ],
                ));
              }
              if(time.sec != null) {
                list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_satisfied),
                    Text(time.sec.toString()),
                  ],
                ));
              }
              }
            
       
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list,
              
              );
                /*list.add(Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_dissatisfied),
                    Text(time.days.toString()),
                  ],
              
                )
                */
            },

                ),*/
          
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(img,style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          MaterialButton(
            color: Color(0xFF0A3D62),
            minWidth: 300.0,
            height: 85.0,
            child: Text(
              "Reset Game",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            onPressed: null,//
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(85.0),
            ),
          ),
          
        ],
      ),
        ),
    );
  }
  
}