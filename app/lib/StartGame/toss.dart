import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../GamePage/page.dart';

class FlipTossPage extends StatefulWidget {
  const FlipTossPage({super.key});

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _finalResult = "head";
  String? _userChoice;
  bool _isChoiceMade = false;
  bool _isResultCorrect = false;
  String? _batOrBowl;
  bool _flipCompleted = false;

  void _playSound() async {
    await _audioPlayer.play(AssetSource('audio/coinflip1.mp3'));
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
        _imageAsset = _imageAsset.contains("head")
            ? "assets/IMAGES/tailsmini.png"
            : "assets/IMAGES/head.png";
        _flipCount++;

        if (_flipCount >= numberOfFlips * 2) {
          _flipTimer.cancel();
          _isFlipping = false;
          _flipCompleted = true;

          _imageAsset = _finalResult == "head"
              ? "assets/IMAGES/head.png"
              : "assets/IMAGES/tailsmini.png";

          _isResultCorrect = _userChoice == _finalResult;
        }
      });
    });
  }

  @override
  void dispose() {
    if (_flipTimer.isActive) _flipTimer.cancel();
    _audioPlayer.dispose();
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
      onPressed: _isChoiceMade || _isFlipping
          ? null
          : () {
              setState(() {
                _userChoice = value;
                _isChoiceMade = true;
              });
              _playSound();
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
            fontSize: 18, color: Color(0xFFD13737), fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBatOrBowlButtons() {
    return Column(
      children: [
        const Text(
          "You won! Choose to Bat or Bowl",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBatBowlButton("Bat"),
            const SizedBox(width: 20),
            _buildBatBowlButton("Bowl"),
          ],
        ),
      ],
    );
  }

  Widget _buildBatBowlButton(String choice) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _batOrBowl = choice;
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
            fontSize: 18, color: Color(0xFFD13737), fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLetsGoButton() {
    // Show only after flip is done
    if (!_flipCompleted) return const SizedBox.shrink();

    // If user won, require bat/bowl selection first
    if (_isResultCorrect && _batOrBowl == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GamePage(GameId: '123456', CurrentPlayer: 1, over: 2, currentInnings: 1,)),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Let\'s Go',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD13737)),
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
            if (!_isChoiceMade) _buildChoiceButtons(),
            if (_isChoiceMade && _flipCompleted)
              Text(
                "Result: ${_finalResult == "head" ? "Heads" : "Tails"}",
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            const SizedBox(height: 20),
            if (_flipCompleted && _isResultCorrect && _batOrBowl == null)
              _buildBatOrBowlButtons(),
            const SizedBox(height: 20),
            if (_flipCompleted && !_isResultCorrect)
              const Text(
                "You lost the toss!",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            const SizedBox(height: 30),
            _buildLetsGoButton(),
          ],
        ),
      ),
    );
  }
}

//completed
