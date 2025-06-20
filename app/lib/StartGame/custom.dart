import 'package:app/Bot/RLAgentPage.dart';
import 'package:app/StartGame/Toss.dart';
import 'package:app/StartGame/addplayer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart'; // Make sure this import points to the correct file where FlipTossPage is defined

class Custom extends StatefulWidget {
  const Custom({Key? key}) : super(key: key);

  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  final TextEditingController _Overscontroller = TextEditingController();
  final TextEditingController _WicketsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.07;

    late final overs = int.parse(_Overscontroller.text);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                                'Custom',
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
                SizedBox(height: screenHeight * 0.09),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Row(
                    children: [
                      _bigContainer(
                        screenWidth,
                        screenHeight,
                        text: 'Overs',
                        color: const Color(0xFFD13737),
                        height_: 0.10,
                        width_: 0.40,
                        font_size: 0.10,
                      ),
                      SizedBox(width: screenWidth * 0.12),
                      TextContainer(
                        screenWidth,
                        screenHeight,
                        color: const Color(0xFFD19837),
                        height_: 0.10,
                        width_: 0.25,
                        font_size: 0.10,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Row(
                    children: [
                      _bigContainer(
                        screenWidth,
                        screenHeight,
                        text: 'Wickets',
                        color: const Color(0xFFD13737),
                        height_: 0.10,
                        width_: 0.40,
                        font_size: 0.10,
                      ),
                      SizedBox(width: screenWidth * 0.12),
                      TextContainer(
                        screenWidth,
                        screenHeight,
                        color: const Color(0xFFD19837),
                        height_: 0.10,
                        width_: 0.25,
                        font_size: 0.10,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: 48.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Addplayer(),
                              ),
                            ),
                        child: _bigContainer(
                          screenWidth,
                          screenHeight,
                          text: 'Add',
                          color: const Color(0xFFD13737),
                          height_: 0.10,
                          width_: 0.35,
                          font_size: 0.10,
                          imagePath: 'assets/IMAGES/player.png',
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.07),
                      GestureDetector(
                        child: _bigContainer(
                          screenWidth,
                          screenHeight,
                          text: 'Bot',
                          color: const Color(0xFFD13737),
                          height_: 0.10,
                          width_: 0.35,
                          font_size: 0.10,
                          imagePath: 'assets/IMAGES/bot.png',
                        ),
                        onTap:
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => RLAgentPage(overs: overs),
                                ),
                              ),
                            },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.15),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.001),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlipTossPage(),
                        ), // Replace `NextPage` with your target page widget
                      );
                    },
                    child: _bigContainer(
                      screenWidth,
                      screenHeight,
                      text: 'START GAME',
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
  double height_ = 0,
  double width_ = 0,
  String text = '',
  Color color = const Color(0xFFD19837),
  double font_size = 0,
  TextEditingController? Controll,
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
      child: Expanded(
        child: TextField(
          controller: Controll,
          style: GoogleFonts.judson(
            fontSize: screenWidth * font_size,
            color: const Color(0xFFD9D9D9),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,

            contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
          ),
        ),
      ),
    ),
  );
}
