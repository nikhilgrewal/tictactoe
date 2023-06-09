import 'package:flutter/material.dart';
import 'package:tictactoe/game_button.dart';
import 'package:tictactoe/custom_dialogue.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonlist;
  var player1;
  var player2;
  var activePlayer;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    buttonlist = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

// button pressing action
  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.blue;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "O";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkwinner();
      if (winner == -1) {
        if (buttonlist.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => new CustomDialogue("Game Drawn",
                  "Press the reset button to play again", resetGame));
        }
      }
    });
  }

  int checkwinner() {
    var winner = -1; // 1 2 3 ->row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    // 4 5 6->row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    // row 3-> 7 8 9
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    // column 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    // col 2
    if (player1.contains(5) && player1.contains(2) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(5) && player2.contains(2) && player2.contains(8)) {
      winner = 2;
    }
    // col 3
    if (player1.contains(9) && player1.contains(6) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(9) && player2.contains(6) && player2.contains(3)) {
      winner = 2;
    }
    // diagonal 1
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    // diagonal 2
    if (player1.contains(7) && player1.contains(5) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(5) && player2.contains(3)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialogue("Hurray!!!, Player 1 won",
                " Press reset to play again", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialogue("Hurray!!!, Player 2 won",
                " Press reset to play again", resetGame));
      }
    }
    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonlist = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: const Text(
          "Tic Tac Toe",
        ), // textAlign: TextAlign.center,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 151, 139, 27),
              Color.fromARGB(255, 215, 70, 59)
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 6.0,
                        mainAxisSpacing: 9.0),
                    itemCount: buttonlist.length,
                    itemBuilder: ((context, index) => new SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              // onPressed: null,
                              onPressed: buttonlist[index].enabled
                                  ? () => playGame(buttonlist[index])
                                  : null,

                              child: new Text(
                                buttonlist[index].text,
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonlist[index].bg,
                                  disabledBackgroundColor:
                                      buttonlist[index].bg),
                            ),
                          ),
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new ElevatedButton(
                child: new Text("Reset"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(10.0),
                    textStyle: const TextStyle(fontSize: 25)),
                onPressed: resetGame,
              ),
            ),
          ],
        ),
      ),
      // button
    );
  }
}
