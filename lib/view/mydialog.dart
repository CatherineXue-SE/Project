import 'package:flutter/material.dart';
class MyDialog
{
static void info({
  @required BuildContext context,
  @required String title,
  @required String message,
  @required Function action,})
{

  showDialog(
    context: context ,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title) ,
        content: Text(message),
        actions: <Widget>[
          RaisedButton(
            child:Text('ok',style: TextStyle(color: Colors.white)),
            onPressed: action,)
        ],
      );
    },


  );
}

static void showProgressBar(BuildContext context)
{
  showDialog(
    context: context,
    builder: (context) => Center(child: CircularProgressIndicator())
  );
}
static void popProgressBar(BuildContext context)
{
  Navigator.pop(context);
}
}