import 'dart:async';
import 'dart:math';
import 'package:Project/controller/myfirebase.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import 'package:flutter/cupertino.dart';
import '../model/record.dart';
import '../view/gamepage.dart';

class GamePageController 
{
  GamePageState state;
  GamePageController(this.state);
  String player = 'x', opponent = 'o'; 
  int score  = 0;
  int count = 0;
  // ignore: non_constant_identifier_names
  playGame(int index) async {
            
            if (state.record.finalboard[index] == "-") {
            state.stateChanged(()
            {
            state.record.finalboard[index] = opponent;     
            state.record.steps.add(index.toString() + '-' + opponent);
            });
                        print(  state.record.steps);

           if(checkWin(state.record.finalboard, opponent))
            {
                state.stateChanged(()
            {
              state.img = "You Win!";               print('31');
            });
              state.record.winner = opponent;
             await updateRecord(state.record);
            }
             else
          {
            if(isFull( state.record.finalboard))
            {
               if(checkWin(state.record.finalboard, player))
               {
                     state.img = "You Lost!";               print('42');
                   state.record.winner = player;
             await updateRecord(state.record);
                 }
                 else
                   {
                   state.img = "TIE!";               print('48');
             await updateRecord(state.record);
                    }
              }
          else
          {
            int move =  findBestMove(state.record.finalboard);   
            state.record.finalboard[move] = player;
            state.record.steps.add(move.toString() + '-' + player);
            print(  state.record.steps);
          if(checkWin(state.record.finalboard, player))
          {
            state.img = "You Lost!";
            state.record.winner = player;
                           print('62');
             await updateRecord(state.record);
          }
          else if(isFull(state.record.finalboard))
            {
               state.img = "TIE!";
               print('68');
             await updateRecord(state.record);

            }
            }
           
          }
             }

/*
      state.stateChanged(()
          {
         if (state.record.finalboard[index] == "-") {
          state.record.finalboard[index] = opponent;
            if(checkWin(state.record.finalboard, opponent))
            {
              state.img = "You Win!";
              updateRecord(state.record);
            }
          else
          {
            if(isFull( state.record.finalboard))
            {
               if(checkWin(state.record.finalboard, player))
               {
                     state.img = "You Lost!";

                 }
                 else
                   {
                   state.img = "TIE!";
                    }
              }
          else
          {
              int move =  findBestMove(state.record.finalboard);   
            print(move.toString());
            state.record.finalboard[move] = player;
          if(checkWin(state.record.finalboard, player))
          {
            state.img = "You Lost!";
          }
          else if(isFull( state.record.finalboard))
            {
               state.img = "TIE!";
            }
            }
           
          }
         
        //  print(move.toString());
        }
        else {
          //state.record.finalboard[index] = "x";
        }
       });*/

        //this.checkWin();  
  }

