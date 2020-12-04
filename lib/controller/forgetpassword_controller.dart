import '../view/mydialog.dart';
import '../view/mydialog.dart';
import 'package:flutter/material.dart';
import '../view/forgetpassword.dart';
 //import 'package:image_cropper/image_cropper.dart';
 //import 'package:image_picker/image_picker.dart';
import 'myfirebase.dart';

 class ForgetPasswordPageController 
 {
  ForgetPasswordPageState state;
  ForgetPasswordPageController(this.state);


   String validateEmail(String value)
   {
 if (value == null || !value.contains('.') || !value.contains('@'))
 {
 return 'Enter a valid Email address';
 }
 return null;
   }
   Future saveEmail(String value)
   async {
       

          var result = await MyFirebase.resetpassword(value);
          print(result);
     if (result == false)
     {
 MyDialog.info(
        context: state.context,
        title: 'email not exist!',
        message: "This email is not found in the system",
        action: () => Navigator.pop(state.context),);
      
      
     }
     else
     {
 MyDialog.info(
        context: state.context,
        title: 'Email is sent successfully!',
        message: 'The new password link is send to your registered email address',
        action: () => Navigator.pop(state.context),
      );
     }
       
  // Handle err

    
   }


   void resetpassword() async 
   {
     if (!state.formKey.currentState.validate())
     {
       return;
     }
     state.formKey.currentState.save();
   }  

 }