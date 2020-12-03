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
  Record record;git 
  GamePageController controller;
  BuildContext context;
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