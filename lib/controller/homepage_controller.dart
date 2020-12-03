import '../controller/myfirebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/homepage.dart';

class HomePageController 
{
  HomePageState state;

HomePageController(this.state);

void signOut()
{
  MyFirebase.signOut();
  Navigator.pop(state.context);
  Navigator.pop(state.context);
}
void getusers()async
{  

 /* await MyFirebase.readsubusers();
  Navigator.push(state.context,MaterialPageRoute(
     builder: (context) => ManagePage(state.user)),
  );*/
}
}