import 'package:flutter/material.dart';

class StartGame extends StatelessWidget {
  const StartGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFD13737),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Optional
          children: [
            Align(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 20,
                  width: 500,
                  color: const Color.fromARGB(78, 0, 0, 0),
                  child: Image(
                    image: AssetImage('IMAGES/removed-background.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
