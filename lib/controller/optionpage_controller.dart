import 'dart:ffi';

import 'package:Project/model/players.dart';
import 'package:Project/model/user.dart';
import 'package:Project/view/gamepage.dart';
import 'package:Project/view/loginpage.dart';
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


  void PVP()
  {
    Record newrecord = new Record();
    newrecord.serialize();
    newrecord.gamemode = state.radioValue.toString();
    newrecord.player1 = state.user.uid;
    newrecord.ai = 'off';
    DateTime now = DateTime.now();
    newrecord.startdatetime = now.toString().substring(0,16);
  }


  void PCVPC()
  {
    Record newrecord = new Record();
    newrecord.serialize();
    newrecord.gamemode = state.radioValue.toString();
    newrecord.player1 = state.user.uid;
    newrecord.ai = 'on';
    DateTime now = DateTime.now();
    newrecord.startdatetime = now.toString().substring(0,16);
  }

  void ViewRecord() async
  {
    
      List<Record> allrecords = await MyFirebase.getRecords(state.user.uid);
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
      User user2 = await MyFirebase.readProfile(allrecords[i].player2);
      newplayer.player2f = user2.fname;
      newplayer.player2l = user2.lname;
      }


      players.add(newplayer);
      }
      print("dfdfdfdfdfd" + players[0].player1f.toString());
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
void deleteButton() async
{
  //sort descending order of deleteindices
  state.deleteIndices.sort((n1,n2){
     if (n1<n2) return 1;//asc = -1
     else if (n1==n2) return 0;
     else return -1;//asc = 1
  });
  //deleteIndices: [a,b,c,d]
for (var index in state.deleteIndices)
{
  try
{
  await MyFirebase.deleteProduct(state.records[index]);
  state.records.removeAt(index);
}
catch(e){
  print('BOOK DELETE ERROR: ' + e.toString());  
}

}
state.stateChanged((){
  state.deleteIndices = null;
});

}
}