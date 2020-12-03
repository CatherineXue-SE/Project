import 'dart:ffi';
import 'dart:io';
import '../view/mydialog.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../controller/signuppage_controller.dart';
import '../model/user.dart';
class SignUpPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpPageState();
  }
  
}
class SignUpPageState extends State<SignUpPage>
{
    SignUpPageController controller;
    BuildContext context;
    File imagefile;
    User user = User();
    var formKey = GlobalKey<FormState>();
    SignUpPageState()
    {
      controller = SignUpPageController(this);
    }
    void stateChanged(Function fn)
    {
      setState(fn);
    }
  @override
  Widget build(BuildContext context) {
      this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Form(
        key: formKey,
        child: ListView( 
          children: <Widget>[
                                 Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                           Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 180.0,
                                height: 180.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                   image: 
                                          imagefile == null ? new DecorationImage(
                                          image: new ExactAssetImage("assets/images/bartericon.jpg"),
                                          fit: BoxFit.cover,
                                        ):new DecorationImage(
                                          image: new FileImage(imagefile),
                                           fit: BoxFit.cover,
                                        ),                              
                                    
                                ))]),
                      ])),
                              /*  Padding(
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
                            )),*/
        
              //imagefile != null ? Image.file(imagefile) : Text('import photo'),

                                Row(
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.only(left: 150),
                    icon: Icon(Icons.photo_library), 
                    onPressed: null,//() => controller.pickImage(ImageSource.gallery),
                    ),
             /*     IconButton(
                icon: Icon(Icons.photo_camera), 
                onPressed: () => controller.pickImage(ImageSource.camera),
                ),*/
                /* FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: () => controller.cropImage(),
                ),*/
                FlatButton
                (
                  child: Icon(Icons.refresh),
                  onPressed: null,//() => controller.clearimage(),
                ),
              ],
            ),
              
            Container(
              padding: EdgeInsets.only(left:30, right: 30),
              child: Column(             
                children: <Widget>[
                  TextFormField(
                    initialValue: user.email,
                    autocorrect: false,
                    decoration: InputDecoration(
                    hintText: 'Email(as login name)',
                    labelText: 'Email',),
                    validator: controller.validateEmail,
                    onSaved: controller.saveEmail,
                    ),
                    TextFormField(
                    initialValue: user.password,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',),
                    validator: controller.validatePassword,
                    onSaved: controller.savePassword,),
                    ],
                  ),
            ),
            
               Container(
                 padding: EdgeInsets.only(left:30, right: 30),
                 child: new Row(
                   
                    children: <Widget>[
                    new Flexible(
                      child: TextFormField(
                      initialValue: user.fname,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                      hintText: 'First Name',
                      labelText: 'First Name',),
                      validator: controller.validateFname,
                      onSaved: controller.saveFname,),
                    ),
                        SizedBox(width: 20.0,),
                     new Flexible(
                     child: TextFormField(
                    initialValue: user.lname,
                    autocorrect: false,
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Last Name',
                    labelText: 'Last Name',),
                    validator: controller.validateLname,
                    onSaved: controller.saveLname,),
                     )
                    ]),
               ),
                  Container(
                    padding: EdgeInsets.only(left:30,right: 30),
                    child: TextFormField(
                          initialValue: "",//user.city,
                          autocorrect: false,
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Address',
                          labelText: 'Address',),
                          validator: controller.validateAddress,
                          onSaved: controller.saveAddress,),
                  ),
                      
                
              
                Container(
                 padding: EdgeInsets.only(left:30, right: 30),
                 child: new Row(
                    children: <Widget>[
                    new Flexible(
                      child: TextFormField(
                      initialValue: '',//user.city,
                      autocorrect: false,
                      decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'City',
                      labelText: 'City',),
                      validator: controller.validateCity,
                      onSaved: controller.saveCity,),
                    ),
                  
                    ]),
               ),
                 Container(
                 padding: EdgeInsets.only(left:30, right: 30),
                 child: new Row(
                    children: <Widget>[
                   
                     new Flexible(
                     child: TextFormField(
                    initialValue: user.lname,
                    autocorrect: false,
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'State',
                    labelText: 'State',),
                    validator: controller.validateState,
                    onSaved: controller.saveState),
                     ),
                                         SizedBox(width: 10.0,),

                      new Flexible(
                      child: TextFormField(
                      initialValue: '',//user.city,
                      autocorrect: false,
                      decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Zip',
                      labelText: 'Zip',),
                      validator: controller.validateZip,
                      onSaved: controller.saveZip,),
                    ),
                    ]),
               ),
/*
                 TextFormField(
                  initialValue: user.address,
                  autocorrect: false,
                  decoration: InputDecoration(
                  hintText: 'Address',
                  labelText: 'Address',),
                  validator: controller.validateAddress,
                  onSaved: controller.saveAddress,),
                   Row(
                children: <Widget>[
                  TextFormField(
                  initialValue: user.city,
                  autocorrect: false,
                  decoration: InputDecoration(
                  hintText: 'City',
                  labelText: 'City',),
                  validator: controller.validateCity,
                  onSaved: controller.saveCity,),
                 TextFormField(
                  initialValue: user.city,
                  autocorrect: false,
                  decoration: InputDecoration(
                  hintText: 'State(Abbr)',
                  labelText: 'State(Abbr)',),
                  validator: controller.validateState,
                  onSaved: controller.saveState,),
                ],
              ),
              TextFormField(
              initialValue: user.zip.toString(),
              autocorrect: false,
              decoration: InputDecoration(
              hintText: 'ZIP Code',
              labelText: 'zip',),
              validator: controller.validateZip,
              onSaved: controller.saveZip,),*/
              RaisedButton(child: Text('Create Account'),
              onPressed: controller.createAccount,)
          ],
        ),
      ), 
      );
  }
}