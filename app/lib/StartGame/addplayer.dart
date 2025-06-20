import 'package:app/GamePage/page.dart';
import 'package:app/StartGame/toss.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class Addplayer extends StatefulWidget {
  const Addplayer({Key? key}) : super(key: key);

  @override
  State<Addplayer> createState() => _AddplayerState();
}

class _AddplayerState extends State<Addplayer> {
  final TextEditingController _playercontroller = TextEditingController();
  late final int randomNumber;

  @override
  void initState() {
    super.initState();
    // Generate the random number once
    var random = math.Random();
    randomNumber = 100000 + random.nextInt(900000);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.07;

    return Scaffold(
      body: Container(
        color: const Color(0xFFD13737),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.9,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            child: Image.asset(
                              'assets/IMAGES/settingsicon.png',
                              height: screenHeight * 0.5,
                              width: screenHeight * 0.1,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Add Player',
                                style: GoogleFonts.judson(
                                  fontSize: screenHeight * 0.06,
                                  color: const Color(0xFFF9DDDD),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.001),
                  child: _bigContainer(
                    screenWidth,
                    screenHeight,
                    text: 'Create Room',
                    color: const Color(0xFFD13737),
                    height_: 0.10,
                    width_: 0.85,
                    font_size: 0.12,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.001),
                  child: TextContainer(
                    screenWidth,
                    screenHeight,
                    text: 'Enter your username',
                    color: const Color(0xFFD13737),
                    height_: 0.10,
                    width_: 0.85,
                    font_size: 0.12,
                    Controll: _playercontroller,
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.001),
                  child: _bigContainer(
                    screenWidth,
                    screenHeight,
                    text: randomNumber.toString(),
                    color: const Color(0xFFD19837),
                    height_: 0.10,
                    width_: 0.85,
                    font_size: 0.12,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.01),
                  child: _bigContainer(
                    screenWidth,
                    screenHeight,
                    text: 'Accept',
                    color: const Color(0xFFD13737),
                    height_: 0.10,
                    width_: 0.30,
                    font_size: 0.09,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FlipTossPage()),
                      ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.001),
                    child: _bigContainer(
                      screenWidth,
                      screenHeight,
                      text: 'Start Game',
                      color: const Color(0xFFD13737),
                      height_: 0.10,
                      width_: 0.85,
                      font_size: 0.12,
                    ),
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
  String? imagePath,
}) {
  return Container(
    height: screenHeight * height_,
    width: screenWidth * width_,
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Image.asset(
                imagePath,
                height: screenHeight * 0.1,
                width: screenWidth * 0.1,
                fit: BoxFit.contain,
              ),
            ),
          Text(
            text,
            style: GoogleFonts.judson(
              fontSize: screenWidth * font_size,
              color: const Color(0xFFD9D9D9),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget TextContainer(
  double screenWidth,
  double screenHeight, {
  String text = '',
  Color color = const Color(0xFFD19837),
  double height_ = 0,
  double width_ = 0,
  double font_size = 0,
  TextEditingController? Controll,
}) {
  return Container(
    height: screenHeight * height_,
    width: screenWidth * width_,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 2,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: TextField(
          controller: Controll,
          style: GoogleFonts.judson(
            fontSize: screenWidth * 0.1,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: text,
            floatingLabelBehavior:
                (Controll?.text.isNotEmpty ?? false)
                    ? FloatingLabelBehavior.always
                    : FloatingLabelBehavior.auto,
            labelStyle: GoogleFonts.judson(
              fontSize: screenWidth * font_size * 0.9,
              color: Colors.white70,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromARGB(0, 255, 255, 255),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          cursorColor: Colors.white,
        ),
      ),
    ),
  );
}
