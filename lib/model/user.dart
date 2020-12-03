
class User
{
String email;
String password;
String fname;
String lname;
String uid;
String lastupdate;
String photourl;
User(
{ 
  this.email,
  this.password,
  this.fname,
  this.lname,
  this.uid,
  this.photourl,
  this.lastupdate}
);

Map<String, dynamic> serialize() 
{

return <String,dynamic>{
EMAIL: email,
FNAME: fname,
LNAME: lname,
UID: uid,
PHOTOURL: photourl,
LASTUPDATE:lastupdate,
  };
}

static User deserialize(Map<String, dynamic> document)
{
  return User
  (email: document[EMAIL],
  lname:  document[LNAME],
  fname:  document[FNAME],
  uid: document[UID],
  photourl: document[PHOTOURL],
  lastupdate: document[LASTUPDATE]);  
}

static var subuserlist = List<User>();
static const PROFILE_COLLECTION = 'userprofile';
static const EMAIL = 'email';
static const FNAME = 'fname';
static const LNAME = 'lname';
static const UID = 'uid';
static const PHOTOURL = 'photourl';
static const LASTUPDATE = 'lastupdate';
}