import '../model/user.dart';
import '../view/replaypage.dart';

import '../model/record.dart';
import '../view/optionpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/recordpage.dart';
import '../controller/myfirebase.dart';

class RecordPageController 
{
  RecordPageState state;
RecordPageController(this.state);
// ignore: missing_return

Future<String> getplayername(int index) async{
 // print("????????" + state.records[index].toString());
  User user1 = await MyFirebase.readProfile(state.records[index].player1);
  User user2 = await MyFirebase.readProfile(state.records[index].player2);
  state.stateChanged(() {

      state.player1 = user1.fname+'.' + user1.lname;
      state.player2 = user2.fname+'.' + user2.lname;
    });
  }
void signOut()
{
  MyFirebase.signOut();
  Navigator.pop(state.context);
  Navigator.pop(state.context);
}
void addButton() async
{
  /*print("addButton called");
 Record b =  
 await Navigator.push(state.context, MaterialPageRoute(
    builder: (context) => ProductPage(state.user,null))
     );
     if (b!= null)
     {
       //state.products.add(b);
       //new book stored in Firebase
     }
     else
     {
       //error occured
     }*/
}

void onTap(int index) async       
{
  if (state.deleteIndices == null)
  {//nevigate to BookPage
 Record b = await Navigator.push(state.context,MaterialPageRoute(
  builder: null,//(context) => ProductPage(state.user,state.products[index]),
  ));
  if (b!= null)
  {
    // update book is stored in firebase
    //state.products[index] = b;
  }
  }
  else
  {
   if (state.deleteIndices.contains(index))
   {
     //tapped again -> deselect
    state.deleteIndices.remove(index);
    if (state.deleteIndices.length == 0)
    {
      // all deselect. delete mode quits
      state.deleteIndices = null;
    }
   }
    else
    {
      state.deleteIndices.add(index);
    }
    state.stateChanged((){});
 
  }
  
 
} 
Future gotohomelist() async 
 {
List<Record> myproducts = await MyFirebase.getRecords(state.user.uid);
 Navigator.push(state.context,MaterialPageRoute(
  builder: null,//(context) => HomePage(state.user, myproducts),
));   
 }
void longpress(int index)
{
  if (state.deleteIndices == null)
  {
    state.stateChanged((){
    state.deleteIndices = <int>[index];
    });
  }
}
void deleteButton() async
{
  //sort descending order of deleteindices
  state.deleteIndices.sort((n1,n2){
     if (n1<n2) return 1;//asc = -1
     else if (n1==n2) return 0;
     else return -1;//asc = 1
  });
  //deleteIndices: [a,b,c,d]
for (var index in state.deleteIndices)
{
  try
{
 // await MyFirebase.deleteProduct(state.products[index]);
  //state.products.removeAt(index);
}
catch(e){
  print('BOOK DELETE ERROR: ' + e.toString());  
}

}
state.stateChanged((){
  state.deleteIndices = null;
});

}
void gotohomepage() async
{
  await Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => OptionPage(state.user,state.records),
));
}

void gotoreplaypage(Record record) async
{
 /* for(int i=0;i<record.finalboard.length;i++)
  {
  record.finalboard[i] = '-';
  }*/
  print(record.finalboard.toString());
  await Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => ReplayPage(record),
));
}

/*void sharedWithMeMenu() async
{
List<Book> books = await MyFirebase.getBooksSharedWithME(state.user.email);
print('# of books shared: ' + books.length.toString());
for(var book in books)
{
  print(book.title);
}
//navigate to a new page
await Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => SharedBooksPage(state.user, books),
));
Navigator.pop(state.context);//close the drawer
}*/
}