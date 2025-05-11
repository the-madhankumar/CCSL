import 'package:app/GamePage/page.dart';
import 'package:app/StartGame/addplayer.dart';
import 'package:app/StartGame/page.dart';
import 'package:app/StartGame/custom.dart';
import 'package:app/Result/page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartGame(),
    );
  }
}
