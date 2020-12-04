import 'dart:io';

import '../controller/p2pgamepage_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../model/record.dart';

import '../controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class P2PGamePage extends StatefulWidget
{
  final Record record;
  P2PGamePage(this.record);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return P2PGamePageState(record);
  }
  
}
class P2PGamePageState extends State<P2PGamePage>
{
  Record record; 
  P2PGamePageController controller;
  BuildContext context;
  int endTime = DateTime.now().millisecondsSinceEpoch + 25 * 60 * 60;
    ServerSocket serversocket  ;
    Socket clientsocket;
      String img = "";

    var formKey = GlobalKey<FormState>();
  P2PGamePageState(this.record)
  {
    controller = P2PGamePageController(this);
  }

  void stateChanged(Function fn)
  {
if(mounted) {
      super.setState(fn);
    }  }
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
                startserver();

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
                padding: EdgeInsets.all(0.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: int.parse(record.gamemode),
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0),
                itemCount: record.finalboard.length,
                itemBuilder: (context, i) => SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: FlatButton(
                    onPressed: () => controller.playGame(i),
                    color: Colors.white,
                    child:
                        //Image(image: this.getImage(record.finalboard[i]),
                        Text(record.finalboard[i],
                            style: TextStyle(fontSize: 100.0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Colors.black),
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
  void startserver() async {
    serversocket =
        await ServerSocket.bind('localhost', 3030, shared: true);
    //print(serversocket);
    serversocket.listen(handleClient);
  }
    void handleClient(Socket client) {
    clientsocket = client;
    clientsocket.listen(
      (onData) {
          print("253" + String.fromCharCodes(onData).trim());
      

          print( record.finalboard.toString());
       stateChanged(() {
            int z = int.parse(String.fromCharCodes(onData).trim().split('-')[0]);
            String playernow = String.fromCharCodes(onData).trim().split('-')[1];
            print(String.fromCharCodes(onData).trim());
            record.steps.add(z.toString()+ '-x');

           record.finalboard[z] = 'x';
            controller.checkwinlost(); 
             // MessageItem(clientSocket.remoteAddress.address,String.fromCharCodes(onData).trim()););
        });
      },
      onError: (e) {
        print(e.toString());
        disconnectClient();
      },
      onDone: () {
        print("Connection has terminated.");
        disconnectClient();
      },
    );
  
  }

    void disconnectClient() {
    if (clientsocket != null) {
      clientsocket.close();
      clientsocket.destroy();
    }

   stateChanged(() {
      clientsocket = null;
    });
  }
  void dataHandler(data){
        
        print( "284 + " + new String.fromCharCodes(data).trim());
       /* int a =int.parse(String.fromCharCodes(data).trim().split('-')[0]);
        print(a);
        stateChanged((){
       record.finalboard[a+1] = 'x';
          
        });*/
            clientsocket.destroy();

}

void errorHandler(error, StackTrace trace){
   print(error);
      clientsocket.destroy();

}

void doneHandler(){
              controller.checkwinlost(); 

   clientsocket.destroy();
}

}