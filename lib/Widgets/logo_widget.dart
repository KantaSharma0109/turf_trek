import 'package:flutter/material.dart';

Widget LogoSign({double size = 80.0}) {
  return Center(
    child: ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Color(0xFF326A1A),
          Color(0xFF568C3F),
          Color(0xFF4DAC24),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
      ).createShader(bounds),
      child: Text(
        'Turf Trek',
        style: TextStyle(
          fontFamily: 'FontLogo',
          color: Colors.white,
          fontSize: size,
        ),
      ),
    ),
  );
}