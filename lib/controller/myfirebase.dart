import 'dart:io';

import '../model/record.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show ByteData, PlatformException;

class MyFirebase
{
    String popop = "";

static Future<String> createAccount({String email, String password}) async
{
  AuthResult auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  return auth.user.uid;
}
static Future<void> updateProfile(User user) async
{

  await Firestore.instance.collection(User.PROFILE_COLLECTION)
  .document(user.uid)
  .setData(user.serialize());


}
static Future<String> createimage(File imagefile) async{
   FirebaseStorage storage = 
  FirebaseStorage(storageBucket: 'gs://barter-ex.appspot.com/');
  String filepath = 'images/${DateTime.now()}.png';
  try{
      StorageUploadTask uploadTask = storage.ref().child(filepath).putFile(imagefile);
          var downloadUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
          return downloadUrl;


  }
  catch(e)
  {
print(e.toString());
  }

}

/*static Future<String> createproductimage(Asset asset) async{
  List<int> imageData = asset.thumbData.buffer.asUint8List();
     FirebaseStorage storage = 
  FirebaseStorage(storageBucket: 'gs://barter-ex.appspot.com/');
  String fileName = 'products/${DateTime.now()}.png';
  try{
    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = ref.putData(imageData);
     var imageurl = await(await uploadTask.onComplete).ref.getDownloadURL();
     print ("Firebase" + imageurl);
     return imageurl.toString();
  }
  catch(e)
  {
print(e.toString());
  }

}*/

static Future<bool> resetpassword(String email) async
{
  var result = false;
  try{
 await FirebaseAuth.instance.sendPasswordResetEmail( email: email,);
 result = true;
  }
      catch (e) {
         result = false;
     }
     
       return result;

}

  
static void createProfile(User user) async
{
await Firestore.instance.collection(User.PROFILE_COLLECTION)
.document(user.uid)
.setData(user.serialize());
}

static Future<String> login({String email, String password}) async
{
AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);
return auth.user.uid;
}
static Future<User> readProfile(String uid)async
{
  DocumentSnapshot doc =await Firestore.instance.collection(User.PROFILE_COLLECTION)
  .document(uid).get();
  return User.deserialize(doc.data);
}
static Future<String> addRecord(Record record) async
{
DocumentReference ref = await Firestore.instance.collection(Record.RECORD_COLLECTION)
.add(record.serialize());
return ref.documentID;
}
static Future<List<Record>> getRecord(String gameid) async {
  print('getBooks start');
 QuerySnapshot querySnapshot =  await Firestore.instance.collection(Record.RECORD_COLLECTION)
  .where(Record.GAMEID, isEqualTo: gameid)
  .getDocuments();
  var booklist = <Record>[];
  if (querySnapshot == null || querySnapshot.documents.length == 0)
  {
      print('getBooks is null');
    return booklist;
  } 
        print('getBooks is not null');

  for(DocumentSnapshot doc in querySnapshot.documents)
  {
    booklist.add(Record.deserialize(doc.data,doc.documentID));
  }
  return booklist;
}

static Future<void> deleteProduct(Record product) async
{
await Firestore.instance.collection(Record.RECORD_COLLECTION)
.document(product.gameid).delete();
}
static Future<void> updateRecord(Record record) async
{
  await Firestore.instance.collection(Record.RECORD_COLLECTION)
  .document(record.gameid)
  .setData(record.serialize());
}
static Future<List<Record>> getRecordList(String uid) async
{
try
  {
    QuerySnapshot querySnapshot1 = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
    .where(Record.PLAYER1, isEqualTo: uid)
    .getDocuments();
    QuerySnapshot querySnapshot2 = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
    .where(Record.PLAYER2, isEqualTo: uid)
    .getDocuments();
    var records = <Record>[];
    if (querySnapshot1 == null || querySnapshot2 == null || querySnapshot1.documents.length == 0|| querySnapshot1.documents.length == 0)
    {
          print(records.length);
          return records;
    }
    for (DocumentSnapshot doc in querySnapshot1.documents)
    {
      records.add(Record.deserialize(doc.data, doc.documentID));
    }
       for (DocumentSnapshot doc in querySnapshot2.documents)
    {
      records.add(Record.deserialize(doc.data, doc.documentID));
    }
    print(records.length);
    return records;
  } catch(e)
  {
    print("cannot read ++++++" + e.toString());
throw e;
  }
}


