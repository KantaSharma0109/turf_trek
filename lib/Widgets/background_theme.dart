import 'package:flutter/material.dart';

BoxDecoration BackGroundTheme() {
  return BoxDecoration(
    color: Colors.yellow.shade50,
    image: DecorationImage(
      image: AssetImage(
        'assets/images/sports_booking.jpeg',
      ),
    ),
  );
}