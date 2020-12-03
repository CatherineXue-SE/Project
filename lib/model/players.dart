
class Players
{

String player1f;
String player2f;
String player1l;
String player2l;
String gameid;

Players(
{ 
  this.player1f,
  this.player1l,
  this.player2f,
  this.player2l,
  this.gameid,}
);
Players.empty()
{
   this.player1f = '';
   this.player1l = '';
   this.player2f = '';
   this.player2l = '';
   this.gameid = '';
}

Map<String, dynamic> serialize() 
{

return <String,dynamic>{
PLAYER1f: player1f,
PLAYER1l: player1l,
PLAYER2f: player2f,
PLAYER2l: player2l,
GAMEID: gameid,
  };
}

static Players deserialize(Map<String, dynamic> document, String documentID)
{
  return Players
  (
    player1f: document[PLAYER1f],
    player1l: document[PLAYER1l],
    player2f: document[PLAYER2f],
    player2l: document[PLAYER2l],
    gameid: document[GAMEID],


  );
}

static const RECORD_COLLECTION = 'playerslist';
static const PLAYER1f = 'player1f';
static const PLAYER1l = 'player1l';

static const PLAYER2f = 'player2f';
static const PLAYER2l = 'player2l';

static const GAMEID = 'gameid';

}