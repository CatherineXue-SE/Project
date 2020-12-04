
import 'dart:io';

import 'package:Project/view/aivaigamepage.dart';
import 'package:Project/view/editaccountpage.dart';

import '../model/players.dart';
import '../model/user.dart';
import '../view/gamepage.dart';
import '../view/loginpage.dart';
import '../view/p2pgamepage.dart';
import '../model/record.dart';
import '../view/recordpage.dart';
import '../view/optionpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myfirebase.dart';
class OptionPageController 
{
  OptionPageState state;
  OptionPageController(this.state);
    ServerSocket serversocket  ;
    Socket clientsocket;
      // ignore: non_constant_identifier_names
  void PVPC()
  {
    Record newrecord = new Record();
    newrecord.serialize();
    newrecord.gamemode = state.radioValue.toString();
    newrecord.player1 = state.user.uid;
    newrecord.player2 = 'PC';
    DateTime now = DateTime.now();
    newrecord.startdatetime = now.toString().substring(0,16);
    newrecord.ai = 'off';
    List<dynamic> newsteps = new List<dynamic>();
     for (int i=0;i<state.radioValue * state.radioValue;i++)
    {
    newsteps.add("-") ;
    }
    newrecord.finalboard = newsteps;
    newrecord.steps = new List<dynamic>();
  
     Navigator.push(state.context,MaterialPageRoute(
                builder: (context) => GamePage(newrecord),
              ));
  }


  void PVP() async
  {
    Record newrecord = new Record();
    newrecord.serialize();
    newrecord.gamemode = state.radioValue.toString();
    newrecord.player1 = state.user.uid;
    newrecord.player2 = 'RA3IAepKBxgWtIVoNQ6jOCEZnOq1';
    DateTime now = DateTime.now();
    newrecord.startdatetime = now.toString().substring(0,16);
    newrecord.ai = 'off';
    List<dynamic> newsteps = new List<dynamic>();
     for (int i=0;i<state.radioValue * state.radioValue;i++)
    {
    newsteps.add("-") ;
    }
    newrecord.finalboard = newsteps;
    newrecord.steps = new List<dynamic>();
    //startserver();
     Navigator.push(state.context,MaterialPageRoute(
                builder: (context) => P2PGamePage(newrecord),
              ));
          // Navigator.push(state.context,MaterialPageRoute(
       //         builder: (context) => P2P(),
         //     ));

   /* Record newrecord = new Record();
    newrecord.serialize();
    newrecord.gamemode = state.radioValue.toString();
    newrecord.player1 = state.user.uid;
    newrecord.ai = 'off';
    DateTime now = DateTime.now();
    newrecord.startdatetime = now.toString().substring(0,16);*/

  }
 

  void startserver() async {
    serversocket =
        await ServerSocket.bind('localhost', 3030, shared: true);
    print(serversocket);
    serversocket.listen(handleClient);
  }
    void handleClient(Socket client) {
    clientsocket = client;
    clientsocket.listen(
      (onData) {
        print(String.fromCharCodes(onData).trim());
      /*  setState(() {
          items.insert(
              0,
              MessageItem(clientSocket.remoteAddress.address,
                  String.fromCharCodes(onData).trim()));
        });*/
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

   state.stateChanged(() {
      clientsocket = null;
    });
  }
  void dataHandler(data){
      print(new String.fromCharCodes(data).trim());
      clientsocket.destroy();

}

void errorHandler(error, StackTrace trace){
   print(error);
      clientsocket.destroy();

}

void doneHandler(){     
   clientsocket.destroy();
}

  void PCVPC()
  {
    Record newrecord = new Record();
    newrecord.serialize();
    newrecord.gamemode = state.radioValue.toString();
    newrecord.player1 = state.user.uid;
    newrecord.player2 = state.user.uid;
    newrecord.ai = 'on';
    DateTime now = DateTime.now();
    newrecord.startdatetime = now.toString().substring(0,16);
      List<dynamic> newsteps = new List<dynamic>();
     for (int i=0;i<state.radioValue * state.radioValue;i++)
    {
    newsteps.add("-") ;
    }
    newrecord.finalboard = newsteps;
    newrecord.steps = new List<dynamic>();
     Navigator.push(state.context,MaterialPageRoute(
                builder: (context) => AIVAIGamePage(newrecord),));
  }

  void ViewRecord() async
  {
    
      List<Record> allrecords = new    List<Record> ();
      allrecords = await MyFirebase.getRecordList(state.user.uid);
      print(allrecords.length);
      List<Players> players = new List<Players>();
      for(int i=0;i<allrecords.length;i++)
      {
      User user1 = await MyFirebase.readProfile(allrecords[i].player1);
      Players newplayer = new Players();
      newplayer.gameid = allrecords[i].gameid;
      newplayer.player1f = user1.fname;
      newplayer.player1l = user1.lname;
      newplayer.player2f = "AI";
      newplayer.player2l = ".Local";
      if(allrecords[i].player2 != 'PC')
      {
        print(allrecords[i].gameid + "???");
      User user2 = await MyFirebase.readProfile(allrecords[i].player2);
      newplayer.player2f = user2.fname;
      newplayer.player2l = user2.lname;
      }
      
      players.add(newplayer);
      }
      await Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => RecordPage(state.user,allrecords,players),
));
  }
void onTabTapped(int index) {
      state.stateChanged(()
       {
      state.currentIndex = index;
          switch (index) {
          case 0:
           gotohomelist();
            break;
          case 1:
          print("1");
              
          break;
          case 2:
              print("2");
          break;
          case 3:
        /*  Navigator.push(state.context,MaterialPageRoute(
                builder: (context) => EditAccountPage(state.user),
              ));*/
              print("3");

          break;
  }       });

 }
 void editAccount()
 {
   Navigator.push(state.context,MaterialPageRoute(
                builder: (context) => EditAccountPage(state.user),
              ));
 }
void signOut()
{
  MyFirebase.signOut();
   Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => LoginPage()));
}
void addButton() async
{
  print("addButton called");
 /*Record b =  
 await Navigator
 .push(state.context, MaterialPageRoute(
    builder: (context) => OptionPage(state.user,null))
     );
     if (b!= null)
     {
       state.records.add(b);
       //new book stored in Firebase
     }
     else
     {
       //error occured
     }*/
}
void onTap(int index) async       
{
  /*
  if (state.deleteIndices == null)
  {//nevigate to BookPage
  
 Record b = await Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => ProductPage(state.user,state.products[index]),
  ));
  if (b!= null)
  {
    // update book is stored in firebase
    state.products[index] = b;
  }
  }
  else
  {
   if (state.deleteIndices.contains(index))
   {
     //tapped again -> deselect
    state.deleteIndices.remove(index);
    if (state.deleteIndices.length == 0)
    {
      // all deselect. delete mode quits
      state.deleteIndices = null;
    }
   }
    else
    {
      state.deleteIndices.add(index);
    }
    state.stateChanged((){});
 
  }
  
 */
} 
Future gotohomelist() async 
 {
   try
   {
/*List<Record> myrecords = await MyFirebase.getRecords(state.user.uid);
    Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => RecordPage(state.user, myrecords),
)); */
   }
   catch(e)
   {
     print("cannot read ++++++" + e.toString());
   }
  
 }
void longpress(int index)
{
  if (state.deleteIndices == null)
  {
    state.stateChanged((){
    state.deleteIndices = <int>[index];
    });
  }
}


}