  void updateRecord(Record record) async{
    DateTime now = DateTime.now();
    record.enddatetime = now.toString().substring(0,16);                 
         record.gameid =  await MyFirebase.addRecord(record);
         print(record.gameid);
                     await MyFirebase.updateRecord(record);
  }
  int findBestMove(List<dynamic> currentboard) 
{ 
    int bestVal = -1000; 
    int bestMoverow = -1;  
    int bestMovecolumn = -1;  
     List<List<String>> board ;
      if(currentboard.length == 9)
    {
    board = [
    [currentboard[0],currentboard[1],currentboard[2]],
    [currentboard[3],currentboard[4],currentboard[5]],
  [currentboard[6],currentboard[7],currentboard[8]],
    ];
      for (int i = 0; i < 3; i++) 
    { 
        for (int j = 0; j < 3; j++) 
        { 
            // Check if cell is empty 
            if (board[i][j] == '-') 
            { 
                // Make the move 
                board[i][j] = player; 
                // compute evaluation function for this 
                // move. 
                int moveVal = minimax(board, 1, false); 
                
                // Undo the move 
                board[i][j] = '-'; 
                print("i : " + i.toString() + " j: " + j.toString() + board.toString());
                print("moveVal = " + moveVal.toString());
                if (moveVal > bestVal) 
                { 
                    bestMoverow= i; 
                    bestMovecolumn = j; 
                    bestVal = moveVal;
        
                } 
            } 
        }
                
 
    } 
      print("final moveVal = " + bestVal.toString());
      print(bestMoverow.toString() + ', ' + bestMovecolumn.toString());
      print("moveplace = " + returnonevalue(bestMoverow,bestMovecolumn,currentboard.length).toString());
    } 
      if(currentboard.length == 16)
    {
   board = 
    [[currentboard[0],currentboard[1],currentboard[2],currentboard[3]],
    [currentboard[4],currentboard[5],currentboard[6],currentboard[7]],
    [currentboard[8],currentboard[9],currentboard[10],currentboard[11]],
    [currentboard[12],currentboard[13],currentboard[14],currentboard[15]]];
     for (int i = 0; i < 4; i++) 
    { 
        for (int j = 0; j < 4; j++) 
        { 
            // Check if cell is empty 
            if (board[i][j] == '-') 
            { 
                // Make the move 
                board[i][j] = player; 
                // compute evaluation function for this 
                // move. 
                int moveVal = minimax(board, 1, false); 
  
                // Undo the move 
                board[i][j] = '-'; 
                if (moveVal > bestVal) 
                { 
                    bestMoverow= i; 
                    bestMovecolumn = j; 
                    bestVal = moveVal; 
                } 
            } 
            
        } 
      print(board.toString());
      print("moveVal = " + bestVal.toString());
      print(bestMoverow.toString() + ', ' + bestMovecolumn.toString());
      print("moveplace = " + returnonevalue(bestMoverow,bestMovecolumn,currentboard.length).toString());

    } 

    }
    return returnonevalue(bestMoverow,bestMovecolumn,currentboard.length); 
} 
int returnonevalue(int movea, int moveb, int boradlength)
{
  if(boradlength == 9)
  {
if (movea ==0 )
  {
    return moveb;
  }
  else if (movea == 1)
  {
    return moveb+3;
  }
   else if (movea == 2)
  {
    return moveb + 6;
  }
  }
  else if (boradlength == 16)
  {
    if (movea ==0 )
  {
    return moveb;
  }
  else if (movea == 1)
  {
    return moveb+4;
  }
   else if (movea == 2)
  {
       return moveb + 8;

  }
     else if (movea == 3)
  {
        return moveb + 12;

  }
  else
  {
    print(movea.toString() + ' ' + moveb.toString());
    return 0;
  }
  }
  
  
}
// This is the evaluation function as discussed 
// in the previous article ( http://goo.gl/sJgv68 ) 
int evaluate(List<dynamic>currentstate,String player) 
{ 
  /*String opponent = 'o';
    if(playermark == 'x')
    {
      opponent = 'o';
    }*/
        //print(currentstate.length.toString());
    //print(player.toString());

      //  List<List<String>> board = [] ;
     if(currentstate.length == 3)
    {
   /* board.addAll(
    [[currentstate[0],currentstate[1],currentstate[2]],
    [currentstate[3],currentstate[4],currentstate[5]],
  [currentstate[6],currentstate[7],currentstate[8]]],
    );*/
      for (int row = 0; row<3; row++) 
    {
        if (currentstate[row][0]==currentstate[row][1] && 
            currentstate[row][1]==currentstate[row][2]) 
        { 
            if (currentstate[row][0]==player) 
                return 10; 
            else if (currentstate[row][0]==opponent) 
                print("not good + " + currentstate.toString());
                return -10; 
        } 
    } 
    // Checking for Columns for X or O victory. 
    for (int col = 0; col<3; col++) 
    { 
        if (currentstate[0][col]==currentstate[1][col] && 
            currentstate[1][col]==currentstate[2][col]) 
        { 
            if (currentstate[0][col]==player) 
                return 10; 
  
            else if (currentstate[0][col]==opponent) 
                print("not good + " + currentstate.toString());
                return -10; 
        } 
    } 
    if (currentstate[0][0]== currentstate[1][1] && currentstate[1][1]==currentstate[2][2]) 
    { 
        if (currentstate[0][0]==player) 
            return 10; 
        else if (currentstate[0][0]==opponent) 
            return -10; 
    } 
  
    if (currentstate[0][2]==currentstate[1][1] && currentstate[1][1]==currentstate[2][0]) 
    { 
        if (currentstate[0][2]==player) 
            return 10; 
        else if (currentstate[0][2]==opponent) 
            return -10; 
    } 

    }
    else
    {
    if(currentstate.length == 4)
    {
      for (int row = 0; row<4; row++) 
    { 
        if (currentstate[row][0]==currentstate[row][1] && 
            currentstate[row][1]==currentstate[row][2]&&
            currentstate[row][2]==currentstate[row][3]) 
        { 
            if (currentstate[row][0]==player) 
                return 10; 
            else if (currentstate[row][0]==opponent) 
                return -10; 
        } 
    } 
    // Checking for Columns for X or O victory. 
    for (int col = 0; col<4; col++) 
    { 
        if (currentstate[0][col]==currentstate[1][col] && 
            currentstate[1][col]==currentstate[2][col]&&
            currentstate[2][col]==currentstate[3][col]
) 
        { 
            if (currentstate[0][col]==player) 
                return 10; 
  
            else if (currentstate[0][col]==opponent) 
                return -10; 
        } 
    }
    if (currentstate[0][0]== currentstate[1][1] && currentstate[1][1]==currentstate[2][2]&& currentstate[3][3]==currentstate[3][3]) 
    { 
        if (currentstate[0][0]==player) 
            return 10; 
        else if (currentstate[0][0]==opponent) 
            return -10; 
    } 
    if (currentstate[0][3]==currentstate[1][2] && currentstate[1][2]==currentstate[2][1]&&currentstate[2][1]==currentstate[3][0]) 
    { 
        if (currentstate[0][3]==player) 
            return 10; 
        else if (currentstate[0][3]==opponent) 
            return -10; 
    }  
    }
    }
        return 0; 
} 


