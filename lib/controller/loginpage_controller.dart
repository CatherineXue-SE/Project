import 'package:flutter/material.dart';
import '../view/loginpage.dart';
import '../model/user.dart';
import '../view/signuppage.dart';
import '../model/record.dart';
import '../view/optionpage.dart';
import '../controller/myfirebase.dart';
class LoginPageController
{
  LoginPageState state;
  LoginPageController(this.state);

  
  void createAccount()
  {
   Navigator.push(state.context,MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }

  String validateEmail(String value)
  {
    if (value == null || !value.contains('.') || !value.contains('@'))
    {
      return 'Enter valid Email address';
    }
    return null;
  }
  void saveEmail(String value)
  {
    state.user.email = value;
  }
  String validatePassword(String value)
  {
    if (value == null)
    {
      return 'Enter password';
    }
    return null;
  }
  void savePassword(String value)
  {
    state.user.password = value;
  }
  void forgetpassword()
  {
      Navigator.push
               (state.context,
               MaterialPageRoute(
          builder: null//(context) => ForgetPasswordPage()
               )
               );
  }
  void login() async
  {
    if (!state.formKey.currentState.validate())
    {
      return;
    }
    state.formKey.currentState.save();
    //MyDialog.showProgressBar(state.context);
    try{
     state.user.uid = await MyFirebase.login(
       email: state.user.email,
       password: state.user.password);
    }
catch(e)
    { 
   //   MyDialog.popProgressBar(state.context);
       state.stateChanged(()
       {
            state.errormessage = e.message != null ? e.message : e.toString();
       }
     );
        return;
    }
    // login success, read profile
try
{
User user = await MyFirebase.readProfile(state.user.uid);
state.user.fname = user.fname;
state.user.lname = user.lname;
state.user.lastupdate = user.lastupdate;
state.user.photourl = user.photourl;
}
catch(e)
{
  print(e.toString());
//no displayname and zip can be updated
}
  //MyDialog.popProgressBar(state.context);
    print(state.user.uid);

  List<Record> allproducts = await MyFirebase.getRecords(state.user.uid);
  print(allproducts.length);
  Navigator.pop(state.context);//dispose this dialog
               Navigator.push
               (state.context,
               MaterialPageRoute(
          builder: (context) => OptionPage(state.user,allproducts),
        ));
    }
}
