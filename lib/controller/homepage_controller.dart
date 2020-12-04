import 'package:barter1/model/product.dart';
import 'package:barter1/view/viewproductpage.dart';

import '../view/editaccountpage.dart';
import '../view/listpage.dart';
import '../view/loginpage.dart';

import '../controller/myfirebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/homepage.dart';

class HomePageController 
{
  HomePageState state;

HomePageController(this.state);
void onTap(int index) async       
{
  
 Product b = await Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => ViewProductPage(state.user,state.allproducts[index]),
  ));
  
 
} 
void onTabTapped(int index) async{
state.stateChanged(()
        {
      state.currentIndex = index;
    switch (index) {
    case 0:    print(state.allproducts.length.toString());
    break;
    case 1:
    print("1");
    gotolist();
    break;
    case 2:
        print("2");
        state.titlename = "Message";
    break;
    case 3:
     Navigator.push(state.context,MaterialPageRoute(
          builder: (context) => EditAccountPage(state.user),
        ));
        print("3");

    break;
  }
   });
 }
 Future readbarterlist()  async {
  List<Product> myproducts = await MyFirebase.getBarterList(state.user.uid);
 /*Product pone = new Product();
 pone.productname = 'Test';
 pone.productname = '0001';
 pone.publishby = 'hxue@uco.edu';
 pone.price = 90;
 pone.lastupdate= '08/12/2019';
 myproducts.add(pone);*/
 Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => ListPage(state.user, myproducts),
));
 }
 Future gotolist() async 
 {
List<Product> myproducts = await MyFirebase.getBarterList(state.user.uid);
 Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => ListPage(state.user, myproducts),
));   
 }
void signOut()
{
  MyFirebase.signOut();
  Navigator.push(state.context,MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));  
}

Future pricelowtohigh() async
{
   //List<Product> productsearchlist = List<Product>();
      List<Product> myproducts = await MyFirebase.getListPriceLowToHigh(state.user.uid);
   // productsearchlist.addAll(myproducts);
state.stateChanged(()
        {        
          state.allproducts.clear();
        state.allproducts.addAll(myproducts);
        Navigator.pop(state.context);
      });
      return;

}
Future pricehightolow() async
{
   //List<Product> productsearchlist = List<Product>();
      List<Product> myproducts = await MyFirebase.getListPriceHighToLow(state.user.uid);
   // productsearchlist.addAll(myproducts);
state.stateChanged(()
        {        
          state.allproducts.clear();
        state.allproducts.addAll(myproducts);
        Navigator.pop(state.context);
      });
      return;

}
Future datehightolow() async
{
   //List<Product> productsearchlist = List<Product>();
      List<Product> myproducts = await MyFirebase.getListDateHighToLow(state.user.uid);
   // productsearchlist.addAll(myproducts);
state.stateChanged(()
        {        
          state.allproducts.clear();
        state.allproducts.addAll(myproducts);
        Navigator.pop(state.context);
      });
      return;

}
Future datelowtohigh() async
{
   //List<Product> productsearchlist = List<Product>();
      List<Product> myproducts = await MyFirebase.getListDateLowToHigh(state.user.uid);
   // productsearchlist.addAll(myproducts);
state.stateChanged(()
        {        
          state.allproducts.clear();
        state.allproducts.addAll(myproducts);
        Navigator.pop(state.context);
      });
      return;

}
Future filterSearchResults(String query) async {
    List<Product> productsearchlist = List<Product>();
      List<Product> myproducts = await MyFirebase.getAllList(state.user.uid);
    productsearchlist.addAll(myproducts);
    if(query.isNotEmpty) {
      List<Product> dummyListData = List<Product>();
      productsearchlist.forEach((item) {
        if(item.productname.contains(query)) {
          dummyListData.add(item);
        }
      });
state.stateChanged(()
        {        
          state.allproducts.clear();
        state.allproducts.addAll(dummyListData);
      });
      return;
    } else {
     state.stateChanged(()
         {        
          state.allproducts.clear();
        state.allproducts.addAll(myproducts);
      });
    }

  }
}