  bool isMovesLeft(List<dynamic>board) 
{ 
  for (int i = 0; i < board.length; i++) 
        for (int j = 0; j < 3; j++) 
            if (board[i][j] == '-') 
                return true; 
    return false;
} 
  bool isFull(List<dynamic>board) 
{ 
  for (int i = 0; i < board.length; i++) 
  {
            if (board[i] == '-') 
            {
                return false; 
            }
  }
    return true;
} 
int minimax(List<dynamic>board, int depth, bool isMax) 
{ 
    int score = evaluate(board,player); 
    // If Maximizer has won the game return his/her 
    // evaluated score 
    if (score == 10) 
      {
        return score; }
    // If Minimizer has won the game return his/her 
    // evaluated score 
    if (score == -10) 
    {
        return score; 
    }
    // If there are no more moves and no winner then 
    // it is a tie 
    if (isMovesLeft(board)==false)
    {
        return 0; 
    }
    // If this maximizer's move 
    if (isMax) 
    { 
        int best = -1000; 
        for (int i = 0; i<board.length; i++) 
        { 
           for (int j = 0; j < board.length; j++) 
            { 
                // Check if cell is empty 
                if (board[i][j]=='-') 
                { 
                    // Make the move 
                    board[i][j] = player; 
                    best = 0;
                    //best = max( best, minimax(board, depth+1, !isMax) ); 
                    board[i][j] = '-';            
                 } 
            }
        } 
        return best; 
    } 
  
    // If this minimizer's move 
    else
    { 
        int best = 1000; 
        // Traverse all cells 
        for (int i = 0; i<board.length; i++) 
        { 
           // Check if cell is empty 
                 for (int j = 0; j < board.length; j++) 
            { 
                // Check if cell is empty 
                if (board[i][j]=='-') 
                { 
                    board[i][j] = opponent;
                    best = min(best, minimax(board, depth+1, !isMax)); 
                    board[i][j] = '-'; 
                }
            } 
            
            }
            return best;   
    } 
} 
  
String gamestate(int index)
{

}
  bool checkWin(List<dynamic>gameState,String playerx) {


        if(gameState.length == 9)
        {
    List<List<String>> winState3 = [
        [gameState[0], gameState[1], gameState[2]],
        [gameState[3], gameState[4], gameState[5]],
        [gameState[6], gameState[7], gameState[8]],
        [gameState[0], gameState[4], gameState[8]],
        [gameState[2], gameState[4], gameState[6]],
         [gameState[0], gameState[3], gameState[6]],
        [gameState[1], gameState[4], gameState[7]],
        [gameState[2], gameState[5], gameState[8]],
        ];
        for (int i =0;i<winState3.length;i++)
        {
          if(winState3[i][0]== playerx && winState3[i][1]== playerx && winState3[i][2]== playerx)
          {
            return true;
          }
        }
        }
        else
        {
    List<List<String>> winState4 = [
        [gameState[0], gameState[1], gameState[2],gameState[3]],
        [gameState[4], gameState[5],gameState[6], gameState[7]],
        [gameState[8], gameState[9], gameState[10],gameState[11]],
        [gameState[12], gameState[13], gameState[14],gameState[15]],
        [gameState[0], gameState[5], gameState[10],gameState[15]],
        [gameState[3], gameState[6], gameState[9],gameState[12]],
        [gameState[0], gameState[4], gameState[8],gameState[12]],
        [gameState[1], gameState[5],gameState[9], gameState[13]],
        [gameState[2], gameState[6], gameState[10],gameState[14]],
        [gameState[3], gameState[7], gameState[11],gameState[15]],
        ];
           for (int i =0;i<winState4.length;i++)
        {
          if(winState4[i][0]== playerx && winState4[i][1]== playerx && winState4[i][2]== playerx && winState4[i][3]== playerx)
          {
            return true;
          }
        }
        }
        return false;

      
  }
void startTimer() {
  // Start the periodic timer which prints something every 1 seconds
  var timer=  new Timer.periodic(new Duration(seconds: 1), (time) {
  count = count + 1;   
  print(count.toString());
  });
}

}
