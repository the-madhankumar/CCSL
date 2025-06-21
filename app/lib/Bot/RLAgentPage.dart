import 'package:app/Result/page.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer;
import 'dart:math';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class RLAgentPage extends StatefulWidget {
  final int overs;
  const RLAgentPage({super.key, required this.overs});

  @override
  State<RLAgentPage> createState() => _RLAgentPageState();
}

class _RLAgentPageState extends State<RLAgentPage> {
  bool? dataExists;
  Map<String, dynamic> qTable = {};
  String card = '';
  int botCard = 0;
  String boTCard = '';

  int over = 2;
  late int powerCard;
  late int totalBalls;
  List<int> trackOver = [];
  bool freeHit = false;
  bool cooldown = false;
  int player1 = 0;
  int botScore = 0;

  @override
  void initState() {
    super.initState();
    powerCard = over * 2;
    totalBalls = over * 6;
    loadQTable();
  }

  void addCurrentCard(int currentBall) {
    setState(() {
      trackOver.add(currentBall);
      player1 = (player1 + currentBall);
    });
  }

  void onCardTap(int value) {
    setState(() {
      addCurrentCard(value);
      card = '$value.png';
    });
    handleCardPlay(value);
  }

  void setBotCard(int value) {
    if (value == 0) {
      setState(() {
        boTCard = 'dot.png';
      });
    } else {
      setState(() {
        boTCard = '$value.png';
      });
    }
  }

  double valueAsDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    throw Exception('Q-value is not a number: $v');
  }

  Future<void> handleCardPlay(int currentCard) async {
    int turn = trackOver.length % 7;
    if (trackOver.length > totalBalls) {
      print("[SCORE] your score : $player1");
      return;
    }
    String currentState =
        'T${turn}_P${powerCard}_C${cooldown ? 1 : 0}_F${freeHit ? 1 : 0}';

    bool isOut = currentCard == 6 && !freeHit;
    bool usedPower = currentCard == 4 || currentCard == 6;

    double reward = 0;
    if (isOut) {
      reward = -5.0;
      freeHit = true;
    } else {
      reward = currentCard.toDouble();
      freeHit = false;
    }

    if (currentCard == 6) {
      cooldown = true;
    } else {
      cooldown = false;
    }

    if (usedPower && powerCard > 0) {
      powerCard--;
    }

    int nextTurn = turn + 1;
    String nextState =
        'T${nextTurn}_P${powerCard}_C${cooldown ? 1 : 0}_F${freeHit ? 1 : 0}';

    await bellmanUpdate(
      currentState: currentState,
      action: currentCard.toString(),
      nextState: nextState,
      reward: reward,
    );

    debugPrint('📌 Played card: $currentCard');
    debugPrint('📊 Current State: $currentState');
    debugPrint('➡️ Next State: $nextState');
    debugPrint('🏏 Reward: $reward');

    // Bot plays after player
    botCard = getBestBotAction(nextState);
    debugPrint('[BOT] Best action from Q-table: $botCard');
    debugPrint('$botCard');
    setBotCard(botCard);
  }

  int getBestBotAction(String state) {
    if (!qTable.containsKey(state)) return 0;

    try {
      final stateMap = Map<String, dynamic>.from(qTable[state]);
      print('[DEBUG] Keys in state "$state": ${stateMap.keys.toList()}');

      double maxScore = double.negativeInfinity;
      int bestAction = 0;

      for (var entry in stateMap.entries) {
        final key = entry.key;
        final value = (entry.value as num?)?.toDouble() ?? 0.0;

        if (key.startsWith("A")) {
          final actionNum = int.tryParse(key.substring(1));
          if (actionNum != null && value > maxScore) {
            maxScore = value;
            bestAction = actionNum;
          }
        }
      }

      return bestAction;
    } catch (e) {
      print('[BOT ERROR] Failed to get best action for state $state: $e');
      return 0;
    }
  }

  Future<void> loadQTable() async {
    final dbRef = FirebaseDatabase.instance.ref('/RLAgentDataBowling');
    final snapshot = await dbRef.get();

    if (!snapshot.exists || snapshot.value == null) {
      print('[ERROR] Q-table data is missing or null.');
      setState(() => dataExists = false);
      return;
    }

    try {
      final rawMap = Map<String, dynamic>.from(snapshot.value as Map);

      final parsedQTable = <String, Map<String, double>>{};

      for (var entry in rawMap.entries) {
        final state = entry.key;
        final actions = entry.value;

        if (actions is Map) {
          final actionMap = <String, double>{};

          actions.forEach((k, v) {
            try {
              final key = k.toString();
              final value = (v as num).toDouble();
              actionMap[key] = value;
            } catch (e) {
              print('[WARNING] Invalid action value for "$state" → "$k": $e');
            }
          });

          parsedQTable[state] = actionMap;
        } else {
          print('[WARNING] Skipping "$state" — not a valid action map');
        }
      }

      setState(() {
        qTable = parsedQTable;
        dataExists = true;
      });

      print('✅ Q-table loaded with ${qTable.length} states');
    } catch (e) {
      print('[ERROR] Failed to parse Q-table snapshot: $e');
      setState(() => dataExists = false);
    }
  }

  Future<void> bellmanUpdate({
    required String currentState,
    required String action,
    required String nextState,
    required double reward,
    double alpha = 0.1,
    double gamma = 0.9,
  }) async {
    print("[INFO] Entering Bellman update");

    if (!qTable.containsKey(currentState) || !qTable.containsKey(nextState)) {
      print('[ERROR] Missing state(s): $currentState or $nextState');
      return;
    }

    // Convert state maps safely
    final currentStateMap = Map<String, double>.from(
      Map<String, dynamic>.from(qTable[currentState] ?? {})
        ..removeWhere((k, _) => !k.startsWith("A")),
    );

    final nextStateMap = Map<String, double>.from(
      Map<String, dynamic>.from(qTable[nextState] ?? {})
        ..removeWhere((k, _) => !k.startsWith("A")),
    );

    // Ensure the action exists
    if (!currentStateMap.containsKey(action)) {
      print(
        '[ERROR] Action "$action" not found in current state "$currentState"',
      );
      return;
    }

    // Q-learning Bellman update
    final oldQ = currentStateMap[action] ?? 0.0;
    final maxNextQ = nextStateMap.values.fold<double>(
      double.negativeInfinity,
      (a, b) => a > b ? a : b,
    );
    final newQ = oldQ + alpha * (reward + gamma * maxNextQ - oldQ);

    // Update in local Q-table
    currentStateMap[action] = newQ;
    qTable[currentState] = currentStateMap;

    // Sync with Firebase
    final ref = FirebaseDatabase.instance.ref(
      '/RLAgentDataBowling/$currentState',
    );
    await ref.set(currentStateMap);

    print("✅ Q-value updated for [$currentState][$action] = $newQ");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                            boTCard.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/IMAGES/$boTCard',
                                    fit: BoxFit.contain,
                                  ),
                                )
                                : const SizedBox.shrink(),
                      ),
                      SizedBox(width: screenWidth * 0.05),

                      /// ✅ SHOW IMAGE INSTEAD OF TEXT
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
                            onTap: () => onCardTap(1),
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
                            onTap: () => onCardTap(2),
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
                            onTap: () => onCardTap(3),
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
                            onTap: () => onCardTap(4),
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
                            onTap: () => onCardTap(5),
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
                            onTap: () => onCardTap(6),
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
                        onTap: () => onCardTap(6),
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
