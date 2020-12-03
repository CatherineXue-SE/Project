
class Record
{

String player1;
String player2;
String gameid;
String startdatetime;
String enddatetime;
String gamemode;
String winner;
String ai;
List<dynamic> steps;
List<dynamic> finalboard;

Record(
{ 
  this.player1,
  this.player2,
  this.gameid,
  this.startdatetime,
  this.enddatetime,
  this.gamemode,
  this.winner,
  this.ai,
  this.steps,
  this.finalboard}
);
Record.empty()
{
   this.player1 = '';
   this.player2 = '';
   this.gameid = '';
   this.startdatetime = '';
   this.enddatetime = '';
   this.gamemode = '3';
   this.winner = '';
   this.ai = 'off';
   this.steps = <dynamic>[];
   this.finalboard = <dynamic>[];
}

Record.clone(Record r)
{
  this.player1 = r.player1;
  this.player2 = r.player2;
  this.gameid = r.gameid;
  this.startdatetime = r.startdatetime;
  this.enddatetime = r.enddatetime;
  this.gamemode = r.gamemode;
  this.winner = r.winner;
  this.ai = r.ai;
  this.steps = <dynamic>[]..addAll(r.steps);
  this.finalboard = <dynamic>[]..addAll(r.finalboard);

}

Map<String, dynamic> serialize() 
{

return <String,dynamic>{
PLAYER1: player1,
PLAYER2: player2,
GAMEID: gameid,
STARTDATETIME: startdatetime,
ENDDATETIME: enddatetime,
GAMEMODE: gamemode,
WINNER: winner,
AI: ai,
STEPS: steps,
FINALBOARD: finalboard
  };
}

static Record deserialize(Map<String, dynamic> document, String documentID)
{
  return Record
  (
    player1: document[PLAYER1],
    player2: document[PLAYER2],
    gameid: document[GAMEID],
    startdatetime: document[STARTDATETIME],
    enddatetime: document[ENDDATETIME],
    gamemode: document[GAMEMODE],
    winner:  document[WINNER],
    ai: document[AI],
    steps:  document[STEPS],
    finalboard: document[FINALBOARD]

  );
}

static const RECORD_COLLECTION = 'recordlist';
static const PLAYER1 = 'player1';
static const PLAYER2 = 'player2';
static const GAMEID = 'gameid';
static const STARTDATETIME = 'startdatetime';
static const ENDDATETIME = 'enddatetime';
static const GAMEMODE = 'gamemode';
static const WINNER = 'winner';
static const AI = 'ai';
static const STEPS = 'steps';
static const FINALBOARD = 'finalboard';
}