import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  String player1;
  String player2;
  GameScreen({ this.player1, this.player2});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
 /* List<String> _board; */
  String _currentPlayer;
  String _winner = "";
  bool _gameOver;
  bool _turnOfO = false;
  int _filledBoxes = 0;
  var _opacity = 1.0;
  var _animationDuration = Duration(milliseconds: 900);


 Widget _buildGrid(){
   return Expanded(
     flex: 3,
     child: GridView.builder(
       itemCount: 9,
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 3
         ),
         itemBuilder: (BuildContext context, int index){
         return GestureDetector(
           onTap: (){
            _tapped(index);
           },
           child: Container(


           ),
         );
         }
     ),

   );
 }
 Widget _buildTurn(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _turnOfO ? 'Turn of O' : 'Turn of X',


          )
          ,
        ),
      ),
    );
 }

  void _resetGame(){
    setState(() {
      _winner = "";
      for (int i = 0; i<9; i++){
        _board[i] = '';

      }
_filledBoxes =  0;
     /* _board = List.generate(3, (_) => List.generate(3,(_) => ""));
      _currentPlayer ="X";
      _winner = "";
      _gameOver = false;
*/
    });
  }
  final List<String> _board = ['','','','','','','','','',];

@override
  void initState() {
  _currentPlayer = 'x';
    super.initState();
  }

  void _tapped(int index){
    setState(() {
      if (_turnOfO && _board[index] == ''){
        _board[index] = 'o';
        _filledBoxes += 1;
      }else if (!_turnOfO && _board[index] == ''){
        _board[index] = 'x';
        _filledBoxes += 1;
      }
      _turnOfO =! _turnOfO;
      _makeMove();
    });
  }

  void _makeMove(){


      if(_board[0] == _board[1] && _board[0] == _board[2] && _board[0] != ''){
        _winner = _currentPlayer;
        _gameOver = true;
      }else if(
      _board[3] == _board[4] && _board[3] == _board[5] && _board[3] != '') {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      else if(
      _board[6] == _board[7] && _board[6] == _board[8] && _board[6] != '') {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      else if(
      _board[0] == _board[3] && _board[0] == _board[6] && _board[0] != '') {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      else if(
      _board[1] == _board[4] && _board[1] == _board[7] && _board[1] != '') {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      else if(
      _board[2] == _board[5] && _board[2] == _board[8] && _board[2] != '') {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      else if(
      _board[0] == _board[4] && _board[0] == _board[8] && _board[0] != '') {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      else if(
      _board[2] == _board[4] && _board[2] == _board[6] && _board[2] != '') {
        _winner = _currentPlayer;
        _gameOver = true;
      }
      else if(_filledBoxes == 9){
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("its a tie!"),
                actions: [
                  FlatButton(
                    child: Text("Play Again"),
                    onPressed: () {
                      _resetGame();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });

      /*  AwesomeDialog(context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Play Again",
            title: _winner == 'x' ? widget.player1 + "Won!" : _winner == 'o' ? widget.player2 + "Won!" : "It's a Tie",
            btnOkOnPress: (){
              _resetGame();
            })
          ..show(); */
      }
      _currentPlayer = _currentPlayer == 'x' ? 'o' : 'x';


      if(_winner != ""){
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("\" " + _winner + " \" is Winner!!!"),
                actions: [
                  FlatButton(
                    child: Text("Play Again"),
                    onPressed: () {
                      _resetGame();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
         /*   DialogDialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Play Again",
            barrierDismissible: false,
            title: _winner == 'x' ? widget.player1 + "Won!" : _winner == 'o' ? widget.player2 + "Won!" : "It's a Tie",
            btnOkOnPress: (){
              _resetGame();
            })
          ..show();
        */
      };

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFF071A40),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 90,),
            SizedBox(
              child: Column(
                children: [

                  AnimatedOpacity(opacity: _opacity, duration: _animationDuration),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turn: ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _currentPlayer == 'x'
                            ? widget.player1 + "($_currentPlayer)"
                            : widget.player2 + "($_currentPlayer)",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _currentPlayer == 'x'
                              ? Color(0xFFE25041)
                              :Color(0xFFFFDAE4),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF071A40),
                          borderRadius: BorderRadius.circular(10)

                      ),
                      margin: EdgeInsets.all(5),
                      child: GridView.builder(
                          itemCount: 9,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ), itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },



                          child: Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xFF253C59),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                _board[index],
                                style: TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.w700,
                                  color:_board[index] == 'x'
                                      ? Colors.redAccent
                                      : Colors.white,
                                  /* shadows: [
                                    Shadow(
                                      blurRadius: 40,
                                      color: _board[index] == 'x' ? Colors.blue,
                                    )
                                  ],*/

                                ),),

                            ),
                          ),
                        );

                      })
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
  }

