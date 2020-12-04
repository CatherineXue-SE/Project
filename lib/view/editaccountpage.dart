import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:flutter/material.dart';
 //import 'package:image_picker/image_picker.dart';
 import '../controller/editaccountpage_controller.dart';
 import '../model/user.dart';

 class EditAccountPage extends StatefulWidget
 {
   final User user;

    EditAccountPage(this.user);
   var formkey = GlobalKey<FormState>();

   State<StatefulWidget> createState() {
     return EditAccountPageState(user);
   }
  
 }
 class EditAccountPageState extends State<EditAccountPage>
 {
   User user;
     bool editMode = false;

   File imagefile;
     var rating = 0.0; 
   String newpassword;
   var formKey = GlobalKey<FormState>();
  int currentIndex = 3;

  EditAccountPageController controller;
    EditAccountPageState(this.user)
   {
     controller = EditAccountPageController(this);

   }
   void stateChanged(Function fn)
     {
       setState(fn);
     }
   @override
   Widget build(BuildContext context) {
      //TODO: implement build
     return Scaffold(
       appBar: AppBar(
        title: Text ('Edit Account'),
        actions: <Widget>[
          editMode ? FlatButton.icon(
          icon: Icon(Icons.save),
          label: Text('Save'),
          onPressed: controller.editaccount,)
          :FlatButton.icon(
          icon: Icon(Icons.edit),
          label: Text('Edit'),
          onPressed: controller.edit,),
        ],
        ),
              
         body: new Container(
       color: Colors.white,
       child: new ListView(
         children: <Widget>[
           Column(
             children: <Widget>[
               new Container(
                // height: 250.0,
               //  color: Colors.white,
                 child: new Column(
                   children: <Widget>[
                     Padding(
                         padding: EdgeInsets.only(left: 20.0, top: 20.0),
                         child: new Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                   
                             Padding(
                               padding: EdgeInsets.only(left: 25.0),
                               child: new Text('PROFILE',
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 20.0,
                                       fontFamily: 'sans-serif-light',
                                       color: Colors.black)),
                             )
                           ],
                         )),

                Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                 image: imagefile == null  ? new DecorationImage(
                                   image: 
                                   new NetworkImage(user.photourl),
                                   fit: BoxFit.cover) :                                    
                                      new DecorationImage(
                                        image: new FileImage(imagefile),
                                        fit: BoxFit.cover,
                                      ),
                                 
                                    /*image: new ExactAssetImage(
                                        'assets/images/as.png'),
                                    fit: BoxFit.cover,*/
                                  
                                )),
                          ],
                        ),

                        editMode == true ? Padding(
                             padding: EdgeInsets.only(top: 90.0, right: 100.0),
                             child: new Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 new CircleAvatar(
                                   backgroundColor: Colors.red,
                                   radius: 25.0,
                                   child: new IconButton(
                                     color: Colors.white,
                                     onPressed: () => controller.pickImage(ImageSource.gallery), 
                                     icon: Icon(Icons.photo_library,
                                   ),
                                 ))
                               ],
                             )) : Text(""),
                       ]),
                     )
                   ],
                 ),
               ),
               Form(
                 key:formKey,
                 child: new Container(
                   color: Color(0xffFFFFFF),
                   child: Padding(
                     padding: EdgeInsets.only(bottom: 25.0),
                     child: new Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                             padding: EdgeInsets.only(
                                 left: 25.0, right: 25.0, top: 25.0),
                             child: new Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                     new Text(
                                       'Parsonal Information',
                                       style: TextStyle(
                                           fontSize: 18.0,
                                           fontWeight: FontWeight.bold),
                                     ),
                                   ],
                                 ),
                                 new Column(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                    // _status ? _getEditIcon() : new Container(),
                                   ],
                                 )
                               ],
                             )),
                         Padding(
                             padding: EdgeInsets.only(
                                 left: 35.0, right: 25.0, top: 25.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                     new Text(
                                       'Email:   ${user.email}',
                                       style: TextStyle(
                                           fontSize: 16.0,
                                           fontWeight: FontWeight.bold),
                                     ),
                                     
                                   ],
                                 ),
                               ],
                             )),
                              Padding(
                             padding: EdgeInsets.only(
                                 left: 35.0, right: 25.0, top: 5.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                   //mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                            Container(
                                              width: 150,
                                              child: TextFormField(
                                                enabled: editMode,
                                                initialValue: user.fname,
                                                autocorrect: false,
                                                decoration: InputDecoration(
                                                hintText: 'First ',
                                                labelText: 'First',),
                                                validator: controller.validateFname,//controller.validatePassword,
                                                onSaved: controller.saveFname),
                                            ),
                                            SizedBox(width: 20,),
                                             Container(
                                              width: 150,
                                              child: TextFormField(
                                                enabled: editMode,
                                                initialValue: user.lname,
                                                autocorrect: false,
                                                decoration: InputDecoration(
                                                hintText: 'Last ',
                                                labelText: 'Last',),
                                                validator: controller.validateLname,//controller.validatePassword,
                                                onSaved: controller.saveLname),
                                            ),
                                    /* new Text(
                                       'First Name :${user.fname}',
                                       style: TextStyle(
                                           fontSize: 16.0,
                                           fontWeight: FontWeight.bold),
                                     ),*/
                                     
                                   ],
                                 ),
                               ],
                             )),
                             /* Padding(
                             padding: EdgeInsets.only(
                                 left: 35.0, right: 25.0, top: 5.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                     new Text(
                                       'Last Name :${user.lname}',
                                       style: TextStyle(
                                           fontSize: 16.0,
                                           fontWeight: FontWeight.bold),
                                     ),
                                     
                                   ],
                                 ),
                               ],
                             )),*/

                                            Padding(
                             padding: EdgeInsets.only(
                                 left: 35.0, right: 25.0, top: 5.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                   //mainAxisSize: MainAxisSize.min,
                           
                                    /* new Text(
                                       'First Name :${user.fname}',
                                       style: TextStyle(
                                           fontSize: 16.0,
                                           fontWeight: FontWeight.bold),
                                     ),*/
                                     
                                   
                                 ),
                               ],
                             )),

                               Padding(
                             padding: EdgeInsets.only(
                                 left: 35.0, right: 25.0, top: 5.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                 new Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                   //mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                          
                                    /* new Text(
                                       'First Name :${user.fname}',
                                       style: TextStyle(
                                           fontSize: 16.0,
                                           fontWeight: FontWeight.bold),
                                     ),*/
                                     
                                   ],
                                 ),
                               ],
                             )),

                        
                            Padding(
                             padding: EdgeInsets.only(
                                 left: 35.0, right: 35.0, top: 5.0),
                             child: new Row(
                               mainAxisSize: MainAxisSize.max,
                               children: <Widget>[
                                   new Text(
                                       "Latest Updated by:",
                                       style: TextStyle(
                                           fontSize: 16.0,
                                           fontWeight: FontWeight.bold),
                                     ),
                                    user.lastupdate == null ? Text("") :  Text(user.lastupdate),
                               /*  new Flexible(
                                   child: new TextFormField(
                                     initialValue: user.email,
                                     decoration: const InputDecoration(
                                       hintText: "Enter Your Account Email",
                                     ),
                                     onSaved: controller.saveEmail,
                                     validator: controller.validateEmail,
                                   //  enabled: !_status,
                                     //autofocus: !_status,

                                   ),
                                 ),*/
                               ],
                             )),
  
             /*SmoothStarRating(
                
               rating: rating,
               size: 30,
               starCount: int.parse(user.rate.toString()),
               spacing: 2.0,
               onRatingChanged: (value) {
            setState(() {
              rating = value;
            });
          },
        )  ,*/
                      Container(
             padding: EdgeInsets.only(top:100, left: 30),
             child: new InkWell(
                child: new Text('Reset your password',style:TextStyle(color: Colors.blue),),
                onTap: controller.resetpassword,
          ),
           ),
                      Container(
             padding: EdgeInsets.only(top:5, left: 30),
             child: new InkWell(
                child: new Text('Log out',style:TextStyle(color: Colors.blue),),
                onTap: controller.signOut,
          ),
           ),
                       // _getActionButtons(),
                       ],
                     ),
                   ),
                 ),
               )
             ],
           ),
         ],
       ),
     ));
   }

   @override
   void dispose() {
     // Clean up the controller when the Widget is disposed
    // myFocusNode.dispose();
     super.dispose();
   }

   Widget _getActionButtons() {
     return Padding(
       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
       child: new Row(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
           Expanded(
             child: Padding(
               padding: EdgeInsets.only(right: 10.0),
               child: Container(
                   child: new RaisedButton(
                 child: new Text("Save"),
                 textColor: Colors.white,
                 color: Colors.green,
                 onPressed: controller.editaccount,
                 shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(20.0)),
               )),
             ),
             flex: 2,
           ),
           Expanded(
             child: Padding(
               padding: EdgeInsets.only(left: 10.0),
               child: Container(
                   child: new RaisedButton(
                 child: new Text("Cancel"),
                 textColor: Colors.white,
                 color: Colors.red,
                 onPressed: () => Navigator.pop(context),
                 shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(20.0)),
               )),
             ),
             flex: 2,
           ),
         ],
       ),
     );
   }

  padding() {}


 }
