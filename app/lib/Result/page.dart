import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  final int score1;
  final int score2;
  final String winner;
  const ResultPage({
    Key? key,
    required this.score1,
    required this.score2,
    required this.winner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.07;

    return Scaffold(
      body: Container(
        color: const Color(0xFFD13737),
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
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Image.asset(
                          'assets/IMAGES/flagpng.png',
                          height: screenHeight * 0.5,
                          width: screenHeight * 0.1,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Result',
                            style: GoogleFonts.jacquesFrancoisShadow(
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
            SizedBox(height: screenHeight * 0.01),
            _ContainerSet(screenWidth, screenHeight, score1),
            SizedBox(height: screenHeight * 0.05),
            _ContainerSet(screenWidth, screenHeight, score2),
            SizedBox(height: screenHeight * 0.05),
            Container(
              height: screenHeight * 0.10,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: const Color(0x40D9D9D9),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              alignment: Alignment.centerLeft,

              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    child: Image.asset(
                      'assets/IMAGES/MOMpng.png',
                      height: screenHeight * 0.08,
                      width: screenHeight * 0.08,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    winner,
                    style: GoogleFonts.judson(
                      fontSize: screenWidth * 0.12,
                      color: const Color(0xFFD9D9D9),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

Widget _ContainerSet(double screenWidth, double screenHeight, int score) {
  return Container(
    height: screenHeight * 0.25,
    width: screenWidth * 0.9,
    decoration: BoxDecoration(
      color: const Color(0x40D9D9D9),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              _bigContainer(
                screenWidth,
                screenHeight,
                text: '',
                color: const Color(0xFFD19837),
                height_: 0.07,
                width_: 0.21,
                font_size: 0.10,
              ),
              SizedBox(width: screenWidth * 0.05),
              _bigContainer(
                screenWidth,
                screenHeight,
                text: '',
                color: const Color(0xFFD19837),
                height_: 0.07,
                width_: 0.21,
                font_size: 0.10,
              ),
              SizedBox(width: screenWidth * 0.05),
              _bigContainer(
                screenWidth,
                screenHeight,
                text: '',
                color: const Color(0xFFD19837),
                height_: 0.07,
                width_: 0.21,
                font_size: 0.10,
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        _bigContainer(
          screenWidth,
          screenHeight,
          text: score.toString(),
          color: const Color(0xFFD19837),
          height_: 0.10,
          width_: 0.85,
          font_size: 0.12,
        ),
      ],
    ),
  );
}
