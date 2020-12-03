import 'dart:io';
import 'dart:typed_data';
import 'package:barter1/model/product.dart';
import 'package:barter1/view/listpage.dart';
import 'package:mock_data/mock_data.dart';
import 'package:barter1/controller/myfirebase.dart';
import 'package:barter1/view/mydialog.dart';
import 'package:barter1/view/viewimages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/asset.dart';
import 'package:multi_image_picker/cupertino_options.dart';
import 'package:multi_image_picker/picker.dart';
import '../view/productpage.dart';

class ProductPageController 
{
  ProductPageState state;
  ProductPageController(this.state);

  Future<void> loadAssets() async {
    state.stateChanged((){
      state.temimages = List<Asset>();
    }
    );
    state.temimages = List<Asset>();
   
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: false,
        options: CupertinoOptions(takePhotoIcon: "chat"),
      );
    }  catch (e) {
      error = e.message;    }
    if (!state.mounted) return;
    
  state.stateChanged((){
      state.temimages = resultList;
      if (state.temimages.length > 0 )
    {
      state.productCopy.photourls = new List<dynamic>();
    }
      state.error = error;
    }
    );
  }
Future saveImage(Asset asset) async {
    String fileName = state.popop;
    ByteData byteData = await asset.requestOriginal();
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    print(imageData[0].toString());
    StorageUploadTask uploadTask = ref.putData(imageData);

    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
String validateTitle(String value)
{
  if (value == null || value.length < 5)
  {
    return 'Enter Product title';
  }
  return null;
}
void clear()
{
    state.stateChanged(()
       {     
         state.temimages = new List<Asset>();
         state.productCopy.productname = "";
         state.pname = "";
         state.productCopy.price = 0.0;
         state.productCopy.description = "";
        state.productCopy.productname = "";

       });
}
void saveTitle(String value)
{
  state.productCopy.productname = value;
}

String validatePrice(String value)
{
  if (value.length != 0  && value != null )
  {
try{
    double price = double.parse(value);
    if (price == 0)
    {
              return 'Price cannot be 0';
    }
  }
  catch(e)
  {
        return 'Cannot leave price empty';
  }
  }
  else
    {
        return 'Cannot leave price empty';
  }
  return null;
}
void savePrice(String value)
{
  state.productCopy.price = double.parse(value);
}


void pickImages() async {
    List<Asset> resultList = List<Asset>();
    String error = '';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
      );
    }   catch ( e) {
      error = e.message;
    }
    if (!state.mounted) return;

    state.stateChanged(()
       {     
       state.temimages = resultList;
      state.error = error;
    });
  }

String validateReview(String value)
{
  if (value == null || value.length < 5)
  {
    return 'Enter Description (min 5 chars)';
  }
  return null;
}
void saveReview(String value)
{
  state.productCopy.description = value;
}
Future deleteproduct() async {
   showDialog(
      context: state.context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm"),
          content: new Text("Delete this item?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () async {
                try
{
  MyDialog.showProgressBar(state.context);
  await MyFirebase.deleteProduct(state.product);

  MyDialog.popProgressBar(state.context);
   MyDialog.info(
        context: state.context,
        title: 'prodcut delete',
        message: 'Product is deleted successfully!',
        action: () => gotolist(),
      );
}
catch(e){
    MyDialog.popProgressBar(state.context);
  print('BOOK DELETE ERROR: ' + e.toString());  
}
              },
            ),
              new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                              Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );

 
}
void save() async
{
  if(!state.formKey.currentState.validate())
  {
    return;
  }

 
  MyDialog.showProgressBar(state.context);
 String imagecollection = "";

  for (int i=0;i<state.temimages.length; i++)
  {
  Asset asset = state.temimages[i];
  print("i==========" + i.toString());
  print( "???????" + state.temimages.length.toString());
  var imageurl = await MyFirebase.createproductimage(asset);
    print( "*******" + imageurl.toString());

  imagecollection =  imagecollection + imageurl + ",";
  }
  List<String> imagellist = imagecollection.split(",");
  print("imagellist.length" + imagellist.length.toString());
  
  for (var image in imagellist)
  {
    if(image.trim().length > 0)
    {
    state.productCopy.photourls.add(image.trim()); 
    }
  }
  
    state.formKey.currentState.save();
    state.productCopy.useremail = state.user.email;
    state.productCopy.barterrate = state.user.rate;
    state.productCopy.uid = state.user.uid;
    state.productCopy.status = "OPEN";


    //state.productCopy.photourls = state.temimages;
    state.productCopy.lastupdate = DateTime.now().toString().substring(0,10);
    try
    {
      if(state.product == null)
      {
    state.productCopy.productid =  await MyFirebase.addProduct(state.productCopy);
   await MyFirebase.updateProduct(state.productCopy);
    print (state.productCopy.productid);
      }
      else{
        //from homepage to edit book
        await MyFirebase.updateProduct(state.productCopy);
      }
             MyDialog.popProgressBar(state.context);
             List<Product> barterlist = await MyFirebase.getBarterList(state.user.uid);
  Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => ListPage(state.user,barterlist),
  ));
   // Navigator.pop(state.context, state.productCopy);
    }
  catch(e)
{
MyDialog.info(
  context: state.context,
  title: 'Firestore Save Error',
  message: 'Firestore is unavailable now. Try again later' + e.toString(),
  action: (){
   Navigator.pop(state.context);
  // Navigator.pop(state.context,null);

  }
);
}

}

 Future gotolist() async 
 {
List<Product> myproducts = await MyFirebase.getBarterList(state.user.uid);
 Navigator.push(state.context,MaterialPageRoute(
  builder: (context) => ListPage(state.user, myproducts),
));   
 }
}