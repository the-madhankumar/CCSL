import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MaterialApp(home: RLAgentPage(), debugShowCheckedModeBanner: false),
  );
}

class RLAgentPage extends StatefulWidget {
  const RLAgentPage({super.key});

  @override
  State<RLAgentPage> createState() => _RLAgentPageState();
}

class _RLAgentPageState extends State<RLAgentPage> {
  bool? dataExists;

  int? Turn;
  int? powerCards;
  bool? isFreeHit;
  bool? isCoolDown;

  @override
  void initState() {
    super.initState();
    checkDataExists();
  }

  Future<void> checkDataExists() async {
    final dbRef = FirebaseDatabase.instance.ref('/RLAgentDataBowling');
    final snapshot = await dbRef.get();

    setState(() {
      dataExists = snapshot.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RL Agent Data Viewer")),
      body: Center(
        child: Text(
          dataExists == null ? "Loading..." : "Data Exists: $dataExists",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
