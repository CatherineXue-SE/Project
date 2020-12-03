import 'package:flutter/material.dart';
import '../model/user.dart';
import '../controller/loginpage_controller.dart';
class LoginPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
  
  
}
class LoginPageState extends State<LoginPage>
{
  LoginPageController controller;
  BuildContext context;
  String errormessage;
  var user = User();
  var formKey = GlobalKey<FormState>();
  LoginPageState()
  {
    controller = LoginPageController(this);
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
        title: Text ('Tic-Tac-Toe'),
                    leading: new Container(),
        ),
        body: Form
        (key:formKey,
        
          child: ListView
        (children: <Widget>[
          SizedBox(height: 80),
          /*Column(
            children: <Widget>[
              Image.asset("assets/images/uco.jpg",width: 100, height: 40,),
            ],
          ),*/
            Padding(
                padding: EdgeInsets.only(
                top: 35),          ),
         Container(
          padding: EdgeInsets.only(left:25,right:25),
           child: new TextFormField(
              initialValue: user.email,
              decoration: InputDecoration
              (labelText: 'Enter email as login name',
              hintText: 'email',
              contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal:10.0),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),
              keyboardType: TextInputType.emailAddress,
             validator: controller.validateEmail,
              onSaved: controller.saveEmail,
              autocorrect: false,
            ),
         ),
          Padding(
                padding: EdgeInsets.only(
                top: 15),          ),
          Container(
                      padding: EdgeInsets.only(left:25,right:25),

            child: TextFormField(
              initialValue: user.password,
              obscureText: true,
              
              decoration: InputDecoration
              (labelText: 'Enter password',
              hintText: 'password',
              contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
       ),
              validator: controller.validatePassword,
             onSaved: controller.savePassword,
            ),
          ),
                Container(
             padding: EdgeInsets.only(top:40, left: 30),
             child: new InkWell(
                child: new Text('Create New Account>>',style:TextStyle(color: Colors.blue),),
                onTap: controller.createAccount,
          ),
           ),
           Container(
             padding: EdgeInsets.only(top:5, left: 30),
             child: new InkWell(
                child: new Text('Forget your password?',style:TextStyle(color: Colors.blue),),
                onTap: controller.forgetpassword,
          ),
           ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[  
          RaisedButton(
                child: Text('Log in'),
                onPressed: controller.login,
                textColor: Colors.white,
                color: Colors.lightBlue,
                padding: const EdgeInsets.all(8.0),              
              ),
            ],
          ),
           Padding(
             padding: const EdgeInsets.all(8.0),
          child: Card(
          child:errormessage == null ? Text("") : Text(errormessage,style: TextStyle(color: Colors.red)),
        ),
           ),
         
        ],)),
        );
  }

}
