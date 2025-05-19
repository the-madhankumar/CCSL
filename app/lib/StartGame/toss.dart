import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coin Toss',
      home: CoinToss(),
    );
  }
}

class CoinToss extends StatefulWidget {
  const CoinToss({super.key});

  @override
  State<CoinToss> createState() => _CoinTossState();
}

class _CoinTossState extends State<CoinToss>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isHeads = true;
  bool _isAnimating = false;
  String? _userChoice; // 'Heads' or 'Tails'
  String? _resultMessage;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation =
        Tween(begin: 0.0, end: pi).animate(_animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _isHeads = Random().nextBool();
              String actualResult = _isHeads ? 'Heads' : 'Tails';
              setState(() {
                _isAnimating = false;
                _resultMessage =
                    (_userChoice == actualResult)
                        ? 'You guessed right! It\'s $actualResult.'
                        : 'Oops! You guessed $_userChoice, but it\'s $actualResult.';
              });
              _animationController.reset();
            }
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation(String choice) {
    if (!_isAnimating) {
      setState(() {
        _isAnimating = true;
        _userChoice = choice;
        _resultMessage = null;
      });
      _animationController.forward();
    }
  }

  Widget _buildCoin() {
    return Transform(
      transform: Matrix4.rotationY(_animation.value),
      alignment: Alignment.center,
      child: Image.asset(
        _isHeads ? 'assets/IMAGES/head.jpeg' : 'assets/IMAGES/tail.jpeg',
        width: 150,
        height: 150,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coin Toss')),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isAnimating
                ? _buildCoin()
                : Column(
                  children: [
                    Text(
                      'Choose Heads or Tails',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _startAnimation('Heads'),
                          child: Text('Heads'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => _startAnimation('Tails'),
                          child: Text('Tails'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (_resultMessage != null) ...[
                      Text(
                        _resultMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              _resultMessage!.contains('right')
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartGamePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          'Start Game',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ],
                ),
          ],
        ),
      ),
    );
  }
}

class StartGamePage extends StatelessWidget {
  const StartGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Start Game')),
      body: Center(
        child: Text(
          'Game Started!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
