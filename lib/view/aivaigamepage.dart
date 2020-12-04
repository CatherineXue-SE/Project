import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../model/record.dart';

import '../controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/aivaigamepage_controller.dart';

class AIVAIGamePage extends StatefulWidget {
  final Record record;
  AIVAIGamePage(this.record);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AIVAIGamePageState(record);
  }
}

class AIVAIGamePageState extends State<AIVAIGamePage> {
  Record record;
  AIVAIGamePageController controller;
  BuildContext context;

  String img = "";
  var formKey = GlobalKey<FormState>();

  AIVAIGamePageState(this.record) {
    controller = AIVAIGamePageController(this);
  }

void initState() {
    super.initState();
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
    AssetImage statusimage = getImage("");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF192A56),
      ),
      body: Form(
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
                    onPressed: null,//() => controller.playGame(i),
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
            ),
           
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                img,
                style: TextStyle(
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
                "Play AI",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              onPressed: controller.playGame, //
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(85.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
