import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('✅ Firebase Initialized');

  final dbRef = FirebaseDatabase.instance.ref('/RLAgentDataBowling');
  final snapshot = await dbRef.get();

  if (snapshot.exists && snapshot.value is Map) {
    final rawMap = Map<String, dynamic>.from(snapshot.value as Map);

    print('✅ Loaded ${rawMap.length} total states');
    
    // Print first 5 entries (sample check)
    int count = 0;
    for (final entry in rawMap.entries) {
      print('\n📌 State: ${entry.key}');
      if (entry.value is Map) {
        final actionMap = Map<String, dynamic>.from(entry.value);
        for (final action in actionMap.entries) {
          print('   ➤ Action: ${action.key} → Q-value: ${action.value}');
        }
      } else {
        print('   ⚠️ Invalid format for state ${entry.key}');
        print(entry);
      }

      count++;
      if (count >= 5) break;
    }
  } else {
    print('[ERROR] Q-table data missing or invalid!');
  }

  runApp(const PlaceholderApp());
}

class PlaceholderApp extends StatelessWidget {
  const PlaceholderApp({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
