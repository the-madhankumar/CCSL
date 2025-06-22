import 'package:app/StartGame/toss.dart';
import 'package:app/dataStructure.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class Addplayer extends StatefulWidget {
  final int overs;
  const Addplayer({Key? key, required this.overs}) : super(key: key);

  @override
  State<Addplayer> createState() => _AddplayerState();
}

class _AddplayerState extends State<Addplayer> {
  final TextEditingController _playerController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();

  bool isCreating = true;
  int? generatedGameId;
  late int overs;

  @override
  void initState() {
    super.initState();
    overs = widget.overs;
  }

  Future<void> handleStartGame() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final db = FirebaseDatabase.instance;
    String playerName = _playerController.text.trim();

    print("Overs: $overs");

    if (playerName.isEmpty) {
      showSnack("Please enter your name");
      return;
    }

    if (isCreating) {
      int gameId = 100000 + math.Random().nextInt(900000);
      setState(() => generatedGameId = gameId);

      final game = Game(
        gameId: '$gameId',
        status: 'started',
        winner: null,
        players: {
          'uid1': Player(
            name: playerName,
            currentCard: '',
            score: 0,
            isDone: false,
          ),
          'uid2': Player(name: '', currentCard: '', score: 0, isDone: false),
        },
      );

      await db.ref('games/$gameId').set(game.toJson());

      await Clipboard.setData(ClipboardData(text: '$gameId'));
      showSnack("Game ID copied to clipboard!");

      await Future.delayed(Duration(seconds: 1));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => FlipTossPage(
                gameId: '$gameId',
                playerName: playerName,
                overs: overs,
              ),
        ),
      );
    } else {
      String gameId = _gameIdController.text.trim();
      if (gameId.isEmpty) {
        showSnack("Please enter Game ID");
        return;
      }

      final ref = db.ref('games/$gameId');
      final snapshot = await ref.get();

      if (!snapshot.exists) {
        showSnack("Game ID not found!");
        return;
      }

      await ref.child('players/uid2').update({'name': playerName});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => FlipTossPage(
                gameId: '$gameId',
                playerName: playerName,
                overs: overs,
              ),
        ),
      );
    }
  }

  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: const Color(0xFFD13737),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1),
                Text(
                  isCreating ? 'Create Room' : 'Join Room',
                  style: GoogleFonts.judson(
                    fontSize: screenHeight * 0.06,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Toggle Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    toggleButton(
                      'Create Room',
                      true,
                      screenWidth,
                      screenHeight,
                    ),
                    SizedBox(width: 16),
                    toggleButton('Join Room', false, screenWidth, screenHeight),
                  ],
                ),
                SizedBox(height: 30),

                TextContainer(
                  screenWidth,
                  screenHeight,
                  text: 'Enter your name',
                  Controll: _playerController,
                ),

                if (!isCreating)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextContainer(
                      screenWidth,
                      screenHeight,
                      text: 'Enter Game ID',
                      Controll: _gameIdController,
                    ),
                  ),

                if (generatedGameId != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Your Game ID: $generatedGameId',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),

                SizedBox(height: 40),

                GestureDetector(
                  onTap: handleStartGame,
                  child: _bigContainer(
                    screenWidth,
                    screenHeight,
                    text: isCreating ? 'Create & Start Game' : 'Join Game',
                    color: const Color(0xFFD19837),
                    height_: 0.08,
                    width_: 0.7,
                    font_size: 0.06,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget toggleButton(
    String text,
    bool creationValue,
    double screenWidth,
    double screenHeight,
  ) {
    return GestureDetector(
      onTap: () => setState(() => isCreating = creationValue),
      child: _bigContainer(
        screenWidth,
        screenHeight,
        text: text,
        color:
            isCreating == creationValue
                ? const Color(0xFFAA8020)
                : const Color(0xFFD19837),
        height_: 0.07,
        width_: 0.35,
        font_size: 0.05,
      ),
    );
  }
}

Widget TextContainer(
  double screenWidth,
  double screenHeight, {
  required String text,
  required TextEditingController Controll,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFD19837),
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextField(
      controller: Controll,
      style: GoogleFonts.judson(fontSize: 20, color: Colors.white),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
      cursorColor: Colors.white,
    ),
  );
}

Widget _bigContainer(
  double screenWidth,
  double screenHeight, {
  String text = '',
  Color color = const Color(0xFFD19837),
  double height_ = 0,
  double width_ = 0,
  double font_size = 0,
  Border? border,
  VoidCallback? onTap,
}) {
  return Container(
    height: screenHeight * height_,
    width: screenWidth * width_,
    decoration: BoxDecoration(
      color: color,
      border: border,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: GoogleFonts.judson(
          fontSize: screenWidth * font_size,
          color: const Color(0xFFD9D9D9),
        ),
      ),
    ),
  );
}
