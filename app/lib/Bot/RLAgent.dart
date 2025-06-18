import 'dart:math';
import 'package:app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('✅ Firebase Initialized');

  final DatabaseReference bowlingRef = FirebaseDatabase.instance.ref('RLAgentDataBowling');
  final DatabaseReference battingRef = FirebaseDatabase.instance.ref('RLAgentDataBatting');

  const List<int> cooldowns = [0, 1];
  const List<int> freeHits = [0, 1];
  const int maxT = 30;
  const int maxP = 10;
  const int totalActions = 7;

  final Random random = Random(); // Random generator
  final Map<String, Map<String, double>> qTable = {};

  for (int t = 0; t <= maxT; t++) {
    for (int p = 0; p <= maxP; p++) {
      for (int c in cooldowns) {
        for (int f in freeHits) {
          final String stateKey = 'T${t}_P${p}_C${c}_F${f}';

          final Map<String, double> actionValues = {
            for (int a = 0; a < totalActions; a++) 'A$a': random.nextDouble(),
          };

          qTable[stateKey] = actionValues;
        }
      }
    }
  }

  // Confirm total expected states
  final int expectedStates = (maxT + 1) * (maxP + 1) * cooldowns.length * freeHits.length;
  assert(qTable.length == expectedStates, '❌ State count mismatch');

  print("🔍 Total States: ${qTable.length} (Expected: $expectedStates)");

  // Clean old data
  await bowlingRef.remove();
  await battingRef.remove();
  print("🗑️ Old Q-tables deleted");

  // Upload new Q-tables
  await bowlingRef.set(qTable);
  await battingRef.set(qTable);
  print("✅ Q-table uploaded successfully with random Q-values");

  runApp(const PlaceholderApp());
}

class PlaceholderApp extends StatelessWidget {
  const PlaceholderApp({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
