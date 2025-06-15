/*
===============================================================
🏏 CCSL Bot — Reinforcement Learning Summary
===============================================================

This bot uses a **lightweight Q-learning algorithm** to simulate 
strategic card selection in the Cricket Card Strategy League (CCSL).

---------------------------------------------------------------
🎯 Problem Setting
---------------------------------------------------------------
- Game: Turn-based card game where players play 0, 1, 2, 3, 4, or 6.
- Goal: Choose the best card for each situation to maximize total runs.
- Constraints: Real-world rules like cooldowns, free hit, and power card usage.
- State: Compressed into 4 key parameters:
    → Turn (T): 1 to 6
    → Power cards left (P): 0, 1, or 2
    → Cooldown active (C): 0 or 1
    → Free hit active (F): 0 or 1

    Format: "T{n}_P{n}_C{n}_F{n}"

- Action: The card to be played → one of [0, 1, 2, 3, 4, 6]

---------------------------------------------------------------
🤖 Reinforcement Learning Method: Q-Learning
---------------------------------------------------------------
Q-Learning updates a Q-table of expected rewards based on:

    Q(s, a) ← Q(s, a) + α * (reward + γ * max(Q(s’, a’)) - Q(s, a))

Where:
    - Q(s, a): Current Q-value for state `s` and action `a`
    - α (alpha): Learning rate (how much we trust new info)
    - γ (gamma): Discount factor (importance of future rewards)
    - s': Next state
    - a': Next best action

---------------------------------------------------------------
📦 Storage Format (Firebase/Local JSON)
---------------------------------------------------------------
Each key is a game state string like "T3_P1_C1_F0"

Each value is a map of possible actions and their learned Q-values:

{
  "T3_P1_C1_F0": {
    "0": 1.0,
    "1": 1.4,
    "2": 2.1,
    "3": 1.3,
    "4": 0.9,
    "6": -5.0
  },
  ...
}

---------------------------------------------------------------
🧠 At Runtime:
---------------------------------------------------------------
1. Game context → mapped to current state key
2. Bot selects the action with the highest Q-value
3. Game logic enforces rules (e.g., cooldown, no consecutive 6s)
4. Bot adapts based on training reward updates

---------------------------------------------------------------
🧰 Benefits:
---------------------------------------------------------------
✅ Lightweight and fast
✅ Firebase-friendly
✅ Expandable to more rules or deeper states
✅ Easily pluggable into Dart/Flutter game logic

===============================================================
*/


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final DatabaseReference ref = FirebaseDatabase.instance.ref('RLAgentData');

  final turns = [1, 2, 3, 4, 5, 6];
  final powerCards = [0, 1, 2];
  final cooldowns = [0, 1];
  final freeHits = [0, 1];

  final Map<String, Map<String, double>> rlAgentData = {};

  for (var t in turns) {
    for (var p in powerCards) {
      for (var c in cooldowns) {
        for (var f in freeHits) {
          final key = 'T${t}_P${p}_C${c}_F${f}';
          rlAgentData[key] = {
            "0": 0.0,
            "1": 0.0,
            "2": 0.0,
            "3": 0.0,
            "4": 0.0,
            "6": 0.0
          };
        }
      }
    }
  }

  await ref.set(rlAgentData);
  print("Uploaded ${rlAgentData.length} RL states to Firebase.");
}

