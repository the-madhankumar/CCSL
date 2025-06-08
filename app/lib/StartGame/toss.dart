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
  bool _isFlipping = true;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _finalResult = "head";

  @override
  void initState() {
    super.initState();
    _playSound();
    _startFlipAnimation();
  }

  void _playSound() async {
    await _audioPlayer.play(AssetSource('audio/coinflip1.mp3'));
  }

  void _startFlipAnimation() {
    final Random rand = Random();
    _finalResult = rand.nextBool() ? "head" : "tailsmini";

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
          _imageAsset =
              _finalResult == "head"
                  ? "assets/IMAGES/head.png"
                  : "assets/IMAGES/tailsmini.png";
        }
      });
    });
  }

  @override
  void dispose() {
    _flipTimer.cancel();
    _audioPlayer.dispose();
    super.dispose();
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
            if (!_isFlipping)
              Text(
                "Result: ${_finalResult == "head" ? "Heads" : "Tails"}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 30),
            if (!_isFlipping)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Let\'s Go',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD13737),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
