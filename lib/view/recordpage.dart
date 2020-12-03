import 'package:Project/model/players.dart';

import '../controller/recordpage_controller.dart';

import '../model/record.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/user.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget
{
  final User user;
  final List<Record> products;
  final List<Players> players;
  
  RecordPage(this.user,this.products,this.players);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RecordPageState(user,products,players);
  }
}
class RecordPageState extends State<RecordPage>
{
  User user ;
  RecordPageController controller;
  BuildContext context;
  int currentIndex = 1;
  List<int> deleteIndices;
  Widget child;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String player1;
  String player2;
  List<Record> records;
   List<Players> players;
  RecordPageState(this.user,this.records,this.players)
  {
    controller = RecordPageController(this);
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
          //onWillPop: (){return Future.value(false);},
        onWillPop: () {  },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Record'),   
                       actions:  <Widget>[
            FlatButton.icon(
              label: Text('sort'),
              icon: Icon(Icons.sort),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),//controller.deleteButton,
            ),
          ],     
            //leading: new Container(),  
          ),
          drawer: Drawer(
               child: ListView
       (
                  children: <Widget> [
              ListTile(
             leading: Icon(Icons.calendar_today),
             title: Text('latest to oldest'),
             onTap: null,//controller.pricelowtohigh,
           ),
            ListTile(
             leading: Icon(Icons.calendar_today),
             title: Text('oldest to latest'),
             onTap: null,//controller.pricehightolow,
           ),
            ListTile(
             leading: Icon(Icons.backspace),
             title: Text('back to main page'),
             onTap: controller.gotohomepage,
           ),
           
          
                  ]
       ),
            ),

     body: 

     Container(
        child: Column(
          children: <Widget>[
            Container(
                  // width: 380,
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                      // controller.filterSearchResults(value);
                      },
                      //controller: controller.editingController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  
                  ),
            ),
                /* IconButton(
                  icon: Icon(Icons.sort), 
                  onPressed: () {},),*/
           /* Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                     controller.filterSearchResults(value);
                    },
                    //controller: controller.editingController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  ),
                
                ),
                  IconButton(
                  icon: Icon(Icons.sort), 
                  onPressed: () {},),
              ],
            ),*/

            Expanded(
              child: ListView.separated(
           separatorBuilder: (context, index) {
            return Divider();
            },
                shrinkWrap: true,
          itemCount: records.length,
          itemBuilder: (BuildContext context, int index){
              return Container(
            padding: EdgeInsets.all(7.0),
                 color: Colors.blue[200],

              //color: deleteIndices != null && deleteIndices.contains(index)?
               // Colors.cyan[200] : Colors.white,
                     child: ListTile(
                  leading: 
                  (records[index].player1 == user.uid && records[index].winner == 'o')|| (records[index].player2 == user.uid && records[index].winner == 'x')?
                  Icon(Icons.circle,color: Colors.green):Icon(Icons.circle,color: Colors.red),
                  title: Text((index+1).toString() + ': ' + records[index].startdatetime.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     // Text(controller.getplayername(index).toString()),
                    players[index].player1f == null ? Text("Player 1: " + 'unknown') : Text("Player 1: " + players[index].player1f + '.' +  players[index].player1l ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent)),
                    players[index].player2f == null ? Text("Player 2: " + 'unknown') : Text("Player 2: " + players[index].player2f + '.' +  players[index].player2l,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)),
                    ],
                  ),
                       
                    trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              IconButton(
                icon: Icon(
                  Icons.view_compact,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {
                  //   _onDeleteItemPressed(index);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.replay,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () => controller.gotoreplaypage(records[index]),
              ),
            ],
          ),
                  onTap: null,//()=>controller.onTap(index),
                   onLongPress:(){},// () => controller.longpress(index),
              ),);
                },
              ),
            ),
          ],
        ),
      ),
      
      /*  ListView.separated(
           separatorBuilder: (context, index) {
            return Divider();
            },
          itemCount: records.length,
          itemBuilder: (BuildContext context, int index) {
           return Container(

                        child: Container(
                  padding: EdgeInsets.all(7.0),
                  color: Colors.blue[200],
                  child: ListTile(
                  leading: (records[index].player1 == user.uid && records[index].winner == 'o')|| (records[index].player2 == user.uid && records[index].winner == 'x')?
                  Icon(Icons.circle,color: Colors.green):Icon(Icons.circle,color: Colors.red),
                  /*CachedNetworkImage(
                    imageUrl: products[index].photourls.length < 1  ? "" : products[index].photourls[0].toString(),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context,url,error) => Icon(Icons.error_outline),        
                  ),*/
                  title: Text((index+1).toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                  subtitle: 
                  new Container(
                    
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     // Text(controller.getplayername(index).toString()),
                    players[index].player1f == null ? Text("Player 1: " + 'unknown') : Text("Player 1: " + players[index].player1f + '.' +  players[index].player1l ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent)),
                    players[index].player2f == null ? Text("Player 2: " + 'unknown') : Text("Player 2: " + players[index].player2f + '.' +  players[index].player2l,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)),
                    ],
                  ),
                  ),
                  
                  
                    trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.view_compact,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {
                  //   _onDeleteItemPressed(index);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.replay,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {
                  //   _onDeleteItemPressed(index);
                },
              ),
            ],
          ),
                  onTap: ()=>controller.onTap(index),
                   onLongPress: () => controller.longpress(index),
                ),
             ),
           );
          },
        ),*/

    )
    );
  }
}
