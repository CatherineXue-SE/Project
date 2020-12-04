import 'dart:io';
import 'package:Project/view/loginpage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../view/mydialog.dart';
import 'package:flutter/material.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:image_picker/image_picker.dart';

import '../view/signuppage.dart';
import './myfirebase.dart';
import '../model/user.dart';
//import '../view/mydialog.dart';

class SignUpPageController 
{
  SignUpPageState state;
  SignUpPageController(this.state);


  Future<void> pickImage(ImageSource source) async
  {
    File selected = await ImagePicker.pickImage(source: source);
    state.stateChanged(()
      {
       state.imagefile= selected;
       cropImage();
      // print('selected = ' + selected.toString());
       //state.user.photourl = selected.toString();
      }
    );
  }
  Future<void> cropImage() async
  {
    File cropped = await ImageCropper.cropImage(
     sourcePath: state.imagefile.path,
     
    );
state.stateChanged(()
      {
       state.imagefile= cropped ?? state.imagefile;
      }
    );  }

    Future<void> clearimage() async
  {

state.stateChanged(()
      {
       state.imagefile= null;
       state.user.photourl = '';
      }
    );  }
    
String validateState(String value)
  {
if (value.length != 2)
{
return '2 charcters only';
}
return null;
  }
  void saveState(String value)
  {
    //state.user.state = value;
  }
  void saveEmail(String value)
  {
    state.user.email = value;
  }

  String validateCity(String value)
  {
if (value.length < 2)
{
return 'Enter a valid city ';
}
return null;
  }
  void saveCity(String value)
  {
    //state.user.city = value;
  }
String validateAddress(String value)
  {
if (value.length < 2)
{
return 'Enter a valid address ';
}
return null;
  }
  void saveAddress(String value)
  {
    //state.user.address = value;
  }
String validateFname(String value)
  {
if (value.length < 1)
{
return 'Can not leave name null';
}
return null;
  }
  void saveFname(String value)
  {
    state.user.fname = value;
  }
String validateLname(String value)
  {
if (value.length < 1)
{
return 'Can not leave name null';
}
return null;
  }
  void saveLname(String value)
  {
    state.user.lname = value;
  }


  String validateEmail(String value)
  {
if (value == null || !value.contains('.') || !value.contains('@'))
{
return 'Enter a valid Email address';
}
return null;
  }
  
  String validatePassword(String value)
  {
if (value == null  || value.length < 6)
{
return 'Enter a password';
}
return null;
  }
  void savePassword(String value)
  {
    state.user.password = value;
  }
  String validateDisplayName(String value)
  {
if (value == null || value.length < 3)
{
return 'Enter at least 3 chars';
}
return null;
  }
  
  String validateZip(String value)
  {
if (value == null || value.length != 5 )
{
return 'Enter 5 digit zip code';
}
try{
int n = int.parse(value);
if (n < 10000)
{
  return 'Enter 5 digit zip code';
}
}catch(e){
return 'Enter 5 digits Zip code';
}
return null;
  }
  void saveZip(String value)
  {
    //state.user.zip = int.parse(value);
  }
  void createAccount() async 
  {
    if (!state.formKey.currentState.validate())
    {
      return;
    }
    state.formKey.currentState.save();
    //MyDialog.showProgressBar(state.context);

    //using email/password: signup an account at Firebase
    try
    {

    state.user.uid = await MyFirebase.createAccount(
    email: state.user.email,
    password: state.user.password,);

  //create user profile

    }
    catch (e)
    {
        MyDialog.popProgressBar(state.context);
      MyDialog.info(
       context: state.context,
       title: 'Account creation failed!',
       message: e.message != null ? e.message : e.toString(),
       action: () => Navigator.pop(state.context),
     );

     return; // do not proceed
    }
    try{
         if (state.imagefile != null)
       {
       String imagename =await  MyFirebase.createimage(state.imagefile);
       print(imagename);
         state.user.photourl = imagename.toString();
       } 
       else
        state.user.photourl = "https://firebasestorage.googleapis.com/v0/b/seii-bc463.appspot.com/o/board.png?alt=media&token=ff9b9d3d-69c4-4009-b36d-cf47de017e2e";

    DateTime now = DateTime.now();
    //DateTime date = new DateTime();//(now.year, now.month, now.day);
    state.user.lastupdate = now.toString().substring(0,16);
    MyFirebase.createProfile(state.user);

    }catch(e)
    {
      state.user.photourl = null;
    }
        MyDialog.popProgressBar(state.context);

    MyDialog.info(
       context: state.context,
       title: 'Account creation successfully!',
       message: 'Your account is created with ${state.user.email}',
       action: () =>   Navigator.push(state.context,MaterialPageRoute(builder: (context) => LoginPage())),
         
     );

  }
}