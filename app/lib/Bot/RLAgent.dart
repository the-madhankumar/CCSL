import 'package:app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('✅ Firebase Initialized');

  final ref1 = FirebaseDatabase.instance.ref('RLAgentDataBowling');
  final ref2 = FirebaseDatabase.instance.ref('RLAgentDataBatting');

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
            "6": 0.0,
          };
        }
      }
    }
  }

  await ref1.set(rlAgentData);
  await ref2.set(rlAgentData);
  print("✅ Q-table uploaded with ${rlAgentData.length} states and string keys.");
  
  runApp(const PlaceholderApp());
}

class PlaceholderApp extends StatelessWidget {
  const PlaceholderApp({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
