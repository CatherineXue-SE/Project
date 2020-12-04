import 'package:flutter/material.dart';
import '../controller/forgetpassword_controller.dart';
import '../model/user.dart';
class ForgetPasswordPage extends StatefulWidget
{
   User user;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgetPasswordPageState(this.user);
  }
  
}
class ForgetPasswordPageState extends State<ForgetPasswordPage>
{
    ForgetPasswordPageController controller;
    BuildContext context;
       User user;

    var formKey = GlobalKey<FormState>();
    ForgetPasswordPageState(this.user)
    {
      controller = ForgetPasswordPageController(this);
    }
    void stateChanged(Function fn)
    {
      setState(fn);
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      this.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('reset password'),
      ),
      body: Form(
        key: formKey,
        child: ListView( 
          children: <Widget>[
            Text("Please Enter the email you registered:"),
            TextFormField(
              initialValue: "",
              autocorrect: false,
              decoration: InputDecoration(
             // hintText: 'Enter the Email(the one you registered)',
              labelText: 'Email',),
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
              ),
                 RaisedButton(child: Text('Reset Password'),
              onPressed: controller.resetpassword,)
              
          ],
        ),
      ), 
      );
  }
}