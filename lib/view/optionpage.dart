import '../controller/optionpage_controller.dart';
import '../model/record.dart';
import '../model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class OptionPage extends StatefulWidget
{
  final User user;
  final List<Record> records;
  
  OptionPage(this.user,this.records);
  @override
  State<StatefulWidget> createState() {
    return OptionPageState(user,records);
  }
}
class OptionPageState extends State<OptionPage>
{
  User user ;
  OptionPageController controller;
  BuildContext context;
  int currentIndex = 1;
  List<int> deleteIndices;
  Widget child;
  List<Record> records;
  int radioValue = 3 ; 

  OptionPageState(this.user,this.records)
  {
    controller = OptionPageController(this);
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
          actions: deleteIndices == null ? null : <Widget>[
            FlatButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: controller.deleteButton,
            ),
          ],),
   drawer: Drawer
   (
       child: ListView
       (
         
         children: <Widget> [
           UserAccountsDrawerHeader(
             accountName: Text(user.fname),
             accountEmail: Text(user.email),
             currentAccountPicture: CachedNetworkImage(
              imageUrl: user.photourl == null ? '' : user.photourl ,
              placeholder: (context,url) => CircularProgressIndicator(),
              errorWidget: (context,url,error) =>
              Icon(Icons.error_outline),
             ),
         
           ),
          
               ListTile(
             leading: Icon(Icons.settings),
             title: Text('Profile'),
             onTap: null,//() => controller.editAccount(),
           ),
          ListTile(
             leading: Icon(Icons.people),
             title: Text('View Records'),
             onTap: null,//controller.sharedWithMeMenu,
           ),
           ListTile(
             leading: Icon(Icons.exit_to_app),
             title: Text('Sign Out'),
             onTap: controller.signOut,
           ),
         ],
       ),
   ),
    bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: controller.onTabTapped,//(newIndex) => setState(() => currentIndex = newIndex),
         currentIndex: currentIndex, 
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('Home'),
         ),
          BottomNavigationBarItem(
           icon: Icon(Icons.flag),
           title: Text('Barter')
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.mail),
           title: new Text('Messages'),
         ),     
          BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile'),
         )
       ],
     ),
    body:

    new Container(
       width: 1000,
       height: 500,
    child: Padding(
       padding: EdgeInsets.only(left: 2.0, right: 2.0, top: 150.0),
         child: new Column(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
          Expanded(
            
             child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 3,
                          groupValue: radioValue,
                          onChanged:  (int value) {
                            setState(() {
                              radioValue = value;
                            });
                        },
                      ),//_handleRadioValueChange1,
                                              
                        new Text(
                          '3x3',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 4,
                          groupValue: radioValue,
                          onChanged: (int value) {
                            setState(() {
                              radioValue = value;
                            });
                        },
                        ),
                        new Text(
                          '4x4',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        
                      ],
                    
              
               
             ),
             //flex: 2,
           ),
           Expanded(
             child: Padding(
               padding: EdgeInsets.only( bottom: 10.0),
               child: Container(
                child: new RaisedButton(
                 child: new Text("1 vs PC"),
                 textColor: Colors.white,
                 color: Colors.blue,
                 onPressed: controller.PVPC,
                 shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(10.0)),
               )),
             ),
             //flex: 2,
           ),
           Expanded(
             child: Padding(
               padding: EdgeInsets.only(bottom: 10.0),
               child: Container(
                   child: new RaisedButton(
                 child: new Text("Pair with other"),
                 textColor: Colors.white,
                 color: Colors.blue,
                 onPressed: () => Navigator.pop(context),
                 shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(10.0)),
               )),
             ),
            // flex: 2,
           ),
        
           Expanded(
             child: Padding(
               padding: EdgeInsets.only(bottom: 2),
               child: Container(
                   child: new RaisedButton(
                 child: new Text("PC vs PC"),
                 textColor: Colors.white,
                 color: Colors.blue,
                 onPressed: () => Navigator.pop(context),
                 shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(10.0)),
               )),
             ),
             //flex: 2,
           ),
            Expanded(
             child: Padding(
               padding: EdgeInsets.only(top: 2),
               child: Container(
                   child: new RaisedButton(
                 child: new Text("View Records"),
                 textColor: Colors.white,
                 color: Colors.blueGrey,
                 onPressed: () => controller.ViewRecord(),
                 shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(10.0)),
               )),
             ),
             //flex: 2,
           ),
         ],
       ),
     ),
     ),
    

    
     
    ));
  }
  
}
