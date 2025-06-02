import 'package:app/Result/page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String card = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: const Color(0xFFD13737),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                _ContainerSet(screenWidth, screenHeight),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.12),
                  child: Row(
                    children: [
                      _bigContainer(
                        screenWidth,
                        screenHeight,
                        text: '',
                        color: const Color(0xFFD13737),
                        height_: 0.20,
                        width_: 0.35,
                        font_size: 0.12,
                        border: Border.all(color: Color(0xFF715018), width: 7),
                      ),
                      SizedBox(width: screenWidth * 0.05),

                      /// ✅ SHOW IMAGE INSTEAD OF TEXT
                      Container(
                        height: screenHeight * 0.20,
                        width: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD13737),
                          border: Border.all(color: const Color(0xFF715018), width: 7),
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: card.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/IMAGES/$card',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '1',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '1.png';
                              });
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '2',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '2.png';
                              });
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '3',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '3.png';
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        children: [
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '4',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '4.png';
                              });
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '5',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '5.png';
                              });
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          _bigContainer(
                            screenWidth,
                            screenHeight,
                            text: '6',
                            color: const Color(0xFFD13737),
                            height_: 0.07,
                            width_: 0.21,
                            font_size: 0.10,
                            onTap: () {
                              setState(() {
                                card = '6.png';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.13),
                  child: Row(
                    children: [
                      _CircleContainer(
                        screenWidth,
                        screenHeight,
                        'assets/IMAGES/shock.png',
                      ),
                      SizedBox(width: screenWidth * 0.3),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(),
                          ),
                        ),
                        child: _CircleContainer(
                          screenWidth,
                          screenHeight,
                          'assets/IMAGES/dot.png',
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
  Border? border,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: screenHeight * height_,
      width: screenWidth * width_,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
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
    ),
  );
}

Widget _ContainerSet(double screenWidth, double screenHeight) {
  return Container(
    height: screenHeight * 0.25,
    width: screenWidth * 0.9,
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
          text: '',
          color: const Color(0xFFD19837),
          height_: 0.07,
          width_: 0.85,
          font_size: 0.12,
        ),
      ],
    ),
  );
}

Widget _CircleContainer(
  double screenWidth,
  double screenHeight,
  String? imagePath,
) {
  return Container(
    height: screenHeight * 0.2,
    width: screenWidth * 0.2,
    decoration: BoxDecoration(
      color: const Color(0xFFD19837),
      shape: BoxShape.circle,
    ),
    padding: const EdgeInsets.all(6),
    child: imagePath != null && imagePath.isNotEmpty
        ? ClipOval(child: Image.asset(imagePath, fit: BoxFit.contain))
        : const SizedBox.shrink(),
  );
}
