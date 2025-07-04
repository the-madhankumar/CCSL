import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../GamePage/BattingPage.dart';

class FlipTossPage extends StatefulWidget {
  final String gameId;
  final String playerName;
  final int overs;

  const FlipTossPage({
    Key? key,
    required this.gameId,
    required this.playerName,
    required this.overs,
  }) : super(key: key);

  @override
  State<FlipTossPage> createState() => _FlipTossPageState();
}

class _FlipTossPageState extends State<FlipTossPage> {
  String _imageAsset = "assets/IMAGES/head.png";
  final Duration oneSec = const Duration(milliseconds: 60);
  final int numberOfFlips = 8;
  int _flipCount = 0;
  late Timer _flipTimer;
  bool _isFlipping = false;
  String _finalResult = "head";
  String? _userChoice;
  bool _isChoiceMade = false;
  bool _isResultCorrect = false;
  bool _flipCompleted = false;
  bool? _role;
  bool _hasSelectedBatOrBowl = false;

  late String gameId;
  late String playerName;
  late int overs;

  @override
  void initState() {
    super.initState();
    gameId = widget.gameId;
    playerName = widget.playerName;
    overs = widget.overs;
  }

  void _startFlipAnimation() {
    setState(() {
      _isFlipping = true;
    });

    final Random rand = Random();
    _finalResult = rand.nextBool() ? "head" : "tailsmini";
    _flipCount = 0;

    _flipTimer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _imageAsset =
            _imageAsset.contains("head")
                ? "assets/IMAGES/tailsmini.png"
                : "assets/IMAGES/head.png";
        _flipCount++;

        if (_flipCount >= numberOfFlips * 2) {
          _flipTimer.cancel();
          _isFlipping = false;
          _flipCompleted = true;

          _imageAsset =
              _finalResult == "head"
                  ? "assets/IMAGES/head.png"
                  : "assets/IMAGES/tailsmini.png";

          _isResultCorrect = _userChoice == _finalResult;
        }
      });
    });
  }

  Future<String> determinePlayerId() async {
    final db = FirebaseDatabase.instance;
    final gameRef = db.ref('games/$gameId/players');

    final uid1Snapshot = await gameRef.child('uid1/name').get();
    final uid2Snapshot = await gameRef.child('uid2/name').get();

    if (uid1Snapshot.exists && uid1Snapshot.value.toString() == playerName) {
      return 'uid1';
    }

    if (uid2Snapshot.exists && uid2Snapshot.value.toString() == playerName) {
      return 'uid2';
    }

    throw Exception("Could not determine player ID.");
  }

  @override
  void dispose() {
    if (_flipTimer.isActive) _flipTimer.cancel();
    super.dispose();
  }

  Widget _buildChoiceButtons() {
    return Column(
      children: [
        const Text(
          "Choose Heads or Tails",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionButton("Heads", "head"),
            const SizedBox(width: 20),
            _buildOptionButton("Tails", "tailsmini"),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionButton(String label, String value) {
    return ElevatedButton(
      onPressed:
          _isChoiceMade || _isFlipping || !_hasSelectedBatOrBowl
              ? null
              : () {
                setState(() {
                  _userChoice = value;
                  _isChoiceMade = true;
                });
                _startFlipAnimation();
              },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFFD13737),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBatOrBowlButtonsBeforeToss() {
    return Column(
      children: [
        const Text(
          "Select Bat or Bowl before Toss",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInitialBatBowlButton("Bat", true),
            const SizedBox(width: 20),
            _buildInitialBatBowlButton("Bowl", false),
          ],
        ),
      ],
    );
  }

  Widget _buildInitialBatBowlButton(String choice, bool roleValue) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _role = roleValue;
          _hasSelectedBatOrBowl = true;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        choice,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFFD13737),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLetsGoButton() {
    if (!_flipCompleted || _role == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () async {
        String playerId = await determinePlayerId();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => BattingGamePage(
                  GameId: gameId,
                  over: overs,
                  currentInnings: 1,
                  role: _role!,
                  playerId: playerId,
                ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'Let\'s Go',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFD13737),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD13737),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(_imageAsset, width: 150, height: 150),
            const SizedBox(height: 20),
            if (!_hasSelectedBatOrBowl) _buildBatOrBowlButtonsBeforeToss(),
            if (_hasSelectedBatOrBowl && !_isChoiceMade) _buildChoiceButtons(),
            const SizedBox(height: 20),
            if (_isChoiceMade && _flipCompleted)
              Text(
                "Result: ${_finalResult == 'head' ? 'Heads' : 'Tails'}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 30),
            _buildLetsGoButton(),
          ],
        ),
      ),
    );
  }
}