static Future<List<Record>> searchproductlist(String searchkey) async
{
try
  {
    QuerySnapshot querySnapshot = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
   // .startAt([searchkey])
   // .endAt([searchkey + '\uf8ff'])
    .getDocuments();
    var products = <Record>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0)
    {
          print(products.length);

      return products;
      
    }
    for (DocumentSnapshot doc in querySnapshot.documents)
    {
      products.add(Record.deserialize(doc.data, doc.documentID));
    }
    print(products.length);
    return products;
  } catch(e)
  {
    print("cannot read ++++++" + e.toString());
throw e;
  }
}

static Future<List<Record>> getRecords(String uid) async
{
try
  {
    QuerySnapshot querySnapshot = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
    .getDocuments();
    var products = <Record>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0)
    {
      print("products.length"  + products.length.toString());
      return products;
      
    }
    for (DocumentSnapshot doc in querySnapshot.documents)
    {
      products.add(Record.deserialize(doc.data, doc.documentID));
    }
          print("products.length"  + products.length.toString());

    return products;
  } catch(e)
  {
    print("cannot read ++++++" + e.toString());
throw e;
  }
}



static Future<List<Record>> getListPriceLowToHigh(String uid) async
{
try
  {
    QuerySnapshot querySnapshot = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
    .orderBy(Record.STARTDATETIME)
    .getDocuments();
    var products = <Record>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0)
    {
      return products;
    }
    for (DocumentSnapshot doc in querySnapshot.documents)
    {
      products.add(Record.deserialize(doc.data, doc.documentID));
    }
    return products;
  } catch(e)
  {
    print("cannot read ++++++" + e.toString());
    throw e;
  }
}
static Future<List<Record>> getListPriceHighToLow(String uid) async
{
try
  {
    QuerySnapshot querySnapshot = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
    .orderBy(Record.STARTDATETIME,descending: true)
    .getDocuments();
    var products = <Record>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0)
    {
      return products;
    }
    for (DocumentSnapshot doc in querySnapshot.documents)
    {
      products.add(Record.deserialize(doc.data, doc.documentID));
    }
    return products;
  } catch(e)
  {
    print("cannot read ++++++" + e.toString());
    throw e;
  }
}
static Future<List<Record>> getListDateLowToHigh(String uid) async
{
try
  {
    QuerySnapshot querySnapshot = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
    .orderBy(Record.STARTDATETIME)
    .getDocuments();
    var products = <Record>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0)
    {
      return products;
    }
    for (DocumentSnapshot doc in querySnapshot.documents)
    {
      products.add(Record.deserialize(doc.data, doc.documentID));
    }
    return products;
  } catch(e)
  {
    print("cannot read ++++++" + e.toString());
    throw e;
  }
}
static Future<List<Record>> getListDateHighToLow(String uid) async
{
try
  {
    QuerySnapshot querySnapshot = await Firestore.instance
    .collection(Record.RECORD_COLLECTION)
    .orderBy(Record.STARTDATETIME,descending: true)
    .getDocuments();
    var products = <Record>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0)
    {
      return products;
    }
    for (DocumentSnapshot doc in querySnapshot.documents)
    {
      products.add(Record.deserialize(doc.data, doc.documentID));
    }
    return products;
  } catch(e)
  {
    print("cannot read ++++++" + e.toString());
    throw e;
  }
}


/*static Future<List<Product>> getProductsSharedWithME(String email) async
{
  try
  {
    QuerySnapshot querySnapshot = await Firestore.instance
    .collection(Book.BOOKSCOLLECTION)
    .where(Book.SHAREDWITH, arrayContains: email)
    .orderBy(Book.CREATEDBY)
    .orderBy(Book.LASTUPDATEAT)
    .getDocuments();
    var books = <Book>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0)
    {
      return books;
    }
    for (DocumentSnapshot doc in querySnapshot.documents)
    {
      books.add(Book.deserialize(doc.data, doc.documentID));
    }
    return books;
  } catch(e)
  {
throw e;
  }
}*/

static void signOut()
{
  FirebaseAuth.instance.signOut();
}
}