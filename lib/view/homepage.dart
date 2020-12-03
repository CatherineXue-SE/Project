import '../controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/homepage_controller.dart';

class HomePage extends StatefulWidget
{
  final User user;
  HomePage(this.user);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState(user);
  }
  
}
class HomePageState extends State<HomePage>
{
  User user ;
  HomePageController controller;
  BuildContext context;
  HomePageState(this.user)
  {
    controller = HomePageController(this);
  }
  void stateChanged(Function fn)
  {
    setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this.context = context;
    return WillPopScope(
          onWillPop: (){return Future.value(false);},
          child: Scaffold(
        appBar: AppBar(
          title: Text('User Home'),
          actions: <Widget>[],),
          body: Text('${user.email} ${user.fname}'),
   drawer: Drawer
   (
       child: ListView
       (
         
         children: <Widget> [
           UserAccountsDrawerHeader(
             accountName: Text(user.fname),
             accountEmail: Text(user.email),
           ),
           
           ListTile(
             leading: Icon(Icons.exit_to_app),
             title: Text('Sign Out'),
             onTap: controller.signOut,
           ),
         ],
       ),
   ),
      ),
    );
  }
  
}