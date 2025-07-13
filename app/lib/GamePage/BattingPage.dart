import 'package:app/GamePage/BowlingPage.dart';
import 'package:app/Result/page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class BattingGamePage extends StatefulWidget {
  final int over;
  final String GameId;
  final int currentInnings;
  final String playerId;
  const BattingGamePage({
    Key? key,
    required this.over,
    required this.GameId,
    required this.currentInnings,
    required this.playerId,
  }) : super(key: key);
  @override
  State<BattingGamePage> createState() => _BattingGamePageState();
}

class _BattingGamePageState extends State<BattingGamePage> {
  String card = '';
  String opponentCard = '';
  int score = 0;
  List<int> trackOver = [];

  late String currentId;
  late DatabaseReference ref;
  late String currentGameId;
  late int currentInnings;
  late bool role;
  late int over;

  @override
  void initState() {
    super.initState();

    currentId = widget.playerId;
    currentGameId = widget.GameId;
    ref = FirebaseDatabase.instance.ref(
      'games/$currentGameId/players/$currentId',
    );
    over = widget.over;
    currentInnings = widget.currentInnings;

    listenToOpponentChanges();
  }

  bool hasPlayed = false;
  Future<void> addCurrentCard(int currentBall) async {
    print("Current Batting Card $currentBall");
    if (hasPlayed) return;
    hasPlayed = true;

    setState(() {
      trackOver.add(currentBall);
      score += currentBall;
      card = '$currentBall.png';
    });

    updateCard(currentBall);

    final result = await checkCardsAndStatus();
    if (!result['bothDone']) {
      hasPlayed = false;
      return;
    }

    final db = FirebaseDatabase.instance;

    if (result['sameCard']) {
      print("\n");
      print("\n");
      print(
        "[MORE THAN LEO UPDATE] sameCard Appears when vicky senior on fire",
      );
      setState(() {
        score -= currentBall;
        trackOver.removeLast();
      });

      score -= currentBall;
      await ref.update({'score': score});

      await showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('OUT!'),
              content: const Text(
                'You are out. Both players chose the same card.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );

      if (currentInnings == 1) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => BowlingGamePage(
                  GameId: currentGameId,
                  over: widget.over,
                  currentInnings: 2,
                  playerId: currentId,
                ),
          ),
        );
      } else if (currentInnings == 2) {
        final ref1 = db.ref('games/$currentGameId/players/uid1');
        final ref2 = db.ref('games/$currentGameId/players/uid2');

        final snapshot1 = await ref1.child('score').get();
        final snapshot2 = await ref2.child('score').get();

        if (snapshot1.exists && snapshot2.exists) {
          final score1 = snapshot1.value as int;
          final score2 = snapshot2.value as int;

          String winner;
          if (score1 > score2) {
            final nameSnap = await ref1.child('name').get();
            winner = nameSnap.exists ? nameSnap.value.toString() : 'Player 1';
          } else if (score2 > score1) {
            final nameSnap = await ref2.child('name').get();
            winner = nameSnap.exists ? nameSnap.value.toString() : 'Player 2';
          } else {
            winner = 'Match Tied';
          }

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ResultPage(
                    score1: score1,
                    score2: score2,
                    winner: winner,
                  ),
            ),
          );
        }
      }

      hasPlayed = false;
      return;
    }

    await db.ref('games/$currentGameId/players/uid1').update({'isDone': false});
    await db.ref('games/$currentGameId/players/uid2').update({'isDone': false});

    if (trackOver.length >= over * 6) {
      score -= currentBall;
      await ref.update({'score': score});

      if (currentInnings == 1) {
        // String newPlayerId = currentId == 'uid1' ? 'uid2' : 'uid1';
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => BowlingGamePage(
                  GameId: currentGameId,
                  over: widget.over,
                  currentInnings: 2,
                  playerId: currentId,
                ),
          ),
        );
      } else if (currentInnings == 2) {
        final ref1 = db.ref('games/$currentGameId/players/uid1');
        final ref2 = db.ref('games/$currentGameId/players/uid2');

        final snapshot1 = await ref1.child('score').get();
        final snapshot2 = await ref2.child('score').get();

        if (snapshot1.exists && snapshot2.exists) {
          final score1 = snapshot1.value as int;
          final score2 = snapshot2.value as int;

          String winner;
          if (score1 > score2) {
            final nameSnap = await ref1.child('name').get();
            winner = nameSnap.exists ? nameSnap.value.toString() : 'Player 1';
          } else if (score2 > score1) {
            final nameSnap = await ref2.child('name').get();
            winner = nameSnap.exists ? nameSnap.value.toString() : 'Player 2';
          } else {
            winner = 'Match Tied';
          }

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ResultPage(
                    score1: score1,
                    score2: score2,
                    winner: winner,
                  ),
            ),
          );
        }
      }
    }

    hasPlayed = false;
  }

  void listenToOpponentChanges() {
    final db = FirebaseDatabase.instance;
    String opponentId = currentId == 'uid1' ? 'uid2' : 'uid1';
    DatabaseReference opponentRef = db.ref(
      'games/$currentGameId/players/$opponentId',
    );

    opponentRef.onChildChanged.listen((event) async {
      final key = event.snapshot.key;
      final value = event.snapshot.value;

      if (key == 'isDone') {
        print("🔄 Opponent isDone changed: $value");

        final result = await checkCardsAndStatus();

        if (result['bothDone']) {
          print("✅ Both players have completed their move");

          if (currentId == 'uid1') {
            setState(() {
              opponentCard = '${result['card2']}.png';
              card = '${result['card1']}.png';
            });
          } else {
            setState(() {
              opponentCard = '${result['card1']}.png';
              card = '${result['card2']}.png';
            });
          }

          if (result['sameCard'] && currentInnings == 1) {
            print("💥 Both players played the same card!");

            if (!context.mounted) return;
            DatabaseReference currentPlayerRef = db.ref(
              'games/$currentGameId/players/$currentId/',
            );

            final snapshot = await currentPlayerRef.child('currentCard').get();
            if (snapshot.exists) {
              final String cardStr = snapshot.value.toString();
              final int lastCardNumber = int.tryParse(cardStr) ?? 0;
              score -= lastCardNumber;
              await ref.update({'score': score});
            }

            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text('OUT!'),
                    content: const Text(
                      'You are out. Both players chose the same card.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BowlingGamePage(
                                    GameId: currentGameId,
                                    over: widget.over,
                                    currentInnings: 2,
                                    playerId: currentId,
                                  ),
                            ),
                          );
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          } else if (result['sameCard'] && currentInnings == 2) {
            final ref1 = db.ref('games/$currentGameId/players/uid1');
            final ref2 = db.ref('games/$currentGameId/players/uid2');

            final snapshot1 = await ref1.child('score').get();
            final snapshot2 = await ref2.child('score').get();

            if (snapshot1.exists && snapshot2.exists) {
              final score1 = snapshot1.value as int;
              final score2 = snapshot2.value as int;

              String winner;
              if (score1 > score2) {
                final nameSnap = await ref1.child('name').get();
                winner =
                    nameSnap.exists ? nameSnap.value.toString() : 'Player 1';
              } else if (score2 > score1) {
                final nameSnap = await ref2.child('name').get();
                winner =
                    nameSnap.exists ? nameSnap.value.toString() : 'Player 2';
              } else {
                winner = 'Match Tied';
              }

              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ResultPage(
                        score1: score1,
                        score2: score2,
                        winner: winner,
                      ),
                ),
              );
            }
          }

          await db.ref('games/$currentGameId/players/uid1').update({
            'isDone': false,
          });
          await db.ref('games/$currentGameId/players/uid2').update({
            'isDone': false,
          });

          print("♻️ isDone reset for both players");
        }
      }
    });
  }

  void updateCard(int currentBall) async {
    final db = FirebaseDatabase.instance;
    final ref = db.ref('games/$currentGameId/players/$currentId');

    print('🔄 Updating card for player: $currentId');
    print('🎯 Game ID: $currentGameId');
    print('🃏 Selected card: $currentBall');

    await ref.update({'currentCard': currentBall.toString(), 'isDone': true});

    print('✅ Updated Firebase: currentCard = $currentBall, isDone = true');
  }

  Future<Map<String, dynamic>> checkCardsAndStatus() async {
    final db = FirebaseDatabase.instance;

    final ref1 = db.ref('games/$currentGameId/players/uid1');
    final ref2 = db.ref('games/$currentGameId/players/uid2');

    final snapshot1 = await ref1.get();
    final snapshot2 = await ref2.get();

    if (snapshot1.exists && snapshot2.exists) {
      final data1 = Map<String, dynamic>.from(snapshot1.value as Map);
      final data2 = Map<String, dynamic>.from(snapshot2.value as Map);

      final isDone1 = data1['isDone'] as bool? ?? false;
      final isDone2 = data2['isDone'] as bool? ?? false;
      final card1 = data1['currentCard'] as String? ?? '';
      final card2 = data2['currentCard'] as String? ?? '';

      final bothDone = isDone1 && isDone2;
      final sameCard = card1 == card2;

      print("Both Done : $bothDone , Same Card $sameCard");
      return {
        'bothDone': bothDone,
        'sameCard': sameCard,
        'card1': card1,
        'card2': card2,
      };
    }

    return {'bothDone': false, 'sameCard': false, 'card1': '', 'card2': ''};
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print("current Innings : $currentInnings");
    print("[SCORE UPDATE]current Score : $score");

    return Scaffold(
      body: Container(
        color: const Color(0xFFD13737),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                _ContainerSet(screenWidth, screenHeight),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.12),
                  child: Row(
                    children: [
                      Container(
                        height: screenHeight * 0.20,
                        width: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD13737),
                          border: Border.all(
                            color: const Color(0xFF715018),
                            width: 7,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child:
                            opponentCard.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/IMAGES/$opponentCard',
                                    fit: BoxFit.contain,
                                  ),
                                )
                                : const SizedBox.shrink(),
                      ),
                      SizedBox(width: screenWidth * 0.05),

                      Container(
                        height: screenHeight * 0.20,
                        width: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD13737),
                          border: Border.all(
                            color: const Color(0xFF715018),
                            width: 7,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child:
                            card.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/IMAGES/$card',
                                    fit: BoxFit.contain,
                                  ),
                                )
                                : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '1',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '1.png';
                              });
                              if (role == true) {
                                addCurrentCard(1);
                                print("[INFO] Batting so updating 1");
                              } else {
                                updateCard(1);
                              }
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '2',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '2.png';
                              });
                              if (role == true) {
                                addCurrentCard(2);
                                print("[INFO] Batting so updating 2");
                              } else {
                                updateCard(2);
                              }
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '3',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '3.png';
                              });
                              if (role == true) {
                                addCurrentCard(3);
                                print("[INFO] Batting so updating 3");
                              } else {
                                updateCard(3);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        children: [
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '4',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '4.png';
                              });
                              if (role == true) {
                                addCurrentCard(4);
                                print("[INFO] Batting so updating 4");
                              } else {
                                updateCard(4);
                              }
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '5',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '5.png';
                              });
                              if (role == true) {
                                addCurrentCard(5);
                                print("[INFO] Batting so updating 5");
                              } else {
                                updateCard(5);
                              }
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '6',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '6.png';
                              });
                              if (role == true) {
                                addCurrentCard(6);
                                print("[INFO] Batting so updating 6");
                              } else {
                                updateCard(6);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.13),
                  child: Row(
                    children: [
                      _CircleContainer(
                        screenWidth,
                        screenHeight,
                        'assets/IMAGES/shock.png',
                      ),
                      SizedBox(width: screenWidth * 0.3),
                      GestureDetector(
                        onTap:
                            () => {
                              if (role == true)
                                {addCurrentCard(1)}
                              else
                                {updateCard(1)},
                            },
                        child: _CircleContainer(
                          screenWidth,
                          screenHeight,
                          'assets/IMAGES/dot.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
  return GestureDetector(
    onTap: onTap,
    child: Container(
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
    ),
  );
}

Widget _ContainerSet(double screenWidth, double screenHeight) {
  return Container(
    height: screenHeight * 0.25,
    width: screenWidth * 0.9,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              _bigContainer(
                screenWidth,
                screenHeight,
                text: '',
                color: const Color(0xFFD19837),
                height_: 0.07,
                width_: 0.21,
                font_size: 0.10,
              ),
              SizedBox(width: screenWidth * 0.05),
              _bigContainer(
                screenWidth,
                screenHeight,
                text: '',
                color: const Color(0xFFD19837),
                height_: 0.07,
                width_: 0.21,
                font_size: 0.10,
              ),
              SizedBox(width: screenWidth * 0.05),
              _bigContainer(
                screenWidth,
                screenHeight,
                text: '',
                color: const Color(0xFFD19837),
                height_: 0.07,
                width_: 0.21,
                font_size: 0.10,
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        _bigContainer(
          screenWidth,
          screenHeight,
          text: '',
          color: const Color(0xFFD19837),
          height_: 0.07,
          width_: 0.85,
          font_size: 0.12,
        ),
      ],
    ),
  );
}

Widget _CircleContainer(
  double screenWidth,
  double screenHeight,
  String? imagePath,
) {
  return Container(
    height: screenHeight * 0.2,
    width: screenWidth * 0.2,
    decoration: BoxDecoration(
      color: const Color(0xFFD19837),
      shape: BoxShape.circle,
    ),
    padding: const EdgeInsets.all(6),
    child:
        imagePath != null && imagePath.isNotEmpty
            ? ClipOval(child: Image.asset(imagePath, fit: BoxFit.contain))
            : const SizedBox.shrink(),
  );
}
