import 'package:app/dataStructure.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('✅ Firebase Initialized');

  final DatabaseReference ref = FirebaseDatabase.instance.ref('games/123456'); // cleaner path

  final game = Game(
    gameId: '123456',
    status: 'started',
    winner: null,
    players: {
      'uid1': Player(
        name: 'Madhan',
        currentCard: '',
        score: 0,
        isDone: false,
      ),
      'uid2': Player(
        name: 'Vicky',
        currentCard: '',
        score: 0,
        isDone: false,
      ),
    },
  );

  await ref.set(game.toJson());
  print("✅ Game created and uploaded successfully");
}

class PlaceholderApp extends StatelessWidget {
  const PlaceholderApp({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
