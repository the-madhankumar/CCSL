import 'package:app/StartGame/About.dart';
import 'package:app/StartGame/custom.dart';
import 'package:app/StartGame/rule.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartGame extends StatelessWidget {
  const StartGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.07;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: IntrinsicHeight(
            child: Container(
              color: const Color(0xFFD13737),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          color: const Color(0x40D9D9D9),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image(
                                height: screenHeight * 0.12,
                                width: screenWidth * 0.25,
                                image: const AssetImage(
                                  'assets/IMAGES/removed-background.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: Text(
                                'Cricket Card Strategy League',
                                style: GoogleFonts.judson(
                                  fontSize: fontSize,
                                  color: const Color(0xFFF9DDDD),
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _bigContainer(
                          screenWidth,
                          screenHeight,
                          text: '3',
                          color: const Color(0xFFD19837),
                          height_: 0.10,
                          width_: 0.25,
                          font_size: 0.10,
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        _bigContainer(
                          screenWidth,
                          screenHeight,
                          text: '5',
                          color: const Color(0xFFD19837),
                          height_: 0.10,
                          width_: 0.25,
                          font_size: 0.10,
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        _bigContainer(
                          screenWidth,
                          screenHeight,
                          text: '10',
                          color: const Color(0xFFD19837),
                          height_: 0.10,
                          width_: 0.25,
                          font_size: 0.10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.001),
                    child: GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Custom()),
                          ),
                      child: _bigContainer(
                        screenWidth,
                        screenHeight,
                        text: 'Custom',
                        color: const Color(0xFFD19837),
                        height_: 0.10,
                        width_: 0.85,
                        font_size: 0.12,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Text(
                      'LET\'S PLAY',
                      style: GoogleFonts.jacquesFrancoisShadow(
                        fontSize: screenWidth * 0.12,
                        color: const Color(0xFFD9D9D9),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.001),
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
                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.09),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => About()),
                              ),
                          child: _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: 'About',
                            color: const Color(0xFFD13737),
                            height_: 0.10,
                            width_: 0.35,
                            font_size: 0.10,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.09),
                        GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Rule()),
                              ),
                          child: _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: 'Rules',
                            color: const Color(0xFFD13737),
                            height_: 0.10,
                            width_: 0.35,
                            font_size: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
      child: Text(
        text,
        style: GoogleFonts.judson(
          fontSize: screenWidth * font_size,
          color: const Color(0xFFD9D9D9),
        ),
      ),
    ),
  );
}
