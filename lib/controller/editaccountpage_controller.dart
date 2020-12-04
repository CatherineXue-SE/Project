import 'dart:io';

import 'package:Project/view/optionpage.dart';

import '../model/record.dart';
import '../view/loginpage.dart';
import '../view/mydialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../view/mydialog.dart';
import '../view/editaccountpage.dart';
import 'package:flutter/material.dart';
 //import 'package:image_cropper/image_cropper.dart';
 //import 'package:image_picker/image_picker.dart';

 import '../view/editaccountpage.dart';
 import 'myfirebase.dart';

 class EditAccountPageController 
 {
   EditAccountPageState state;
   EditAccountPageController(this.state);



  Future<void> pickImage(ImageSource source) async
  {
    File selected = await ImagePicker.pickImage(source: source);
    state.stateChanged(()
      {
       state.imagefile= selected;
           cropImage();

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

   String validateState(String value)
  {
if (value.length != 2)
{
return '2 charcters only';
}
return null;
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

  

   void editaccount() async 
   {
     if (!state.formKey.currentState.validate())
     {
       return;
     }
     state.formKey.currentState.save();
       MyDialog.showProgressBar(state.context);
     //using email/password: signup an account at Firebase
     try
     {
       String imagename =  state.imagefile != null ? await MyFirebase.createimage(state.imagefile) : state.user.photourl;
      state.user.photourl = imagename.toString();
      DateTime now = DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    state.user.lastupdate = now.toString().substring(0,16);
       MyFirebase.updateProfile(state.user);

   //create user profile

     }
     catch (e)
     {    
       MyDialog.popProgressBar(state.context);

      MyDialog.info(
        context: state.context,
        title: 'Account updated failed!',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return;  //do not proceed
     }
    
    MyDialog.popProgressBar(state.context);

     MyDialog.info(
        context: state.context,
        title: 'Account update successfully!',
        message: 'Your account is updated',
        action: () => Navigator.pop(state.context),
      );

 state.stateChanged(
    ()
    {
      state.editMode = false;
    });
  
   }  

   void resetpassword() async 
   {
    await MyFirebase.resetpassword(state.user.email);
    MyDialog.info(
        context: state.context,
        title: 'email sent!',
        message: 'check your email box to see the link for resetting password',
        action: () => Navigator.pop(state.context),
      );
   }  
   void edit()
{
state.stateChanged(()
  {
    state.editMode = true;
  }
);
}
Future gotohomelist() async 
 {
 Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => OptionPage(state.user),
));   
 }
   
void save()
{
if(state.formKey.currentState.validate())
{
  state.formKey.currentState.save();

 state.stateChanged(
    ()
    {
      state.editMode = false;
    });
  }
 
}
void signOut()
{
   MyFirebase.signOut();
  Navigator.push(state.context,MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));  
}
 }