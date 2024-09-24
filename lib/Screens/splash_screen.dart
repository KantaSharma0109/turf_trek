import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:turf_trek/Screens/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFDEB),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/sports_booking.jpeg',
            ),
          ),
        ),
        /*child:  BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              //color: Colors.transparent, // Make content area transparent
              // Your other widgets here
            ),
          ),
        ),*/
      ),
    );
  }
}
